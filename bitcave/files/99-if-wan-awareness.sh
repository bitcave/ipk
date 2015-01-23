#!/bin/sh

#!/bin/sh 
#[ "$ACTION" = ifup ] && { logger -t button-hotplug Device: $DEVICE / Action: $ACTION 
#}

logger -t DEBUG "Starting hotplug for changing "

if [ "$INTERFACE" = "wan" ] ; then
	logger -t DEBUG "Found wan event"
	if [ "$ACTION" = "ifup" ] ; then
		logger -t "IFUP event fired.."
		/etc/init.d/openvpn start
	fi
	if [ "$ACTION" = "ifdown" ] ; then
		logger -t "IFDOWN event fired.."
		/etc/init.d/openvpn stop 

	fi
fi
