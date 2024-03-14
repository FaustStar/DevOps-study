# Linux Network

## Part 1. ipcalc tool

#### 1.1. Networks and Masks

1. To define network address it needs to use the next command:\
![Defining network address](./screenshots/part1_1.png)
    * *Network address of 192.167.38.54/13*: 192.160.0.0

2. Conversion of the masks 255.255.255.0, /15, and 11111111.11111111.11111111.11110000:
    | Normal | Prefix | Binary |
    | :------: | :------: | :------: |
    | ***255.255.255.0*** | /24 | 11111111.11111111.11111111.00000000 |
    | 255.254.0.0 | ***/15*** | 11111111.11111110.00000000.00000000 |
    | 255.255.255.240 | /28 | ***11111111.11111111.11111111.11110000*** |

3. Minimum and maximum host in 12.167.38.4 network with masks /8, 11111111.11111111.00000000.00000000, 255.255.254.0 and /4:
    | Mask | Min Host | Max Host |
    | :------: | :------: | :------: |
    | ***/8*** | 12.0.0.1 | 12.255.255.254 |
    | ***11111111.11111111.00000000.00000000*** (/16) | 12.167.0.1 | 12.167.255.254 |
    | ***255.255.254.0*** (/23) | 12.167.38.1 | 12.167.39.254 |
    | ***/4*** | 0.0.0.1 | 15.255.255.254 |

#### 1.2. localhost

* **localhost** is a hostname that refers to the current computer used to access it. The name localhost is reserved for loopback purposes. It is used to access the network services that are running on the host via the loopback network interface. IPv4 network standards reserve the entire address block 127.0.0.0/8 (more than 16 million addresses) for loopback purposes. So an application running on localhost:
    * can be accessed with the following IPs: 127.0.0.2, 127.1.0.1;
    * can't be accessed with the following IPs: 194.34.23.100, 128.0.0.1.

#### 1.3. Network ranges and segments

1. Public and private IPs:
    * 10.0.0.45 - private;
    * 134.43.0.2 - public;
    * 192.168.4.2 - private;
    * 172.20.250.4 - private;
    * 172.0.2.1 - public;
    * 192.172.0.1 - public;
    * 172.68.0.2 - public;
    * 172.16.255.255 - private;
    * 10.10.10.10 - private;
    * 192.169.168.1 - public.

2. Gateway IP addresses for 10.10.0.0/18 network are:
    * possible: 10.10.0.2, 10.10.10.10, 10.10.1.255;
    * not possible: 10.0.0.1, 10.10.100.1.

## Part 2. Static routing between two machines

* Existing network interfaces for *ws1* and *ws2* machines (to view them it needs to use the ```ip a``` command):\
![Existing network interfaces for ws1 and ws2](./screenshots/part2_1.png)

* The network interface corresponding to the internal network on both machines is **enp0s8** (en - ethernet, p0 - bus number (0), s8 - slot number (10)):
    * The interface flags are: *BROADCAST* (the device has the facility to send packets to all hosts sharing the same link) and *MULTICAST* (is an advisory flag indicating that the interface is aware of multicasting i.e. sending packets to some subset of neighbouring nodes).
    * *mtu* (Maximum Transmission Unit) is needed to determine the maximum size of each packet in any transmission (1500-byte packet is the largest allowed).
    * *qdisc* (queuing discipline) shows the queuing algorithm used on the interface (*noop* means that the interface is in blackhole mode i.e. all packets sent to it are immediately discarded).
    * *state DOWN* means that interface isn't active.
    * *group* means that interface was tagged with a group value. The role of this group value is to group interfaces together for some special operations by assigning them the same value (the default group probably won't allow some of these operations).
    * *qlen* is the default transmit queue length of the device measured in packets.
    * The second line contains information on the link layer addresses associated with the device. The first word (*ether*) defines the interface hardware type. Then there are MAC address and broadcast address.

* The changed etc/netplan/00-installer-config.yaml file for each machine:
    * *ws1*:\
    ![Netplan configuration for ws1](./screenshots/part2_2.png)
    * *ws2*:\
    ![Netplan configuration for ws2](./screenshots/part2_3.png)

* After I made configuration changes I ran the ```sudo netplan apply``` command to restart the network service:\
![netplan apply command](./screenshots/part2_4.png)

#### 2.1. Adding a static route manually

* Adding a static route from one machine to another and back using a ```ip r add``` command:\
![ip r add command](./screenshots/part2_5.png)

* The call and output of the ```ping``` commands:\
![ping command](./screenshots/part2_6.png)

#### 2.2. Adding a static route with saving

* Adding static route from one machine to another using *etc/netplan/00-installer-config.yaml* file:
    * *ws1*:\
    ![Netplan configuration for ws1](./screenshots/part2_7.png)
    * *ws2*:\
    ![Netplan configuration for ws2](./screenshots/part2_8.png)

* The call and output of the ```ping``` commands:\
![ping command](./screenshots/part2_9.png)

## Part 3. iperf3 utility

#### 3.1. Connection speed

* 8 Mbps = 1 MB/s,
* 100 MB/s = 800000 Kbps, 
* 1 Gbps = 1000 Mbps

#### 3.2. iperf3 utility

* iperf3 utility was used to measure connection speed between ws1 and ws2 (iperf3 runs on port 5201 by default, hence it is necessary for this port to be unblocked, so before running iperf3 I used the ```sudo ufw allow 5201``` command):
    * *ws1* was a server and *ws2* was a client:
        * *ws1*:\
        ![iperf3 for ws1 as a server](./screenshots/part3_1.png)
        * *ws2*:\
        ![iperf3 for ws2 as a client](./screenshots/part3_2.png)
    * *ws2* was a server and *ws1* was a client:
        * *ws2*:\
        ![iperf3 for ws2 as a server](./screenshots/part3_3.png)
        * *ws1*:\
        ![iperf3 for ws1 as a client](./screenshots/part3_4.png)

## Part 4. Network firewall

#### 4.1. iptables utility

* Created /etc/firewall.sh files simulating the firewall on machines:
    * *ws1*:\
    ![Simulating firewall on ws1](./screenshots/part4_1.png)
    * *ws2*:\
    ![Simulating firewall on ws2](./screenshots/part4_2.png)

* Running the files on both machines:
    * *ws1*:\
    ![Running firewall file on ws1](./screenshots/part4_3.png)
    * *ws2*:\
    ![Running firewall file on ws2](./screenshots/part4_4.png)

* The difference between the strategies used in the first and second files: on ws1 machine a deny rule is at the beginning and an allow rule is at the end; on ws2 machine these rules are in reverse. Rules are executed from top to bottom, it means that the first written rule can't be overwritten by the second one. As a result, *ws1* machine can't be pinged, but *ws2* machine can.

#### 4.2. nmap utility

* Using ```ping``` command a machine which is not pinged was found, then using ```nmap``` utility the fact that the machine host is up was showed:
    * *ws1*:\
    ![ws1 trying to connect to ws2](./screenshots/part4_5.png)
    * *ws2*:\
    ![ws2 trying to connect to ws1](./screenshots/part4_6.png)

## Part 5. Static network routing

* Network:\
![Network](./screenshots/part5_0.png)

#### 5.1. Configuration of machine addresses

* The machine configurations in *etc/netplan/00-installer-config.yaml* files:
    * *r1*:\
    ![Netplan configuration for r1](./screenshots/part5_1.png)
    * *r2*:\
    ![Netplan configuration for r2](./screenshots/part5_2.png)
    * *ws11*:\
    ![Netplan configuration for ws11](./screenshots/part5_3.png)
    * *ws22*:\
    ![Netplan configuration for ws22](./screenshots/part5_4.png)
    * *ws21*:\
    ![Netplan configuration for ws21](./screenshots/part5_5.png)

* Restarting the network service, checking that the machine address is correct with the ```ip -4 a``` command, pinging ws22 from ws21 and r1 from ws11:
    * *r1*:\
    ![Restarting the network sercice for r1](./screenshots/part5_6.png)
    * *r2*:\
    ![Restarting the network sercice for r2](./screenshots/part5_7.png)
    * *ws11*:\
    ![Restarting the network sercice for ws11](./screenshots/part5_8.png)
    * *ws22*:\
    ![Restarting the network sercice for ws22](./screenshots/part5_9.png)
    * *ws21*:\
    ![Restarting the network sercice for ws21](./screenshots/part5_10.png)

#### 5.2. Enabling IP forwarding

* Running the ```sysctl -w net.ipv4.ip_forward=1``` command to enable IP forwarding (the forwarding will not work after the system is rebooted):\
![Enabling IP forwarding](./screenshots/part5_11.png)

* Changing */etc/sysctl.conf* file to enable IP forwarding permanently:
    * *r1*:\
    ![Enabling IP forwarding permanently for r1](./screenshots/part5_12.png)
    * *r2*:\
    ![Enabling IP forwarding permanently for r2](./screenshots/part5_13.png)

#### 5.3. Default route configuration

* Configuring the default route (gateway) for the workstations:\
![Configuring the default route for ws11, ws22 and ws21](./screenshots/part5_14.png)

* Showing that a route was added to the routing table using the ```ip r``` command:\
![Showing route tables for ws11, ws22 and ws21](./screenshots/part5_15.png)

* Pinging r2 router from ws11:\
![Pinging r2 router from ws11](./screenshots/part5_16.png)

* Showing on r2 that the ping is reaching using the ```tcpdump -tn -i enp0s8``` command:\
![Showing that the ping is reaching](./screenshots/part5_17.png)

* Extra - the configuration files for the routers:\
![Configuring the default route for r1 and r2](./screenshots/part5_18.png)

#### 5.4. Adding static routes

* Adding static routes to r1 and r2 in configuration file:\
![Adding static routes to r1 and r2](./screenshots/part5_19.png)

* Showing route tables on both routers:\
![Showing route tables for r1 and r2](./screenshots/part5_20.png)

* Running ```ip r list 10.10.0.0/[netmask]``` and ```ip r list 0.0.0.0/0``` commands on ws11:\
![Showing route tables for ws11](./screenshots/part5_21.png)

* A different route other than 0.0.0.0/0 was selected for 10.10.0.0/[netmask] because of longest prefix match routing rule. *Longest prefix match routing* is an algorithm where the router prefers the longest prefix in the routing table. When a router receives the IP packet, it compares the destination IP address bit-by-bit with prefixes in the routing table. The prefix with the most matching bits is the prefix that the router will use. So the default route wasn't selected because there was the alternative route.

#### 5.5. Making a router list

* Running the ```tcpdump -tnv -i enp0s8``` dump command on r1:\
![Running the dump command on r1](./screenshots/part5_22.png)

* Using ```traceroute``` utility to list routers in the path from ws11 to ws21:\
![Showing routers in the path from ws11 to ws21](./screenshots/part5_23.png)

* The first line of the ```traceroute``` output gives us the following info: the destination and its IP address, the number of hops traceroute will try before giving up and the size of the UDP packets we're sending. All of the other lines contain information about one of the hops. Hops 1 and 2 tell us that these devices didn't respond (perhaps they were configured never to send ICMP packets; or, perhaps they did respond but were too slow, so traceroute timed out). Hop 3 tells us that we reached our destination. Hops are TTL value (time to live). ```traceroute``` command sends three packets to the hop and each of the time refers to the time taken by the packet to reach the hop.

#### 5.6. Using ICMP protocol in routing

* Running on r1 network traffic capture going through enp0s8 with the ```tcpdump -n -i enp0s8 icmp``` command:\
![Running the dump command on r1](./screenshots/part5_24.png)

* Pinging a non-existent IP (e.g. 10.30.0.111) from ws11 with the ```ping -c 1 10.30.0.111``` command:\
![Pinging a non-existent IP from ws11](./screenshots/part5_25.png)

## Part 6. Dynamic IP configuration using DHCP

* Specifying the default router address, DNS-server and internal network address in the */etc/dhcp/dhcpd.conf* file for r2:\
![DHCP service configuration file for r2](./screenshots/part6_1.png)

* Writting ```nameserver 8.8.8.8``` in a *resolv.conf* file for r2:\
![resolv.conf file for r2](./screenshots/part6_2.png)

* Restarting the DHCP service with ```systemctl restart isc-dhcp-server```:\
![Restarting the DHCP service for r2](./screenshots/part6_3.png)

* Rebooting the ws21 machine with ```reboot``` and showing with ```ip a``` that it has got an address:\
![Showing that ws21 has got a new IP address from DHCP](./screenshots/part6_4.png)

* Pinging ws22 from ws21:\
![Pinging ws22 from ws21](./screenshots/part6_5.png)

* Extra - the netplan configuration file for ws21:\
![Netpaln configuration file for ws21](./screenshots/part6_6.png)

* Specifying MAC address at ws11 by adding to *etc/netplan/00-installer-config.yaml* ```macaddress: 10:10:10:10:10:BA```, ```dhcp4: true```:\
![Netpaln configuration file for ws11](./screenshots/part6_7.png)

* Сonfiguring r1 the same way as r2 (but the assignment of addresses strictly linked to the MAC-address (ws11)) and running the same tests:
    * Settings of the */etc/dhcp/dhcpd.conf* file:\
    ![DHCP service configuration file for r1](./screenshots/part6_8.png)
    * Settings of the *resolv.conf* file:\
    ![resolv.conf file for r1](./screenshots/part6_9.png)
    * Restarting the DHCP service:\
    ![Restarting the DHCP service for r1](./screenshots/part6_10.png)
    * Rebooting the ws11 machine with ```reboot``` and showing with ```ip a``` that it has got an address:\
    ![Showing that ws11 has got a new IP address from DHCP](./screenshots/part6_11.png)
    * Pinging ws22 from ws11:\
    ![Pinging ws22 from ws11](./screenshots/part6_12.png)

* Requesting ip address update from ws21:
    * before:\
    ![ip address before update for ws21](./screenshots/part6_13.png)
    * after:\
    ![ip address after update for ws21](./screenshots/part6_14.png)
    * to request update I used the next commands:\
    ![Requesting ip address update](./screenshots/part6_15.png)
    * used DHCP server options: option routers - default GW for clients; option domain-name-servers - DNS server IP address.

## Part 7. NAT

* Changing the line ```Listen 80``` to ```Listen 0.0.0.0:80``` in */etc/apache2/ports.conf* file (i.e. making the Apache2 server public):
    * ws22:\
    ![Changing ports.conf file for ws22](./screenshots/part7_1.png)
    * r1:\
    ![Changing ports.conf file for r1](./screenshots/part7_2.png)

* Starting the Apache web server with ```service apache2 start``` command:
    * ws22:\
    ![Starting the Apache web server for ws22](./screenshots/part7_3.png)
    * r1:\
    ![Starting the Apache web server for r1](./screenshots/part7_4.png)

* Adding the rules to the firewall, created similarly to the firewall from *Part 4*, on r2:\
![Adding the rules to the firewall for r2](./screenshots/part7_5.png)

* Running the file as in *Part 4*:\
![Running the firewall file for r2](./screenshots/part7_6.png)

* Checking the connection between ws22 and r1 with the ```ping``` command (ws22 should not ping from r1):\
![Pinging ws22 from r1](./screenshots/part7_7.png)

* Adding another rule to the firewall file:\
![Adding another rule to the firewall for r2](./screenshots/part7_8.png)

* Running the file:\
![Running the firewall file for r2](./screenshots/part7_9.png)

* Checking the connection between ws22 and r1 with the ```ping``` command (ws22 should ping from r1):\
![Pinging ws22 from r1](./screenshots/part7_10.png)

* Adding two more rules to the firewall file (enabling SNAT (which is masquerade all local ip from the local network behind r2, network 10.20.0.0) and DNAT (on port 8080 of r2 machine and add external network access to the Apache web server running on ws22)):\
![Adding two rules to the firewall for r2](./screenshots/part7_11.png)

* Running the file:\
![Running the firewall file for r2](./screenshots/part7_12.png)

* Checking the TCP connection for SNAT by connecting from ws22 to the Apache server on r1 with the ```telnet [address] [port]``` command:\
![Checking the TCP connection for SNAT](./screenshots/part7_13.png)

* Checking the TCP connection for DNAT by connecting from r1 to the Apache server on ws22 with the ```telnet``` command (address r2 and port 8080):\
![Checking the TCP connection for DNAT](./screenshots/part7_14.png)

## Part 8. Bonus. Introduction to SSH Tunnels

* Running a firewall on r2 with the rules from *Part 7*:\
![Running the firewall file for r2](./screenshots/part8_1.png)

* Starting the Apapche web server on ws22 on localhost only:
    * Changing the line ```Listen 80``` to ```Listen localhost:80``` in */etc/apache2/ports.conf* file:\
    ![Changing ports.conf file for ws22](./screenshots/part8_2.png)
    * Starting the Apapche web server:\
    ![Starting the Apache web server for ws22](./screenshots/part8_3.png)

* Using Local TCP forwarding from ws21 to ws22 to access the web server on ws22 from ws21 (```ssh -L [local_port]:[destination_address]:[destination_port] [username]@[ssh_server]``` command):\
![Using Local TCP forwarding from ws21 to ws22](./screenshots/part8_4.png)

* Running the ```telnet 127.0.0.1 [local port]``` command to check if the connection worked (it needs to press ```Alt + F2``` to go to a second terminal):\
![Checking connection for local TCP forwarding](./screenshots/part8_5.png)

* Using Remote TCP forwarding from ws11 to ws22 to access the web server on ws22 from ws11 (```ssh -R [remote_port]:[destination_address]:[local_port] [username]@[ssh_server]``` command):\
![Using Remote TCP forwarding from ws11 to ws22](./screenshots/part8_6.png)

* Running the ```telnet 127.0.0.1 [local port]``` command to check if the connection worked (it needs to press ```Alt + F2``` to go to a second terminal):\
![Checking connection for remote TCP forwarding](./screenshots/part8_7.png)