echo "nameserver 192.168.122.1" >/etc/resolv.conf
apt-get install nano -y
apt-get install isc-dhcp-relay -y
service isc-dhcp-relay restart