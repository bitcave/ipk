#!/bin/sh
##  Bitcave - Project  (c)2015 GPL-3
##     Matthias Strubel  <matthias.strubel@aod-rpg.de>
##
## The following script is for the iface-down hook of OpenVPN
##    as a replace for the auto-distribution of routes into the routing table.
##
##  It cleans up the routes set by the "up"-script.
##
##   Uses the informations stored in 
##		/tmp/route_cache_${config}_*
##   While
## 		$config is set in environment by OpenVPN
##

logger "Down-Script var1 working for $config"
for  cache_file  in $( ls -l /tmp/route_cache_${config}_* ) ; do
	. $cache_file
	
	logger "Cleaning up for device ${dev} , network ${lan_network}  and IP ${trusted_ip} "
	logger route  del -net $trusted_ip netmask 255.255.255.255 gw $def_getway
	route del -net $trusted_ip netmask 255.255.255.255 gw $def_getway
	
	logger  ip rule del from "$lan_network" table $table
	ip rule del from "$lan_network" table $table	
	
	logger ip route del default via $ifconfig_local  dev $dev table $table
	ip route del default via $ifconfig_local  dev $dev table $table

done
logger ip route flush cache
ip route flush cache
