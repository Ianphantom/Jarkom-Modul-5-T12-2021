apt-get update -y
apt-get install nano -y
apt-get install isc-dhcp-relay -y

route add -net 192.217.7.136 netmask 255.255.255.248 gw 192.217.7.150
route add -net 192.217.7.0 netmask 255.255.255.128 gw 192.217.7.150
route add -net 192.217.0.0 netmask 255.255.252.0 gw 192.217.7.150

route add -net 192.217.7.128 netmask 255.255.255.248 gw 192.217.7.146
route add -net 192.217.6.0 netmask 255.255.255.0 gw 192.217.7.146
route add -net 192.217.4.0 netmask 255.255.254.0 gw 192.217.7.146

ipEth0="$(ip -br a | grep eth0 | awk '{print $NF}' | cut -d'/' -f1)"

iptables -t nat -A POSTROUTING -s 192.217.0.0/21 -o eth0 -j SNAT --to-source "$ipEth0"

iptables -A FORWARD -d 192.217.7.136/29 -i eth0 -p tcp --dport 80 -j DROP

service isc-dhcp-relay restart