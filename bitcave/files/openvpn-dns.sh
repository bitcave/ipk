#!/bin/sh
##  Bitcave - Project  (c)2015 GPL-3
##     Matthias Strubel  <matthias.strubel@aod-rpg.de>
##
## The following script is for running inside the iface-up hook of OpenVPN
##  	   it sets and deletes a firewall rule from the incoming interface to the DNS server
## 	   delivered by VPN provider
##
##  It uses the following variables from the exported environment by OpenVPN
##      - $dev			<- tun device name
##      - $config			<- configuration file of the running OpenVPN process
##					(Used for storing data for the down script)
##      
##  Based upon $dev, a lookup of the connected interface (currently only one)
##  is done and routing is setup, if not already configured.
##
##  The trusted IP & ifconfig_local is saved for the interface down hook of OpenVPN
##  
##

DNS_Server=""
__extract_var(){
    local in_var="$1"
	
    part1=$(echo "$in_var" | cut -d " " -f 1)
    if [ "$part1" == "dhcp-option" ] ; then
      part2=$(echo "$in_var" | cut -d " " -f 2)
      part3=$(echo "$in_var" | cut -d " " -f 3)
      if [ "$part2" == "DNS" ] ; then
         DNS_Server="$part3"
      fi
    fi
    return 0
}
get_DNS_from_env(){

    [[ -z "$DNS_Server" ]] && __extract_var "$foreign_option_1" 
    [[ -z "$DNS_Server" ]] && __extract_var "$foreign_option_2" 
    [[ -z "$DNS_Server" ]] && __extract_var "$foreign_option_3" 
    return 0
}  

run_up(){
	logger "UP-Script dns Working for  $config"
	
        get_DNS_from_env                                                  
        if [ -z "$DNS_Server" ] ; then
                logger "Couldn't find DNS in pused option .. exiting"
                exit 0                                                      
        fi    
	
	## We are using a for setup, even if we currently have only one interface attached via definition.
	for  lan_network_name in $( convert_tun_to_lan.sh $dev ) ; do
		logger "Working on $lan_network_name"
		
		# Transfer IP and Subnet to a network Identification with a bit-Mask and store it
		# as an environment variable
		ipcalc.sh $(uci get "network.${lan_network_name}.ipaddr" )  $( uci get "network.${lan_network_name}.netmask" )  > "/tmp/${config}_ipcalc.tmp"
		. "/tmp/${config}_ipcalc.tmp"
		rm  "/tmp/${config}_ipcalc.tmp"
		
		lan_network="${NETWORK}/${PREFIX}"
		
		logger "iptables -t nat -I PREROUTING -s "${lan_network}" -p udp --dport 53 -j DNAT --to-destination $DNS_Server:53"
		iptables -t nat -I PREROUTING -s "${lan_network}" -p udp --dport 53 -j DNAT --to-destination $DNS_Server:53
		
		
		## Store  in /tmp, which is located in memory of OpenWrt devices
		##   which gets cleaned out like the routes through a restart.
		store_file="/tmp/dns_cache_${config}_${lan_network_name}"
		
		logger "Storing configuration in $store_file"
		echo "# cache for cleaning up manually created routes
		dev=${dev}
		lan_network=${lan_network}
		DNS_Server=${DNS_Server}
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

	logger "Down-Script dns working for $config"
	for  cache_file  in $( ls -1 /tmp/dns_cache_${config}_* ) ; do
		. $cache_file
		
		logger "Cleaning up iptables rule for device ${dev} & network ${lan_network}  "
		logger "iptables -t nat -D PREROUTING -s "${lan_network}" -p udp --dport 53 -j DNAT --to-destination $DNS_Server:53"
		iptables -t nat -D PREROUTING -s "${lan_network}" -p udp --dport 53 -j DNAT --to-destination $DNS_Server:53
		
		rm $cache_file
	done
}


case $script_type in

up)
	run_up
	;;
down)
	run_down
	;;
esac

