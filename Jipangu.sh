echo "nameserver 192.168.122.1" >/etc/resolv.conf
apt-get install nano -y

apt-get install isc-dhcp-server -y

echo "
INTERFACES=\"eth0\"
" > /etc/default/isc-dhcp-server

echo "
ddns-update-style none;
option domain-name \"example.org\";
option domain-name-servers ns1.example.org, ns2.example.org;
default-lease-time 600;
max-lease-time 7200;
log-facility local7;
subnet 192.217.7.136 netmask 255.255.255.248{}
subnet 192.217.7.0 netmask 255.255.255.128 {
   range 192.217.7.2 192.217.7.126;
   option routers 192.217.7.1;
   option broadcast-address 192.217.7.127;
   option domain-name-servers 192.217.7.139;
   default-lease-time 360;
   max-lease-time 7200;
}

subnet 192.217.0.0 netmask 255.255.252.0 {
   range 192.217.0.2 192.217.3.254;
   option routers 192.217.0.1;
   option broadcast-address 192.217.3.255;
   option domain-name-servers 192.217.7.139;
   default-lease-time 360;
   max-lease-time 7200;
}

subnet 192.217.4.0 netmask 255.255.254.0 {
   range 192.217.4.2 192.217.5.254;
   option routers 192.217.4.1;
   option broadcast-address 192.217.5.255;
   option domain-name-servers 192.217.7.139;
   default-lease-time 360;
   max-lease-time 7200;
}

subnet 192.217.6.0 netmask 255.255.255.0 {
   range 192.217.6.2 192.217.6.254;
   option routers 192.217.6.1;
   option broadcast-address 192.217.6.255;
   option domain-name-servers 192.217.7.139;
   default-lease-time 360;
   max-lease-time 7200;
}

" > /etc/dhcp/dhcpd.conf

service isc-dhcp-server restart

iptables -A INPUT -p ICMP -m connlimit --connlimit-above 3 --connlimit-mask 0 -j DROP