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


