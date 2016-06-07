# TP-LINK TL-MR3040 OpenWRT Custom Scripts
## github.com/danczar

### Introduction
This is a collection of scripts intended to be used on a TP-LINK TL-MR3040 running the latest version of OpenWRT supported on the device.  Information regarding support for this device can be found on the official OpenWRT website [here](https://wiki.openwrt.org/toh/tp-link/tl-mr3040).  Special thanks to those who created those documents, they were super helpful.

The purpose of these scripts are to share some work I did over the course of a couple nights to configure this battery-powered travel router to work as I saw fit.  This includes tunneling all LAN traffic on the device through a configured OpenVPN server as an encrypted tunnel for when I use hotel/public networks on travel.

## Details

It does this via two methods:

* When the switch on the device is in "AP" mode, it creates a wireless AP for my devices to connect to, which tunnels all traffic through the VPN tunnel and out through the network connected via the wired interface.
* When the switch on the device is in "3G/4G" mode, it basically reverses that topology, keeping a VPN tunnel, but instead connecting to a configured wireless network as the WAN interface, and allowing you to get access to the VPN and LAN via the wired interface.

Essentially, the "AP" switch works as intended, but with a VPN tunnel, and "3G/4G" works as a wireless bridge mode with a VPN tunnel.

The "WISP" switch in the middle has been configured to run an OpenVPN reset script, in the event it gets mucked up in the ways OpenVPN does.  You can trigger it to reset via a hardware switch, and put the switch back to the mode it was in without issue.

I also changed /etc/config/system to make the 3G/4G LED on the device flash for tun0 traffic, essentially showing that the VPN is working.

The files are all provided in the same directory structure as it is on my running device.

### Web Interface

uHTTPd is running on port 80 on my device, configured with /www as the webroot.  I provided the cgi-bin scripts and HTML pages I made which I use to configure the router via a browser for the little configuring I need to get done.  This really only is to tell the device when it is in wireless bridge mode which SSID to connect to and supply it a key.  It's very archaic, I know.  I also put a script in there to reset the VPN, but I've since implemented the switch to do the same.  I'll be updating that to, instead, update the OpenVPN client configuration by pasting it into a box and supplying the new certs to upload.  But that's TBD, because SCP is useful for that as well.

### Gotchas

The TP-LINK TL-MR3040 is a small device, and as such, has a very small amount of space for the OpenWRT system.  To combat this, I utilized the onboard USB port to hold a low-profile SanDisk Cruzer 16GB drive.  The drive is formatted Ext4, and configured to be an extroot device for the system (this essentially makes it overlay the rootfs of the system and trick it into thinking it has way more space than it really does, but really it's just writing stuff to the USB drive, not the ROM).  

I found to get the device to mount and recognize an Ext4-formatted USB drive, it did not have enough space to install the required packages with the firmware build available on the official OpenWRT page I linked above.  Therefore, I had to build my own version of OpenWRT without all the extra packages (like LuCI, the web GUI), so that I had the space to install the necessary packages.  I didn't end up installed LuCI once I had the extra space from the USB drive, because I find it way easier to just do it via CLI, and cut down on the bloat.  This device isn't anything special in terms of processing power and memory.

In the end, in addition to the USB-related OPKG packages I installed to use the USB drive, I installed openvpn-openssh and uhttpd.  In the future, I want to see if I can get Squid running so that I can cache on the USB drive and see if that helps with bandwidth related issues when traveling in areas where bandwidth is a commodity.

### Thanks

If you got this far, thanks for reading.  Hope this turns the device into something cool and useful for you, as it did for me.

