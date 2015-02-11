#!/bin/sh

tun_tmpfile=/tmp/tmp_tun_script.log

max_vpn_settings=9  
device_prefix="tun"

# General starting point. 
#   The starting digit is count up for each configured bitcave_lan
#   starting with 172.29.29.1/   for  br-lan  (Bitcave_1)
#                        172.29.30.1 /   for  blan    (Bitcave_2) (wifi only)
#                        172.29.31.1 /   for  blan    (Bitcave_3) (wifi only)
# 
Default_Hostname="Bitcave"
ip_net="172.29"  
network_number_start=28
SSID_Name="Bitcave"
Default_Password="BitcaveC"  # Default password for Bitcave.Clear
bitcave_slots=3  #Generate which amount of interfaces

_get_firewall_zone_hole_name(){
	local hole_number="$1"
	echo "fw_hole${hole_number}"
}
_get_network_hole_name(){
	local hole_number="$1"
	echo "hole${hole_number}"
}

_get_firewall_zone_bitcave_name(){
	local bitcave_number="$1"
	echo "fw_blan${bitcave_number}"
}
_get_network_bitcave_name(){
	local hole_number="$1"
	echo "blan${hole_number}"
}


_set_network_bitcave(){
	local network_number="$1"
	
	local IP_network=$(( $network_number_start + network_number ))

	#bitcave_lan0 is br-lan interface
	if [ "$network_number" != "1" ] ; then
		local network_name=$( _get_network_bitcave_name "$network_number" )
		uci set network."${network_name}"=interface
		uci set network."${network_name}".force_link=1
		uci set network."${network_name}".proto=static
		uci set network."${network_name}".netmask=255.255.255.0
		uci set network."${network_name}".ipaddr="${ip_net}.${IP_network}.1"
		uci set network."${network_name}".ip6assign=60
		uci set network."${network_name}".type=bridge
	else
		uci set network.lan.ipaddr="${ip_net}.${IP_network}.1"
	fi
}

_set_dhcp_bitcave(){
	local network_number="$1"
	
	#bitcave_lan0 is br-lan interface
	# skip it
	[ "$network_number" = "1" ]  && return 0
	
	local network_name=$( _get_network_bitcave_name "$network_number" )
	uci set dhcp."${network_name}"=dhcp
	uci set dhcp."${network_name}".interface="${network_name}"
	uci set dhcp."${network_name}".start=100
	uci set dhcp."${network_name}".limit=150
	uci set dhcp."${network_name}".leasetime=12h
	#uci set dhcp."${network_name}".dhcpv6=server  #TODO, needed?
	#uci set dhcp."${network_name}".ra=server
	
}

_set_wifi_bitcave(){
	local network_number="$1"

	#bitcave_lan0 is br-lan interface
	if [ "$network_number" != "1" ] ; then
		local network_name=$( _get_network_bitcave_name "$network_number" )
		
		wifi=`uci add wireless wifi-iface`
		uci set wireless."$wifi".device=radio0
		uci set wireless."$wifi".mode=ap
		uci set wireless."$wifi".ssid="${SSID_Name}.${network_number}"
		uci set wireless."$wifi".network="${network_name}"
		uci set wireless."$wifi".disabled=1
		uci set wireless."$wifi".encryption=none
	else
		uci set "wireless.radio0.disabled=0"
		uci set wireless.@wifi-iface[0].ssid="${SSID_Name}.Clear"
		uci set wireless.@wifi-iface[0].encryption="psk2"
		uci set wireless.@wifi-iface[0].key="${Default_Password}"
		uci set wireless.@wifi-iface[0].disabled=0
	fi

}

## Responsible for tun interfaces
_set_network_hole(){
	local hole_num="$1"
	local hole_interface="$2"
	
	[ -z "$2" ] &&  hole_interface=""
	
	local hole_name=$(_get_network_hole_name "$hole_num" )
	

	echo "Setting up $hole_name interface in network"
	uci set network."$hole_name"=interface
	uci set network."$hole_name".ifname="$hole_interface"
	uci set network."$hole_name".option=none

	return 0
}


_get_firewall_zone_config_id(){
	local hole_number="$1"
	local network_name=$( _get_network_hole_name "$hole_number" )
	
	local id=$( uci show firewall | grep name=${network_name} | awk -F'[.=]' '{ print $2 }')
	
	## [ -z "$id" ]  && id="nf"
	firewall_zone="$id"
	return 0
}


_add_firewall_zone_hole(){
	local hole_number="$1"

	local zone_name=$( _get_firewall_zone_hole_name $hole_number  )

	echo "Adding firewall zone ${zone_name}  for hole"
	firewall=`uci add firewall zone`
	uci set firewall."$firewall".name="${zone_name}"
	uci set firewall."$firewall".network=$( _get_network_hole_name "$hole_number" )
	uci set firewall."$firewall".input=REJECT
	uci set firewall."$firewall".output=ACCEPT
	uci set firewall."$firewall".forward=REJECT
	uci set firewall."$firewall".masq=1
	uci set firewall."$firewall".mtu_fix=1
	zone_id="${firewall}"	
	return 0
}

_add_firwall_forward_rule(){
	local src="$1"
	local dest="$2"
	
	firewall=$(uci add firewall forwarding)
	uci set firewall."${firewall}".src="${src}"
	uci set firewall."${firewall}".dest="${dest}"
	firewall_forward="${firewall}"
	return 0
}

_check_firewall_forward_rule_exists(){
	local src="$1"
	local dest="$2"

	local fwd_ids=$(uci show firewall | grep =forwarding | awk -F'[.=]' '{ print $2 }')

	for  id in $fwd_ids ; do
		local uci_src=$(uci get firewall."${id}".src)
                local uci_dest=$(uci get firewall."${id}".dest)
		if  [ "$uci_src" = "$src"  ] && [ "$dest" = "$dest"  ]  ; then
			#echo "found $id"
			firewall_forward_id="$id"
			return 0
		fi
	done
	return 99
}

_del_firewall_forward_rule(){
	local uci_id=shift
	uci del firewall."$uci_id"
}

_check_firewall_zone_exists(){
	local zone_name="$1"

	local zone_ids=$(uci show firewall | grep =zone | awk -F'[.=]' '{ print $2 }')

	for  id in $zone_ids ; do
		local uci_name=$(uci get firewall."${id}".name)
		if  [ "$uci_name" = "$zone_name"  ]  ; then
			#echo "found $id"
			firewall_zone_id="$id"
			return 0
		fi
	done
	return 99
}

_add_firewall_zone_bitcave(){
	local bitcave_number="$1"
	
	#Don't work on bitcave_lan1 => br-lan
	[ "$bitcave_number" = "1" ] && return 0

	local zone_name=$(_get_firewall_zone_bitcave_name "${bitcave_number}" )

	echo "Adding firewall zone ${zone_name}  for bitcave"
	firewall=`uci add firewall zone`
	uci set firewall."$firewall".name="${zone_name}"
	uci set firewall."$firewall".network=$( _get_network_bitcave_name "$bitcave_number" )
	uci set firewall."$firewall".input=ACCEPT
	uci set firewall."$firewall".output=ACCEPT
	uci set firewall."$firewall".forward=ACCEPT
	uci set firewall."$firewall".masq=0
	uci set firewall."$firewall".mtu_fix=0
	zone_id="${firewall}"	
	return 0
}

_add_rt_alias(){
	local bitcave_number="$1"
	
	local net_name=$( _get_network_bitcave_name "$bitcave_number" )
	
	grep -q "$net_name" /etc/iproute2/rt_tables || \
		echo "10${bitcave_number}  ${net_name} "  >>  /etc/iproute2/rt_tables 

}

get_pid_of_VPN(){
	local uci_name="$1"
	pid=$( ps   | grep "${uci_name}" | grep openvpn | | cut -d ' ' -f2  )
	
	test -z $pid && return 99
	
	echo $pid 
	return 0
}


### Used for deinstalling a Bitcave-VPN setting
remove_vpn_setting(){
	local uci_name="$1"
	
	if   uci get opevpn."${uci_name}"  &> /dev/null ; then
		is_enabled=$(uci get openvpn"${uci_name}".enabled)
		
		# this is for self configured files. We can't do much.. only remove it
		if uci get openvpn."${uci_name}".config &> /dev/null ; then
			uci remove openvpn."${uci_name}"=openvpn
		else
		# Configured stuff needs to/can be removed from the setup hole configuration.
			local dev_name=$( uci get openvpn."${uci_name}".dev )
			local attached_interfaces=$( uci show network | grep $dev_name  | awk -F'[.=]' '{ print $2 }' )
			for net_name in  $attached_interfaces ; do   #usually only one
				uci delete network."${net_name}".ifname
			done
		fi
		
		if  [ "$is_enabled" == "1" ] ; then
			# Try to kill only corresponding process.
			local  pid=$( get_pid_of_VPN "${uci_name}" ) 
			if $? ; then
				kill $?
			fi
		fi
		
		uci remove openvpn."${uci_name}"=openvpn
	else
		echo "OpenVPN Entry ${uci_name} not found"
		return 99
	fi

}

check_max_tun_number() {
	local used_vpn_cnt=$(wc -l $tun_tmpfile | cut -d ' ' -f1 )
	if [  "$used_vpn_cnt" -gt "$max_vpn_settings" ] ; then    
		echo "Too much VPN setup"
		return 99
	fi
}
get_tun_name(){
	create_tun_list   # Creates the temp file
	local used_vpn_cnt=$(wc -l $tun_tmpfile | cut -d ' ' -f1 )
	local new_name="${device_prefix}""${used_vpn_cnt}"
	
	if  ! grep -q "$new_name" "$tun_tmpfile"  ; then
		#tun name is free
		echo "$new_name"
		return 0
	else
		#tun name is already used
		for  num in  $(seq 1 $max_vpn_settings)  ; do   # max_vpn_settings=9
			#echo "Testing $num "
			new_name="${device_prefix}""${num}"
			if  ! grep -q "$new_name" "$tun_tmpfile"  ; then
				echo "$new_name"
				return 0
			fi
		done 
	fi
	
}

create_tun_list(){
	uci show openvpn | grep .dev= > "$tun_tmpfile"
}


apply_vpn_to_hole(){
	local vpn_name="$1"
	local hole_name="$2"
	
	uci set network."${hole_name}".ifname=$(uci get openvpn."${vpn_name}".dev )
	return $?
}

bitcave_init(){

	system.@system[0].hostname="${Default_Hostname}"

	#remove example openvpn entries
	# we keep the examples, and then remove them
	test -e /etc/config/openvpn.backup || \
		cp  /etc/config/openvpn /etc/config/openvpn.backup
		
	remove_vpn_setting  "custom_config"
	remove_vpn_setting  "sample_server"
	remove_vpn_setting  "sample_client"


	# generate init configuration for networks
	for num in $(seq 1 $bitcave_slots) ; do
		_set_network_bitcave "$num"
		_set_dhcp_bitcave "$num"
		
		_add_rt_alias  "$num"
		_set_wifi_bitcave  "$num"

		zone_name=$(_get_firewall_zone_bitcave_name "${num}" )
		_check_firewall_zone_exists "${zone_name}" || \
			_add_firewall_zone_bitcave  "$num"

	done

	# generate init configuration for outgoing VPN connections
	for num in  $(seq 1 $bitcave_slots) ; do
		_set_network_hole "$num"
		
		zone_name=$(_get_firewall_zone_hole_name "${num}" )
		_check_firewall_zone_exists "${zone_name}" || \
			_add_firewall_zone_hole  "$num"


		if [ "$num" -ne "1" ] ; then
			local src_name=$( _get_firewall_zone_bitcave_name "$num" )
			local dest_name=$( _get_firewall_zone_hole_name "$num"  ) 
			# Only create forward rule if it doesn't already exists
			_check_firewall_forward_rule_exists   "${src_name}" "${dest_name}"  || \
				_add_firwall_forward_rule "${src_name}" "${dest_name}" 
		fi
	done

}

