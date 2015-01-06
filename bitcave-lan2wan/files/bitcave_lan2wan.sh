#!/bin/sh
# (c) 2015 - Matthias Strubel <matthias.strubel@aod-rpg.de>
#	 Licenced under GPL-3
#
# The purpose of this script is to quickly setup
# devices with only one ethernet port to use this
# port as a WAN port.
# In the same time it activates the wifi network
# to get access via wifi later.

if [ -z $(uci get network.wan) ] ; then
	echo "Switching current lan-ethernet to wan"
	ethernet_interface=$(uci get network.lan.ifname)
	echo ".. choosed ifname $ethernet_interface"
	uci delete network.lan.ifname
	uci set network.wan=interface
	uci set network.wan.ifname="$ethernet_interface"
	uci set network.wan.proto='dhcp'

	## Set macaddr value if it is set.
	##   this line is needed at i.e. VoCore
	uci get network.lan.macaddr &> /dev/null  && \
		uci set network.wan.macaddr=$( uci get network.lan.macaddr )  
	
	echo "Enabling wifi"
	uci set wireless.radio0.disabled=0
	uci commit
	echo "Saved in UCI, done."
else
	echo "WAN is already available, skipping network prep."
fi

