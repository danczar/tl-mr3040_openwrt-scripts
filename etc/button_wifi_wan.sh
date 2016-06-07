#!/bin/sh

# Change out the configurations
cp /etc/config/firewall.wifi_wan /etc/config/firewall
cp /etc/config/network.wifi_wan /etc/config/network
cp /etc/config/wireless.wifi_wan /etc/config/wireless

# Switch flags and reconfigure httpd page
echo "0" > /etc/ap_mode

rm /www/index.html
ln -s /www/wifi_wan.html /www/index.html

# Reset the network
/etc/init.d/network restart
/etc/init.d/firewall restart

