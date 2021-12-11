# Jarkom-Modul-5-T12-2021

Nama Kelompok :  
- Ian Felix Jonathan Simanjuntak (nomor A-D)
- Muhammad Zakky Ghufron (Nomor 1-3)
- Muhammad Naufal Imantyasto (Nomor 4 -6)

### Gambar Topologi
![image](https://user-images.githubusercontent.com/50267676/145672393-531b8c88-4303-4e3d-9791-2a7d60431ba6.png)

### Metode Subnetting VLSM
Untuk mengerjakan dengan meotde VLSM, pertama sekali kami membagi gambar tersebut kedalam beberapa bagian kecil. Berikut adalah gambar pembagian yang telah kami buat.  

![image](https://user-images.githubusercontent.com/50267676/145672342-bccc80a0-2366-4bcf-9bce-6668603cae9d.png)


Setelah kami melakukan pembagian tersebut, berikut nya kami menghitung berapa jumlah host pada setiap subnet dan netmask berapa yang akan digunakan. Berikut adalah perhitungan yang kami gunakan

<table>
    <tr>
        <td>Label</td>
        <td>Jumlah Host</td>
        <td>Netmask</td>
    </tr>
    <tr>
        <td>A1</td>
        <td>3</td>
        <td>/29</td>
    </tr>
        <tr>
        <td>A2</td>
        <td>301</td>
        <td>/23</td>
    </tr>
        <tr>
        <td>A3</td>
        <td>201</td>
        <td>/24</td>
    </tr>
        <tr>
        <td>A4</td>
        <td>2</td>
        <td>/30</td>
    </tr>
        <tr>
        <td>A5</td>
        <td>2</td>
        <td>/30</td>
    </tr>
        <tr>
        <td>A6</td>
        <td>701</td>
        <td>/22</td>
    </tr>
        <tr>
        <td>A7</td>
        <td>101</td>
        <td>/25</td>
    </tr>
        <tr>
        <td>A8</td>
        <td>3</td>
        <td>/29</td>
    </tr>
        <tr>
        <td>Total</td>
        <td>5845</td>
        <td>/19</td>
    </tr>
</table>

Dapat dilihat bahwa major network nya berada pada netmask /19. Prefix IP kelompok kami adalah 192.217.X.X. Untuk table perhitungannya adalah sebagai berikut : 

![image](https://user-images.githubusercontent.com/50267676/145672591-87088392-94da-4fe2-bde4-9428077daf8f.png)

Setelah mendapatkan pembagian IP, selanjutnya kami membuat topologi pada GNS3 sebagai berikut :

![image](https://user-images.githubusercontent.com/50267676/145673076-35818786-0bb0-40b6-98d3-59446cf7d9f2.png)

Untuk pengaturan IP, kami mengatur IP berdasarkan table perhitungan yang telah kami buat, lalu kami mengassign Ip tersebut kedalam setiap node. Sebagai Contoh kita ambil subnet A1.
```
Subnet A1 : 
    NID : 192.217.7.128
    Netmask : 255.255.255.248
    IP range : 192.217.7.129 - 192.217.7.134
```

Berdasarkan data tersebut kita tinggal melakukan assign terhadap semua network yang telah kita miliki. berikut kami lampirkan settngan konfigurasi dari setiap node

### Foosha
```
auto eth0
iface eth0 inet dhcp

auto eth1
iface eth1 inet static
	address 192.217.7.145
	netmask 255.255.255.252

auto eth2
iface eth2 inet static
	address 192.217.7.149
	netmask 255.255.255.252
```
### Guanhao
```
auto eth0
iface eth0 inet static
	address 192.217.7.146
	netmask 255.255.255.252
        gateway 192.217.7.145

auto eth1
iface eth1 inet static
	address 192.217.7.129
	netmask 255.255.255.248

auto eth2
iface eth2 inet static
	address 192.217.6.1
	netmask 255.255.255.0

auto eth3
iface eth3 inet static
	address 192.217.4.1
	netmask 255.255.254.0
```
### MainGate
```
auto eth0
iface eth0 inet static
	address 192.217.7.130
	netmask 255.255.255.248
    gateway 192.217.7.129
```
### Jorge
```
auto eth0
iface eth0 inet static
	address 192.217.7.131
	netmask 255.255.255.248
    gateway 192.217.7.129
```
### Water7
```
auto eth0
iface eth0 inet static
	address 192.217.7.150
	netmask 255.255.255.252
        gateway 192.217.7.149

auto eth1
iface eth1 inet static
	address 192.217.7.137
	netmask 255.255.255.248

auto eth2
iface eth2 inet static
	address 192.217.7.1
	netmask 255.255.255.128

auto eth3
iface eth3 inet static
	address 192.217.0.1
	netmask 255.255.252.0
```
### Doriki
```
auto eth0
iface eth0 inet static
	address 192.217.7.139
	netmask 255.255.255.248
    gateway 192.217.7.137
```
### Jipangu
```
auto eth0
iface eth0 inet static
	address 192.217.7.138
	netmask 255.255.255.248
    gateway 192.217.7.137
```
### Blueno, Cipher, Elena, Fukurou
```
auto eth0
iface eth0 inet dhcp
```

Dari settingan tersebut dapat dilihat bahwa subnet Blueno, Cipher, Elena, dan Fukurou akan mendapatkan IP secara dinamis dari DHCP server.

Sebelum kita melakukan setting DHCP, sebelumnya kita mengatur terlebih dahulu routing dalam topologi kita tersebut. Dari topologi tersebut kita dalat melihat bahwa `A7, A8, A6` sudah terbuhung dengan `Water7`. Begitu juga `A2, A3, A1` dengan `Guanhao`. Oleh karena itu kita hanya perlu melakukan settingan routing pada `Foosha` agar semua subnet yang terhubung pada Guanhao dan Water7 juga terhubung pada Foosha. Berikut adalah setting yang kami gunakan

```
route add -net 192.217.7.136 netmask 255.255.255.248 gw 192.217.7.150
route add -net 192.217.7.0 netmask 255.255.255.128 gw 192.217.7.150
route add -net 192.217.0.0 netmask 255.255.252.0 gw 192.217.7.150

route add -net 192.217.7.128 netmask 255.255.255.248 gw 192.217.7.146
route add -net 192.217.6.0 netmask 255.255.255.0 gw 192.217.7.146
route add -net 192.217.4.0 netmask 255.255.254.0 gw 192.217.7.146
```
Dapat dilihat dari settingan tersebut bahwa, next jump dari semua subnet yang terhubung dengan Water7 adalah interface Water7 yang terhubung dengan Foosha. Begitu juga next jump dari semua subnet yang terhubung dengan Guanhao adalah interface Guanhao yang terhubung dengan Foosha.

Setelah kita melakukan rooting, berikut nya kita perlu menjalankan DHCP server. Karena DHCP server berada pada jipangu, maka kita perlu menginstall DHCP relay untuk setiap router yang ada. Untuk melakukan Setting DHCP relay, pertama sekali kita perlu menjalankan kode berikut ini

### Water7, Foosha, Guanhao
```
apt-get install isc-dhcp-relay -y
service isc-dhcp-relay restart
```

ketika menjalankan kode tersebut kita akan diminta memasukkan alamat DHCP server dan juga interface yang akan digunakan, data yang akan dimasukkan adalah :
```
SERVERS="192.217.7.138"
INTERFACES="eth2 eth1 eth3 eth0"
OPTIONS=""
```

![image](https://user-images.githubusercontent.com/50267676/145673286-18375251-374e-4c52-928b-5ea4855636a7.png)

setelah melakukan settings DHCP relay, selanjutnya kita melakukan setting pada DHCP server. Jipangu akan digunakan sebagai DHCP server. Pada jipangu download terlebih dahulu DHCP server nya
```
apt-get install isc-dhcp-server -y
```
setelah kita mendownload DHCP server, selanjutnya kita perlu mengatur interfaces yang digunakan dengan menggunakan kode berikut ini
```
echo "
INTERFACES=\"eth0\"
" > /etc/default/isc-dhcp-server
```

setelah kita mengatur interfaces, sekrang kita mengatur IP terhadap setiap subnet yang ada. Berikut adalah kode yang kami gunakan.

### Subnet A7
```
subnet 192.217.7.0 netmask 255.255.255.128 {
   range 192.217.7.2 192.217.7.126;
   option routers 192.217.7.1;
   option broadcast-address 192.217.7.127;
   option domain-name-servers 192.217.7.139;
   default-lease-time 360;
   max-lease-time 7200;
}
```
### subnet A6
```
subnet 192.217.0.0 netmask 255.255.252.0 {
   range 192.217.0.2 192.217.3.254;
   option routers 192.217.0.1;
   option broadcast-address 192.217.3.255;
   option domain-name-servers 192.217.7.139;
   default-lease-time 360;
   max-lease-time 7200;
}
```
### Subnet A2
```
subnet 192.217.4.0 netmask 255.255.254.0 {
   range 192.217.4.2 192.217.5.254;
   option routers 192.217.4.1;
   option broadcast-address 192.217.5.255;
   option domain-name-servers 192.217.7.139;
   default-lease-time 360;
   max-lease-time 7200;
}
```
### Subnet A3
```
subnet 192.217.6.0 netmask 255.255.255.0 {
   range 192.217.6.2 192.217.6.254;
   option routers 192.217.6.1;
   option broadcast-address 192.217.6.255;
   option domain-name-servers 192.217.7.139;
   default-lease-time 360;
   max-lease-time 7200;
}
```
dapat dilihat dari kode tersebut, alamat dari DNS yang kami gunakan adalah alamat dari Doriki. Dan Option  routers yang kami gunakan adalah alamat dari interface router yang terhubung dengan setiap subnet yang ada. untuk menghubungkan dengan relay, kami menambahkan kode berikut ini
```
subnet 192.217.7.136 netmask 255.255.255.248{}
```

semua kode tersebut akan dijalankan dengan cara sebagai berikut
```
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
```
Berikutnya karena kita menggunakan Doriki sebagai DNS, maka kita perlu membuat DNS Forwarder agar setiap subnet dapat terhubung ke internet, untuk membuat DNS Forwarder berikut adalah kode yang kami gunakan
```
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
service bind9 restart
```
Berikut adalah tampilan dari setiap subnet yang sudah mendapatkan IP dari DHCP server
![image](https://user-images.githubusercontent.com/50267676/145673605-d119af7a-7d02-452a-af61-7f2cfbe7f621.png)
![image](https://user-images.githubusercontent.com/50267676/145673627-3e97830d-a031-4afd-84f4-e96886fd194d.png)
![image](https://user-images.githubusercontent.com/50267676/145673643-9de3bd04-b5f2-45d2-a8a4-074ff7a3f11a.png)
![image](https://user-images.githubusercontent.com/50267676/145673654-8b16fe8b-ff59-4564-9f65-c6e29bff8b88.png)
### Soal1

### Soal2

### Soal3

Kemudian kalian diminta untuk membatasi akses ke Doriki yang berasal dari subnet Blueno, Cipher, Elena dan Fukuro dengan beraturan sebagai berikut
### Soal4
Akses dari subnet Blueno dan Cipher hanya diperbolehkan pada pukul 07.00 - 15.00 pada hari Senin sampai Kamis.
##### Jawaban
- Masukkan kode berikut ini untuk membatasi akses blueno
```
iptables -A INPUT -s 192.217.7.0/25 -m time --timestart 07:00 --timestop 15:00 --weekdays Mon,Tue,Wed,Thu,Fri -j ACCEPT
iptables -A INPUT -s 192.217.7.0/25 -j REJECT
```
- Masukkan kode berikut ini untuk membatasi akses dari cipher
```
iptables -A INPUT -s 192.217.0.0/22 -m time --timestart 07:00 --timestop 15:00 --weekdays Mon,Tue,Wed,Thu,Fri -j ACCEPT
iptables -A INPUT -s 192.217.0.0/22 -j REJECT
```
- Testing pada Blueone dan Chiper  
![image](https://user-images.githubusercontent.com/50267676/145674276-1abac2d0-3cb2-4918-8409-fc6a33bf518a.png)  
pada doriki adalah hari sabtu pukul 11, oleh karena itu Blueno dan Cipher tidak akan bisa mengakses Doriki  
![image](https://user-images.githubusercontent.com/50267676/145674312-beb459e9-1c09-40a3-8ca4-d3434978f917.png)  
![image](https://user-images.githubusercontent.com/50267676/145674324-53d2813d-ddb5-4e72-b6cc-40db1e4092e9.png)  
Dapat dilihat bahwa kedua Node tersebut tidak bisa mengakses Doriki

### Soal5
Akses dari subnet Elena dan Fukuro hanya diperbolehkan pada pukul 15.01 hingga pukul 06.59 setiap harinya.
##### Jawaban
Sama seperti soal sebelumnya, disini kami hanya mengganti jam dan juga hari. 
- Untuk mengaturnya jalankan kode berikut ini
```
iptables -A INPUT -s 192.217.4.0/23 -m time --timestart 07:00 --timestop 15:00 -j REJECT 
iptables -A INPUT -s 192.217.6.0/24 -m time --timestart 07:00 --timestop 15:00 -j REJECT
```
- Testing pada Elena dan Fukurou  
![image](https://user-images.githubusercontent.com/50267676/145674409-fb61e9db-1a76-4057-bdde-9834625413fe.png)  
Dapat dilihat bahwa waktu pada server adalah hari sabtu pukul 11. Seharusnya Elena dan Fukurou tidak dapat menggakses Doriki  
![image](https://user-images.githubusercontent.com/50267676/145674446-ddf40152-e16b-46ad-bf14-68685e23245b.png)  
![image](https://user-images.githubusercontent.com/50267676/145674457-a1093d27-aec2-44f8-8401-cdf2a6a9263b.png)

### Soal6
Karena kita memiliki 2 Web Server, Luffy ingin Guanhao disetting sehingga setiap request dari client yang mengakses DNS Server akan didistribusikan secara bergantian pada Jorge dan Maingate
##### Jawaban
- Untuk melakukan load balancing, jalankan kode berikut ini pada guanhao
```
iptables -A PREROUTING -t nat -p tcp -d 192.217.7.139 -m statistic --mode nth --every 2 --packet 0 -j DNAT --to-destination 192.217.7.131:80
iptables -A PREROUTING -t nat -p tcp -d 192.217.7.139 -j DNAT --to-destination 192.217.7.130:80
```
Dari kode tersebut dapat kita lihat kita mengatur load balancing dengan metode round robin dengan interval 2. Sehingga mereka akan berganti gantian menghande client
- Testing pada Jorge dan Maingate
Pertama, kami melakukan instalasi netcat di Jorge, Maingate, dan 2 client acak. Pada Jorge dan Maingate jalankan listener dengan kode
```
nc -l -p 80
```
Pada client jalankan kode
```
nc 192.217.7.139 80
```
Berikut adalah hasilnya  
![image](https://user-images.githubusercontent.com/50267676/145674629-cdfaa5e4-54f3-45d9-873b-79ebd26c53e8.png)  
![image](https://user-images.githubusercontent.com/50267676/145674647-420dfc2f-c286-491e-ba38-94827f0e81de.png)  
yang menghandle request dari elena adalah Jorge  
![image](https://user-images.githubusercontent.com/50267676/145674665-1a80f6b4-7f6b-414c-9482-d83de21cc548.png)  
![image](https://user-images.githubusercontent.com/50267676/145674672-a702d14c-87ea-4ade-b5d2-62acfed49d85.png)  
yang menghandle request dari fukurou adalah Maingate. Dengan begitu load balancer nya sudah berjalan dan setiap request sudah di distribusikan secara merata  

### Kesulitan
