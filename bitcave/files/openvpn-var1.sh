#!/bin/sh
##  Bitcave - Project  (c)2015 GPL-3
##     Matthias Strubel  <matthias.strubel@aod-rpg.de>
##
## The following script is for the iface-up hook of OpenVPN
##    as a replace for the auto-distribution of routes into the routing table.
##
##  It fixes the Problem with VPN hosts like IPredator, which have the VPN Server
##     in the same subnet like the VPN-tun interface have. So the VPN-Server must
##     be routed via a static route through the default gateway.
##
##  It uses the following variables from the exported environment by OpenVPN
##      - $trusted_ip    	<- The VPN-Server's IP   
##                                (Create a static route through the original Gateway)
##      - $dev			<- tun device name
## 	  - $ifconfig_local	<- IP address of the tun interface
##      - $config			<- configuration file of the running OpenVPN process
##					(Used for storing data for the down script)
##      
##  Based upon $dev, a lookup of the connected interface (currently only one)
##  is done and routing is setup, if not already configured.
##
##  The trusted IP & ifconfig_local is saved for the interface down hook of OpenVPN
##  
##   The Table alias is generated during Bitcave-Initialization an can be found in
##    	 /etc/iproute2/rt_tables 
##

run_up(){
	logger "UP-Script var1 Working for  $config"

	## We are using a for setup, even if we currently have only one interface attached via definition.
	for  lan_network_name in $( convert_tun_to_lan.sh $dev ) ; do
		if  [ "$lan_network_name" == "br-lan" ] ; then 
			logger "For setting the default interface, don't use route-nopoll with this script. Skipping."
			continue
		fi
		logger "Working on $lan_network_name"
		table=$lan_network_name   				#alias is used
		
		# Transfer IP and Subnet to a network Identification with a bit-Mask and store it
		# as an environment variable
		ipcalc.sh $(uci get "network.${lan_network_name}.ipaddr" )  $( uci get "network.${lan_network_name}.netmask" )  > "/tmp/${config}_ipcalc.tmp"
		. "/tmp/${config}_ipcalc.tmp"
		rm  "/tmp/${config}_ipcalc.tmp"
		
		lan_network="${NETWORK}/${PREFIX}"
		
		# Enforce the VPN-Server IP be routed through the default gateway!
		def_gateway=$( ip route list | grep default | cut -d ' ' -f 3 )
		logger route  add -net $trusted_ip netmask 255.255.255.255 gw $def_gateway
		route add -net $trusted_ip netmask 255.255.255.255 gw $def_gateway

		# Add the rule only if it is not already existing
		ip rule list | grep -q "$lan_network"  || logger  ip rule add from "$lan_network" table $table
		ip rule list | grep -q "$lan_network"  || ip rule add from "$lan_network" table $table

		logger ip route add default via $ifconfig_local  dev $dev table $table
		ip route add default via $ifconfig_local  dev $dev table $table
		
		## Store  in /tmp, which is located in memory of OpenWrt devices
		##   which gets cleaned out like the routes through a restart.
		store_file="/tmp/route_cache_${config}_${lan_network_name}"
		
		logger "Storing configuration in $store_file"
		echo "# cache for cleaning up manually created routes
		lan_network=${lan_network}
		table=${table}
		ifconfig_local=${ifconfig_local}
		dev=${dev}
		trusted_ip=${trusted_ip}
		def_gateway=${def_gateway}
		" > $store_file
	done
}

run_down() {
	##  It cleans up the routes set by the "up"-script.
	##
	##   Uses the informations stored in 
	##		/tmp/route_cache_${config}_*
	##   While
	## 		$config is set in environment by OpenVPN
	##

	logger "Down-Script var1 working for $config"
	for  cache_file  in $( ls -1 /tmp/route_cache_${config}_* ) ; do
		. $cache_file
		
		logger "Cleaning up for device ${dev} , network ${lan_network}  and IP ${trusted_ip} "
		logger "route  del -net $trusted_ip netmask 255.255.255.255 gw $def_gateway"
		route del $trusted_ip 
		
		logger  "ip rule del from "$lan_network" table $table"
		ip rule del from "$lan_network" table $table	
		
		rm $cache_file
	done
}


case $script_type in

up)
	run_up
	/etc/openvpn/openvpn-dns.sh 
	;;
down)
	run_down
	/etc/openvpn/openvpn-dns.sh 
	;;
esac

logger ip route flush cache
ip route flush cache
