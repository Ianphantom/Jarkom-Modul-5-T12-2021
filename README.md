# Jarkom-Modul-5-T12-2021

Nama Kelompok :  
- Ian Felix Jonathan Simanjuntak (nomor 1-6)
- Muhammad Zakky Ghufron (Nomor 7-10)
- Muhammad Naufal Imantyasto (Nomor 11 -13)

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