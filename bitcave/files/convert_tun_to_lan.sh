#!/bin/sh

# Uses the tun interface and looks up & searches  in config/firewall
#  to find the correct connected network from /etc/config/network



tun_device_name=$1

uci show network | grep ifname |  awk -F'[.=]' '{ print $2 "="  $4 }' > /tmp/ifname_list.tmp


for line in $( cat /tmp/ifname_list.tmp ) ; do

        if=$( echo $line | cut -d '=' -f 2 )

        if [ "$if" == "$tun_device_name" ] ; then
                network_name=$( echo $line | cut -d '=' -f 1 )
                #we found it
                break
        fi
done

[ -z network_name ] && return 255


local uci_id=$( uci show firewall | grep network=${network_name} | awk -F'[.=]' '{ print $2 }')
local fw_zone_name=$( uci get  firewall."$uci_id".name )

local fwd_ids=$(uci show firewall | grep =forwarding | awk -F'[.=]' '{ print $2 }')

src_fw_name=""

for  id in $fwd_ids ; do
        local uci_src=$(uci get firewall."${id}".src)
        local uci_dest=$(uci get firewall."${id}".dest)
        if  [ "$uci_dest" = "$fw_zone_name"  ]  ; then
                # we found it
                src_fw_name="$uci_src"
                break
        fi
done

uci_id=$( uci show firewall | grep name=${src_fw_name} | awk -F'[.=]' '{ print $2 }')

uci get "firewall."${uci_id}".network"

return $?
