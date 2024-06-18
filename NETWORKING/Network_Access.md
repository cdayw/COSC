# Networking INFO
```
Networking cybbh - https://net.cybbh.io/public/networking/latest/index.html
Miro Whiteboard - https://miro.com/app/board/o9J_klSqCSY=/
CTFD1 - http://networking-ctfd-1.server.vta:8000/resources
Jump Box - 10.50.37.63
```
## Internet Standard Organizations 
```
Internet Engineering Task Force (IETF): The IETF is a large open international community of network designers, operators, vendors, and researchers who are concerned with the evolution and operation of the Internet. It focuses on the development of protocols and standards, with working groups dedicated to specific areas such as routing, security, and web technologies.

Internet Assigned Numbers Authority (IANA): IANA is responsible for the global coordination of the DNS root, IP addressing, internet numbers, and other Internet protocol resources. While not primarily a standards development organization, IANA’s role in managing critical Internet resources is vital to the functioning of the Internet.

Institute of Electrical and Electronics Engineers (IEEE): While the IEEE is a broader organization covering various fields of technology, it plays a significant role in developing standards for networking and communication technologies. The IEEE 802 working groups, for example, have developed standards for LANs and wireless networks.
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

1 - Physical       Bits               Bluetooth, USB, 802.11 (Wi-Fi), DSL, 1000Base-T
```
## Layer 2 Protocols, headers and tech
Layer 2 of the OSI (Open Systems Interconnection) model, also known as the Data Link Layer, is responsible for the efficient and reliable transfer of data between adjacent nodes on a network segment. Layer 2 protocols, headers, and technologies operate at this layer to facilitate communication within the local network.
```
Sub Layers

Media Access Control (MAC):
    The MAC sub-layer is responsible for controlling access to the physical transmission medium.
    Handles the transmission and reception of data frames over the physical medium, including addressing, framing, and error checking.

Logical Link Control (LLC):
    The LLC sub-layer is responsible for establishing, maintaining, and terminating logical links between network devices.
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

Ethertype (2 bytes) Used to indicate the next protocol encapsulated in the frame. This is provided by the LLC sub-layer.
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
    Consists of the encapsulated upper layer headers and data payload which may be 46-1500 bytes.

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

    QinQ extends VLAN tagging by adding another layer of VLAN tags, effectively allowing VLAN tagging within VLAN tagging.

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
Dynamic Trunking Protocol (DTP) is a Cisco proprietary Layer 2 protocol. Its purpose is to dynamically negotiate trunking on a link between two switches running VLANS

## CDP FDP LLDP
```
Cisco Discovery Protocol (CDP) is a Layer 2, Cisco proprietary protocol used to share information with other directly connected Cisco devices.

Foundry Discovery Protocol (FDP) is a proprietary data link layer protocol, originally developed by Foundry Networks, which was bought by Brocade. Similar to CDP, FDP enables Brocade devices to advertise to other directly connect Brocade devices on the network.


Link Layer Discovery Protocol (LLDP) was designed by IEEE 802.1AB to be a vendor-neutral neighbor discovery protocol similar to CDP. LLDP also operates at layer 2 and shares similar information as does CDP with directly connected devices that support LLDP.

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
