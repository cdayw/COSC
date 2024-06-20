# Networking INFO
```
Networking cybbh - https://net.cybbh.io/public/networking/latest/index.html
Miro Whiteboard - https://miro.com/app/board/o9J_klSqCSY=/
CTFD1 - http://networking-ctfd-1.server.vta:8000/resources
Jump Box - 10.50.37.63
```
# Network Access
## Internet Standard Organizations 
```
Internet Engineering Task Force (IETF): The IETF is a large open international community of network designers, operators, vendors, and researchers who are concerned with the evolution and operation of the Internet. It focuses on the development of protocols and standards, with working groups dedicated to specific areas such as routing, security, and web technologies.

Internet Assigned Numbers Authority (IANA): IANA is responsible for the global coordination of the DNS root, IP addressing, internet numbers, and other Internet protocol resources. While not primarily a standards development organization, IANA’s role in managing critical Internet resources is vital to the functioning of the Internet.

Institute of Electrical and Electronics Engineers (IEEE): While the IEEE is a broader organization covering various fields of technology, it plays a significant role in developing standards for networking and communication technologies. The IEEE 802 working groups, for example, have developed standards for LANs and wireless networks..
```
# OSI Model
```
LAYER              PDU                 Common Protocols

7 - Application    Data                DNS, HTTP, TELNET

6 - Presentation   Data                SSL, TLS, JPEG, GIF

5 - Session        Data                NetBIOS, PPTP, RPC, NFS

4 - Transport      Segment/Datagram    TCP, UDP

3 - Network        Packet              IP, ICMP, IGMP

2 - Data Link      Frames              PPP, ATM, 802.2/3 Ethernet, Frame Relay

1 - Physical       Bits                Bluetooth, USB, 802.11 (Wi-Fi), DSL, 1000Base-T
```

##  2 Protocols, headers and tech
 2 of the OSI (Open Systems Interconnection) model, also known as the Data Link , is responsible for the efficient and reliable transfer of data between adjacent nodes on a network segment.  2 protocols, headers, and technologies operate at this  to facilitate communication within the local network.
```
Sub s

Media Access Control (MAC):
    The MAC sub- is responsible for controlling access to the physical transmission medium.
    Handles the transmission and reception of data frames over the physical medium, including addressing, framing, and error checking.

Logical Link Control (LLC):
    The LLC sub- is responsible for establishing, maintaining, and terminating logical links between network devices.
    Provides services such as error detection and flow control to ensure reliable data transmission over the physical medium.
    Follows the IEEE 802.2 standard.
    Manages communication between devices over a single link of the network that includes error checking and data flow.
```
## Switch Operation
A switch allows multiple users to access the network and can provide segmentation to isolate traffic flow and reduce collisions, relieving network congestion in most cases. All switches add small latency delays due to packet processing. These delays could be caused by port speed, frame processing (Cut-through or Store and Forward), port delay, and buffering delay. Deploying switches unnecessarily can actually slow down network performance.
```
Building the MAC-Address Table:
    Switches contain a special type of computer memory called Content-addressable memory (CAM) which allows very fast searching and table lookups. CAM is much faster than RAM. This is essential for switches to do very fast table lookups.     CAM is a very expensive type of memory and generates very high levels of heat. Thus CAM is not typically used in most other types of electronic devices. It is used to "look up" information (such as MAC addresses) and requires it to       have an exact match.


Switching Modes:
    Store-and-Forward accepts and analyzes the entire frame before forwarding it to its destination. It takes more time to examine the entire frame, but it allows the switch to catch certain frame errors and collisions and keep them from     propagating bad frames through the network. This method is required to switch frames between links of different speeds; this is due to bit-timing. The speed at which the bits enter one interface may be slower than the speed at which      the switch needs to send the bits to a different interface.

    Cut-Through (sometimes called fast forward) only examines the destination address before forwarding it to its destination segment. This is the fastest switching mode but requires the interfaces to be the same speed.

    Fragment-Free read at least 64 bytes of the Ethernet frame before switching it to avoid forwarding Ethernet runt frames (Ethernet frames smaller than 64 bytes). A frame should have a minimum of 46 bytes of payload plus its 18-byte        frame header.
```
## Ethernet Frames and MAC Addresses
```
42 Bit Mac Address Length , 6 Bytes
AA:BB:CC:11:22:33
OUI     |     NIC

Destination MAC Addresses (6 bytes)
    Initial 6 bytes (48 bits) contain the Destination MAC address.

    This can be Unicast, Multicast, or Broadcst MAC address.

    This is sent first to assist in switch operation of the cut-through mode.



Source MAC Addresses (6 bytes)
    Next 6 bytes (48 bits) contain the Source MAC Address.

    This is always a Unicast MAC address.

    It is worth noting that this is pretty much the only time that the destination address comes before the source. 
    The source address will come first in most other headers that we deal with in this course.

Ethertype (2 bytes) Used to indicate the next protocol encapsulated in the frame. This is provided by the LLC sub-.
    Common Ethertypes controlled by IANA.org:
        0x0800 - IPv4
        0x0806 - ARP
        0x86DD - IPv6
        0x8100 - VLAN Tagging 802.1q
        0x88A8 - Service VLAN tag identifier (S-Tag) (Q-in-Q tunnel)
        0x8863(4) - PPP over Ethernet (PPPoE)
        0x8847(8) - MPLS
        0x8892 - PROFINET Protoc

Data / Payload (46-1500 bytes)
    Consists of the encapsulated upper  headers and data payload which may be 46-1500 bytes.

FCS/CRC (Frame Check Sequence / Cyclical Redundancy Check) (4 bytes)
```
## VLAN/VLAN TYPES
```
Default - VLAN 1 is the default vlan.
Data - VLANs assigned for user traffic.
Voice - VLAN assigned for use for voice traffic only. Typically uses CDP messages from VOIP phones to be asigned.
Management - A form of data VLAN used for switch/router remote management purposes.
Native - VLAN used for switch/router generated traffic.
```
## 802.11Q - VLAN and 802.11AD - Double Tagging
```
Standard VLAN Tagging (IEEE 802.1Q):
    In a standard VLAN tagging scenario, each Ethernet frame includes a 4-byte VLAN tag inserted between the source MAC address and the EtherType/Length field.

    Ethertype uses is 0x8100.

QinQ VLAN Tagging:

    QinQ extends VLAN tagging by adding another  of VLAN tags, effectively allowing VLAN tagging within VLAN tagging.

    In a QinQ scenario, the original Ethernet frame is encapsulated within another VLAN tag, creating a "tagged outer frame" with its own VLAN ID.

88 A8 in VLAN Tag indicate Double tagging
```
## VTP Vlan Trunking Protocol
VLAN Trunking Protocol (VTP) is a Cisco proprietary protocol that propagates the definition of Virtual Local Area Networks (VLAN) on the whole local area network.
```
Server - can create, modify or delete VLANs. Can create and forward VTP messages.

Client - can only adopt VLAN information in VTP messages. Can forward VTP messages.

Transparent - only forwards VTP messages but does not adopt any of the information.
```
## DTP Dynamic Trunking Protocol
Dynamic Trunking Protocol (DTP) is a Cisco proprietary  2 protocol. Its purpose is to dynamically negotiate trunking on a link between two switches running VLANS

## CDP FDP LLDP
```
Cisco Discovery Protocol (CDP) is a  2, Cisco proprietary protocol used to share information with other directly connected Cisco devices.

Foundry Discovery Protocol (FDP) is a proprietary data link  protocol, originally developed by Foundry Networks, which was bought by Brocade. Similar to CDP, FDP enables Brocade devices to advertise to other directly connect Brocade devices on the network.


Link  Discovery Protocol (LLDP) was designed by IEEE 802.1AB to be a vendor-neutral neighbor discovery protocol similar to CDP. LLDP also operates at layer 2 and shares similar information as does CDP with directly connected devices that support LLDP.

** ALL of it is in Clear Text , Enabled by Default **
```

## STP Spanning Tree Protocol
STP works by creating "tree" within a network of connected layer-2 switches, and disable any links that are not part of this tree. The root of the tree determined by electing a Root Bridge and all the other switches are the branches. This essentially leaves only a single active path between any two network switches.
```
STP operates by flooding Bridge Protocol Data Units (BPDUs) to all other switches in the network.

These BPDUs are used to:
    Elect the Root Bridge

    Identify the Root port on each non-root bridge

    Identify the Designated port for each segment



To mitigate STP attack you can:

    Enable portfast to have a port immediately come up to the forwarding state.

        Globally by using spanning-tree portfast default

        By interface using spanning-tree portfast

    Enable BPDU guard to prevent BPDUs from beign allowed on a switchport.

        On each access port interface use spanning-tree bpduguard enable

        Must not use this command on any trunk or switch to switch connections.
```

## Port Security
The purpose of configuring port security technologies is to limit, restrict, and protect network access. Configuring port security can be done on active access ports to limit the number of users or MAC addresses allowed to access onto the network.
```
MAC Address Limit
MAC Address Learning

Violation Actions:
    protect - Drops any frames with an unknown source addresses.

    restrict - Same as protect except it additionally creates a violation counter report.

    shutdown - Places the interface into an "error-disabled" state immediately and sends an SNMP trap notification. This is typically the default mode.
```
## Layer 2 Attack Mitigations
```
Shutdown unused ports - Bare minimum to secure access ports is to simply shut down any and all inactive ports.

Switchport Port Security - Can be used to limit the number of MAC addresses that can be dynamically learned on a port or static MAC addresses can be assigned to one. Violation modes of shut down can be used to secure the port should a violation occur.

IP Source Guard - Mitigates the effects of IP address spoofing attacks on the Ethernet LAN. With IP source guard enabled, the source IP address in the packet sent from an untrusted access interface is validated against the DHCP snooping database. If the packet cannot be validated, it is discarded.

Manually assign STP Root - Manually assign the Spanning Tree Protocol (STP) root bridge allows for a deterministic root bridge election rather than the bridge with the lowest bridge priority. This allows the central most switch to be the root that will best allow traffic to flow in an efficent manner.

BPDU Guard - BPDU Guard is a feature used in network switches to enhance network security by protecting against unintentional loops and rogue devices. It works by automatically shutting down a port if it receives Bridge Protocol Data Units (BPDUs), which are indicative of spanning tree protocol (STP) activity.

DHCP Snooping - DHCP Snooping is a security feature commonly found in network switches that helps prevent rogue or unauthorized DHCP servers from distributing incorrect or malicious IP configuration information to network clients. It operates by monitoring and controlling DHCP messages exchanged between DHCP clients and servers. Configuration is done on ports that are connected to (or leading to) the DHCP server.

802.1x - The 802.1x standard defines a client-server-based access control and authentication protocol that prevents unauthorized clients from connecting to a LAN through ports until they are properly authenticated. The authentication server authenticates each client connected to a switchport before making available any services offered by the switch or the LAN.

Dynamic ARP inspection (DAI) - Prevents Address Resolution Protocol (ARP) spoofing or “man-in-the-middle” attacks. ARP requests and replies are compared against entries in the DHCP snooping database, and filtering decisions are made on the basis of the results of those comparisons.

Static CAM entries - Static CAM (Content Addressable Memory) entries refer to manually configured entries in the CAM table of Ethernet switches. These entries map specific MAC addresses to specific switch ports and are used to optimize network performance and facilitate specific network configurations.

Static ARP entries - Static ARP (Address Resolution Protocol) entries are manually configured mappings between IP addresses and MAC addresses in the ARP table of network devices. These entries are used to ensure stable communication between specific devices on the network.

Disable DTP negotiations - To disable Dynamic Trunking Protocol (DTP) negotiations on a Cisco switch interface, you need to manually configure the interface as an access port or set it to operate in a specific trunking mode, such as "trunk" or "nonegotiate."

Manually assign Access/Trunk ports - By default, switch ports can be either a trunk or access port depending on the device connected to the port and dynamic negotiations that take place. Manually assigning ports as either trunk or access ports provides greater control and ensures that the network operates as intended.
```

# IP Networking
## Classful IPv4 Addressing
```
CLASS A    0 to 127      /8
CLASS B    128 to 191    /16
CLASS C    192 to 223    /24
CLASS D    224 to 239    Multicast
CLASS E    240 to 255    Exper.
```
## IPv4 Types/Scopes
```
APIPA 169.254.0.0/24
Types
Unicast IPs are a "one to one" communication between two nodes.

Multicast IPs are used for a "one to many" communications concept throughout a network. Multicast addresses are used by routing protocols, video streaming, and other various systems that have need to communication in a group. These addresses fall within the Class D address range.

Broadcast A broadcast address is the last IP in every network subnet range. It is used to communicate to all nodes on the same network.

Scopes
Public IP ranges are assigned by IANA throughout the world. These addresses are typically any Class A, B, or C address that is not otherwised reserved. For more information on public addressing visit https://www.iana.org/numbers.

Private These IPs are not globally routable across the Internet and are available for use by all for internal LANs. These addresses must be translated to a public address for traversal across the internet.
    Class A scope 10.0.0.0/8 - 10.0.0.0 thru 10.255.255.255

    Class B scope 172.16.0.0/12 - 172.16.0.0 thru 172.31.255.255

    Class C scope 192.168.0.0/16 - 192.168.0.0 thru 192.168.255.255

Loopback address also called localhost. This is an internal address (127.0.0.1) linked back to the host machine. Can not be assigned to a device NIC. Can only be used to allow the system to address itself.
    Scope 127.0.0.0/8 - 127.0.0.0 thru 127.255.255.255

Link-Local is used for direct node to node communications on the same physical or logical link, not a routable range. This range is used for Microsoft’s Automatic Private IP Addressing (APIPA). This is used to allow DHCP configured clients to resolve an IP address even if no DHCP servers are available. Systems will auto generate an address in this range if it fails to get an IP address from the DHCP server. These addresses allow devices to communicate with each other on the same network but not across any routed boundries.
    Scope 169.254.0.0/16 - 169.254.0.0 thru 169.254.255.255

Multicast
    224.0.0.0/24 - Link-Local - multicast for host on the same network segment. Cannot traverse routed bounderies.

    239.255.0.0/16 - Local - scope is able to be controlled by an organization.

    239.192.0.0/14 - Organizational-local - routable within an organizations network.

    224.0.1.0-238.255.255.255 - Global - able to be routed across the internet.
```
# Fragmentation Offset
## Fragment Offset = (MTU - (IHL x 4)) / 8

## IPv6 address types
```
Unicast Addresses IPs are a "one to one" communication between two nodes.

Multicast Addresses Used for one to many communications and routing protocols.

Anycast Addresses These addresses can fall within the Global, Unique-Local, or Link-Local address scopes. They differ from unicast in that more than one device can be configured with the same address. These are typically used to address several network gateways. Each gateway can be configured with the same anycast address. Any of these devices can supply the service request for the client. These can also be used for servers when trying to load balance a particular service.
```
## IPv6 Scopes
```
Loopback Address IPv6 address used by a node on a vitural interface to send packets to itself. This is the same as the 127.0.0.1 is for IPv4.
    Scope is ::1/128

Global Unicast Addresses IPv6 addressess that are routable over the Internet.
    Scope is 2000::/3 - 2000:: thru 3fff::

    2001:0000:/32 - reserved for Teredo tunneling

    2001:20::/28 - reserved for ORCHIDv2

    2002::/16 - reserved for 6to4 tunneling

Unique-Local Addresses IPv6 addresses the are routable locally within a site, not globally routable across the Internet. These perform a similar function as the RFC 1918 private IPv4 addresses and will require NAT to translate the address to a Global Unicast address for communication over the Internet.

    Scope is fc00::/7 - fc00:: thru fdff::

Multicast addresses
    Scope ff00::/8 - ff00:: thru ffff::

        ffx0::/8 - reserved

        ffx1::/8 - interface-local - spans only a single interface on a host. Used for loopback multicast.

        ffx2::/8 - link-local - spans the local network. Does not traverse network bounderies. Comparable to 224.0.0.0/24 for IPv4.

        ffx3::/8 - realm-local - spans farther than link-local but under determination of the administrator. Should not bound farther than those below.

        ffx4::/8 - admin-local - smallest scope that can be administratively configured.

        ffx5::/8 - site-local - spans a single site of an organization.

        ffx8::/8 - organization-local - spans to all sites in a single organization.

        ffxe::/8 - global - spans all hosts on the internet and is unbounded.

        ffxf::/8 - reserved
```
## IGP vs EGP
```
    Interior Gateway Protocols (IGP):

        Routing protocols that are used within an Autonomous System (AS).

        Referred to as intra-AS routing.

        Organizations and service providers IGPs on their internal networks.

        IGPs include RIP, EIGRP, OSPF, and IS-IS.


    Exterior Gateway Protocols (EGP):

        Used primarily for routing between autonomous systems.

        Referred to as inter-AS routing.

        Service providers and large companies will interconnect their AS using an EGP.

        The Border Gateway Protocol (BGP) is the only currently viable EGP and is the official routing protocol used by the Internet.
```
## Routing vs Routed
```
Routed protocols allows data to be routed. These protocols provide an addressing scheme and sub-netting.

Routing Protocols are used by routers to communicate routing information with each other. Unless all routes are manually entered into the router, the router needs to learn from other routers about the networks that they know. 
Routing        Routed
______________________
RIP            IP
EIGRP          IPX
OSPF           AppleTalk
BGP            NetWare
```
## Routing Protocol vulnerabilities
```
Distributed Denial of Service (DDOS) - Attackers send more packets to the router than they can handle or process. This will cause the router to drop packets if proper QoS is not implemented.

Packet Mistreating Attacks (PMA) - Similar to DOS attacks, packet mistreating injects packets with malicious codes designed to confuse and disrupt the router and network.

Routing Table Poisoning (RTP) - Attackers can send specially crafted routing protocol packets to the router to poison the router’s tables. Enabling authentication can help mitigate this attack.

Hit and Run DDOS (HAR) - DDOS attack on a specific network or router.

Persistent Attacks (PA) - similar to hit and run, in which they both look to inject frequent harmful data packages into the router and network, helping the hackers gain control. The attacker can redirect traffic as they want, send       wrong routing updates, or simply delete the configuration of that router.
```

# Transport to Application Layer
The Transport layer (Layer 4) is responsible for the transfer of data, ensuring that data is error-free and in order.

## Port Ranges
```
0-1023         Well-Known(System)
1024-49151     Registered(User)
49152-65535    Dyanamic(Private)

Well-known (System) port numbers (0-1023), which are assigned by IANA are responsible for maintaining the official assignments of port numbers for specific uses. 

Registered (User) port numbers (1024-49151) can be registered with IANA for a specific service by a requesting entity. This range is loosely controled by IANA. Some operating systems may use this range as dynamically assigned source ports.

Dynamic (Private) port numbers (49152-65535) can not be registered with IANA. These ports are for use as temporary, private, or/and for automatic allocation of ephemeral ports. This range is not controlled in any way by IANA for any protocols and services.
```

## VPN
Virtual Private Networks (VPN) allows connections through a network that is not accessible to everyone else. This "private" connection makes is look like a direct connection, when in fact it is not. VPNs work by encapsulating an IP packet into another IP packet for traversal across a (generally) public network. The outer IP packet headers used for the traversal is then removed and the original packet headers are then used for further routing decisions
```
Remote Access VPN

Site-to-Site VPN (aka router-to-router VPN)

Client-to-Site VPN (aka endpoint-to-site VPN)
```
```
L2TP
Layer Two Tunneling Protocol (L2TP) serves as an extension of the Point-to-Point Tunneling Protocol (PPTP) commonly employed by internet service providers (ISPs) to establish virtual private networks (VPNs). The primary objective of L2TP is to enable secure data transmission through the creation of tunnels. To uphold security and privacy standards, L2TP necessitates the use of an encryption protocol within the established tunnel.

PPTP
Point-to-Point Tunneling Protocol (PPTP) stands as a foundational networking protocol that empowers the secure deployment of Virtual Private Networks (VPNs) over the Internet. Conceived by Microsoft and collaborative contributors, PPTP is intricately designed to forge a private and encrypted communication conduit between clients and servers, guaranteeing the secure transmission of data

L2F
Cisco Proprietary

IP Security (IPSec)
Psec (Internet Protocol Security) is a suite of protocols used to secure IP communications by providing encryption, authentication, and integrity protection at the network layer (Layer 3) of the OSI model. It is widely used to establish Virtual Private Networks (VPNs) and secure data transmission over IP networks, including the internet.

OpenVPN
OpenVPN is an open-source VPN (Virtual Private Network) software that provides secure communication over the internet by creating encrypted tunnels between devices or networks. It is widely used for remote access VPNs, site-to-site VPNs, and other secure networking applications.
OpenVPN requires special software that implements the OpenVPN protocol. There are client and server versions. The client software runs on your device (computer, phone, etc.) and the server software runs on the VPN provider’s server. This software creates the encrypted tunnel and manages the data transmission.
It’s known for being very secure due to strong encryption algorithms and multiple authentication methods. OpenVPN uses the OpenSSL library to provide encryption of both the data and control channels.
```
## SOCKS
SOCKS (Socket Secure) is a protocol that facilitates communication between clients and servers through a proxy server.
```
Initiates connections through a proxy

Uses various Client / Server exchange messages

Client can provide authentication to server

Client can request connections from server

Defined in RFC 1928
```

## SOCKS4
```
No Authentication, meaning that it does not require clients to authenticate themselves before connecting to the proxy server.

Only IPv4

Only TCP support. No UDP support. ** MEANING UDP SCAN OR ANYTHING UDP WILL NOT WORK

No Proxy binding. Client’s IP is not relayed to destination.
```

## SOCKS5
```
Support for Authentication, allowing clients to authenticate themselves using various methods, such as username/password, GSS-API (Generic Security Services Application Program Interface), or digital certificates.

IPv4 and IPv6 support

TCP and UDP support

Supports Proxy binding. Client’s IP is relayed to destination
```
## NETBIOS
Network Basic Input/Output System,This suite offers a collection of services along with an application programming interface (API), facilitating network communication across local area networks (LANs)
TCP 139, UDP 137/138
```
Windows:
nbtstat -A <IP Address>

Linux:
nbtscan -r <IP Address>
```
## SMB/CIFS
SMB/CIFS (TCP 139/445 AND UDP 137/138)
```
The Server Message Block (SMB) protocol serves as a communication protocol predominantly utilized by Microsoft Windows-equipped computers. Its primary function is to facilitate the sharing of files, printers, serial ports, and various communications among network nodes. For user authentication, SMB employs either the NTLM or Kerberos protocols

smbclient -L <IP Address>
```
## SSH Architecture
```
Server
Known as sshd in most linux SSH implementations, this allows incoming SSH connections and handles authentication and authorization.

Clients
This is the program that connects to the SSH server for a request, examples include scp and ssh

Sessions ** PRIVATE KEY NEVER SHARED
The client and server conversation that begins after successful mutual authentication.

Keys
There are several keys that are used in SSH:

    User Key - Asymmetric Public key created used to identify the user to a server (generated by the user)

    Host Key - Asymmetric Public key created to identify a server to a user (generated by an administrator)

    Session Key - Symmetric Key created by the client and the server that protects the communication for a particular session
```

** IMPORTANT - Keep track of the ports you use for tunneling

## SSH Files
Known-Hosts Database ~/.ssh/know_hosts

## Config Files
```
/etc/ssh/ssh_config
/etc/ssh/sshd_config
```
## DHCPv4
UDP 67/68
Dynamic Host Configuration Protocol (DHCP) is an internet standard used to assign IP address parameters across an enterprise. This prevent administrators from having to manually assign IP configuration on each host individually.
```
(D.O.R.A) PROCESS
Discover
OFFER
Request
Acknowledge
```

## NTP - Network Time Protocol
UDP 123 The Network Time Protocol (NTP) is a networking protocol for clock synchronization between computer systems over packet-switched, variable-latency data networks. NTP is intended to synchronize all participating computers to within a few milliseconds of Coordinated Universal Time (UTC)


# AAA Services

## TACACS+ Terminal Access Controller Access-Control System Plus
TCP 49 SIMPLE/EXTENDED
The Terminal Access Controller Access-Control System Plus (TACACS+) is a network security protocol used for centralized authentication, authorization, and accounting (AAA) services in network devices such as routers, switches, and firewalls. Developed by Cisco Systems, TACACS+ provides a robust framework for controlling access to network resources and enforcing security policies

## RADIUS Remote Authentication Dial-In User Service
UDP1645/1646 and 1812/1823
Remote Authentication Dial-In User Service (RADIUS) is a open standard networking protocol used for centralized authentication, authorization, and accounting (AAA) services in network environments. It enables devices like network access servers (NAS), VPN gateways, and wireless access points to authenticate users and authorize their access to network resources.

## DIAMETER 
TCP 3868
Diameter is a networking protocol used for Authentication, Authorization, and Accounting (AAA) functions in network systems, primarily in telecommunications networks. It is an evolution of the older RADIUS (Remote Authentication Dial-In User Service) protocol, providing enhanced features and capabilities

## SNMP Simple Network Management Protocol
UDP 161/162
Simple Network Management Protocol (SNMP) is an Internet Standard protocol for collecting and organizing information about managed devices on IP networks. Devices that typically support SNMP include cable modems, routers, switches, servers, workstations, printers, and more.

## RTP Real-Time Transport Protocol
(ANY UDP PORT OVER 1023)
RTP (Real-time Transport Protocol) is primarily used for streaming real-time media over IP networks. It is a protocol specifically designed for transmitting audio and video data in a way that supports time-sensitive applications, such as voice and video communication, streaming media, and live broadcasts.

## RDP Remote Desktop Protocol
TCP 3389
The protocol is widely supported across most Windows, Unix, Linux, and macOS operating systems. Other proprietary options were developed to provide remote desktop support but the administrator typically must install the client software on each device before being able to remotely access devices with these 3rd party tools

## Kerberos 
UDP 88
Kerberos is a network authentication protocol that ensures secure authentication for client-server applications. It was created by MIT as a network authentication protocol using secret-key cryptography. It relies on a trusted Key Distribution Center (KDC) server. Used by Active Directory

## LDAP Ligthweight Directory Access Protocol
TCP 389 and 636
The Lightweight Directory Access Protocol (LDAP) is an application protocol used for accessing and managing distributed directory information services. LDAP provides a standardized method for querying, modifying, and authenticating against directory services, such as Active Directory and OpenLDAP. DAPS (LDAP over SSL/TLS) is a secure communication protocol used to encrypt LDAP traffic between LDAP clients and servers. It provides a layer of security to LDAP authentication and directory access by encrypting data exchanged over the network, protecting it from eavesdropping and tampering.

## CDP Protocol
Use Cisco Discovery Protocol to get Router Info

## BPF Filters
```
capture all packets with a ttl of 64 and less, utilizing the IPv4 or IPv6 Headers?
tcpdump -n 'ip[8]<=64 || ip6[7]<=64'

capture all IPv4 packets with at least the Dont Fragment bit set
tcpdump -n 'ip[6] & 64=64'

capture traffic with a Source Port higher than 1024, utilizing the correct Transport Layer Headers?
tcpdump -n 'tcp[0:2] > 1024 || udp[0:2] > 1024'

capture all Packets with UDP protocol being set, utilizing the IPv4 or IPv6 Headers?
tcpdump -n 'ip[9] = 0x11 || ip6[6] = 0x11'

capture only packets with the ACK/RST or ACK/FIN flag set, utilizing the correct Transport Layer Header?
tcpdump -n 'tcp[13] = 0x14 || tcp[13] = 0x11'

capture all packets with an IP ID field of 213?
tcpdump -n 'ip[4:2] = 213'

capture all packets relating to DNS
tcpdump -n  'tcp[0:2] = 53 || udp[0:2] = 53 || tcp[2:2] = 53 || udp[2:2] = 53'

capture the initial packets from a client trying to initiate a TCP connection
tcpdump -n 'tcp[13] = 0x02'

capture the response packets from a server with closed TCP ports
tcpdump -n 'tcp[13] = 0x04'

capture all TCP and UDP packets sent to the well known ports
tcpdump -n 'tcp[2:2]<=1023 || udp[2:2]<=1023'

capture all HTTP traffic
tcpdump -n 'tcp[0:2] = 80 || tcp [2:2] = 80'

capute all ARP traffic
tcpdump -n 'ether[12:2] = 0x0806'

capture if "Evil Bit" (RES bit) is set 
tcpdump -n 'ip[6] & 0x80 = 0x80'

capture any packets contain the CHAOS protocol with ipv4 header
tcpdump -n 'ip[9] = 16'

capture all IPv4 packets with the DSCP field of 37
** Use Programming Calc to shift bits between on and off
Ex:
0010 0101 = 37
Shift 'ON' bits two to left and turn off previously set 'ON' bits
1001 0100 = 148

capture all IPv4 packets targeting just the beginning of potential traceroutes as it's entering your network. This can be from a Windows or Linux machine using their default settings
tcpdump -n 'ip[8] = 1&&(ip[9] = 0x01 || ip[9] = 0x11)'

capture all packets where the URG flag is not set and URG pointer has a value
tcpdump -n 'tcp[13]&32!=32&&tcp[18:2]>0'

capture a TCP null scan to the host 10.10.10.10
tcpdump -n 'ip[16:4] = 0x0a0a0a0a && tcp[13] = 0'

capture an attacker using vlan hopping to move from vlan 1 to vlan 10
tcpdump -n 'ether[12:4]&0xffff0fff=0x81000001&&ether[16:4]&0xffff0fff=0x8100000A'



```
