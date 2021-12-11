echo "nameserver 192.168.122.1" >/etc/resolv.conf
apt-get install nano -y
apt-get install bind9 -y

echo "
options {
        directory \"/var/cache/bind\";
        forwarders {
                192.168.122.1;
        };
        allow-query{any;};
        auth-nxdomain no;
        listen-on-v6 { any; };
};

" > /etc/bind/named.conf.options


iptables -A INPUT -p ICMP -m connlimit --connlimit-above 3 --connlimit-mask 0 -j DROP

#nomor4 Blueno
iptables -A INPUT -s 192.217.7.0/25 -m time --timestart 07:00 --timestop 15:00 --weekdays Mon,Tue,Wed,Thu,Fri -j ACCEPT
iptables -A INPUT -s 192.217.7.0/25 -j REJECT

#nomor4 Cipher
iptables -A INPUT -s 192.217.0.0/22 -m time --timestart 07:00 --timestop 15:00 --weekdays Mon,Tue,Wed,Thu,Fri -j ACCEPT
iptables -A INPUT -s 192.217.0.0/22 -j REJECT

#nomor5
iptables -A INPUT -s 192.217.4.0/23 -m time --timestart 07:00 --timestop 15:00 -j REJECT 
iptables -A INPUT -s 192.217.6.0/24 -m time --timestart 07:00 --timestop 15:00 -j REJECT 

service bind9 restart