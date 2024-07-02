![image](https://github.com/cdayw/COSC/assets/169062872/f279de30-1dc9-44ae-ab88-37aa12e59c4b)

## Netfilter hooks - > Chain
```
    NF_IP_PRE_ROUTING → PREROUTING

    NF_IP_LOCAL_IN → INPUT

    NF_IP_FORWARD → FORWARD

    NF_IP_LOCAL_OUT → OUTPUT

    NF_IP_POST_ROUTING → POSTROUTING
```

# IPTABLES
## Tables of iptables
```
    filter - default table. Provides packet filtering.

    nat - used to translate private ←→ public address and ports.

    mangle - provides special packet alteration. Can modify various fields header fields.

    raw - used to configure exemptions from connection tracking.

    security - used for Mandatory Access Control (MAC) networking rules.

    PREROUTING - packets entering NIC before routing

    INPUT - packets to localhost after routing

    FORWARD - packets routed from one NIC to another. (needs to be enabled)

    OUTPUT - packets from localhost to be routed

    POSTROUTING - packets leaving system after routing

Chains assigned to each Table

    filter - INPUT, FORWARD, and OUTPUT

    nat - PREROUTING, POSTROUTING, INPUT, and OUTPUT

    mangle - All chains

    raw - PREROUTING and OUTPUT

    security - INPUT, FORWARD, and OUTPUT
```
## Common iptable options
```
-t - Specifies the table. (Default is filter)
-A - Appends a rule to the end of the list or below specified rule
-I - Inserts the rule at the top of the list or above specified rule
-R - Replaces a rule at the specified rule number
-D - Deletes a rule at the specified rule number
-F - Flushes the rules in the selected chain
-L - Lists the rules in the selected chain using standard formatting
-S - Lists the rules in the selected chain without standard formatting
-P - Sets the default policy for the selected chain
-n - Disables inverse lookups when listing rules
--line-numbers - Prints the rule number when listing rules

-p - Specifies the protocol
-i - Specifies the input interface
-o - Specifies the output interface
--sport - Specifies the source port
--dport - Specifies the destination port
-s - Specifies the source IP
-d - Specifies the destination IP
-j - Specifies the jump target action

-m state --state NEW,ESTABLISHED,RELATED,UNTRACKED,INVALID
-m mac [ --mac-source | --mac-destination ] [mac]
-p [tcp|udp] -m multiport [ --dports | --sports | --ports { port1 | port1:port15 } ]
-m bpf --bytecode [ 'bytecode' ]
-m iprange [ --src-range | --dst-range { ip1-ip2 } ]

    ACCEPT - Allow the packet
    REJECT - Deny the packet (send an ICMP reponse)
    DROP - Deny the packet (send no response)
-j [ ACCEPT | REJECT | DROP ]

iptables -t [table] -A [chain] [rules] -j [action]

    Table: filter*, nat, mangle

    Chain: INPUT, OUTPUT, PREROUTING, POSTROUTING, FORWARD
```

## Mangle examples with iptables
```
iptables -t mangle -A POSTROUTING -o eth0 -j TTL --ttl-set 128
iptables -t mangle -A POSTROUTING -o eth0 -j DSCP --set-dscp 26
```


# NFTABLES
```
ip - IPv4 packets
ip6 - IPv6 packets
inet - IPv4 and IPv6 packets
arp - layer 2
bridge - processing traffic/packets traversing bridges.
netdev - allows for user classification of packets - nftables passes up to the networking stack (no counterpart in iptables)

NFTables hooks
    ingress - netdev only
    prerouting
    input
    forward
    output
    postrouting

NFTables Chain-types

There are three chain types:
    filter - to filter packets - can be used with arp, bridge, ip, ip6, and inet families
    route - to reroute packets - can be used with ip and ipv6 families only
    nat - used for Network Address Translation - used with ip and ip6 table families only

nft add table [family] [table]

    [family] = ip*, ip6, inet, arp, bridge and netdev.

    [table] = user provided name for the table.

nft add chain [family] [table] [chain] { type [type] hook [hook]
    priority [priority] \; policy [policy] \;}

* [chain] = User defined name for the chain.
* [type] =  can be filter, route or nat.
* [hook] = prerouting, ingress, input, forward, output or
         postrouting.
* [priority] = user provided integer. Lower number = higher
             priority. default = 0. Use "--" before
             negative numbers.
* ; [policy] ; = set policy for the chain. Can be
              accept (default) or drop.

 Use "\" to escape the ";" in bash


Create a rule in the Chain

nft add rule [family] [table] [chain] [matches (matches)] [statement]
* [matches] = typically protocol headers(i.e. ip, ip6, tcp,
            udp, icmp, ether, etc)
* (matches) = these are specific to the [matches] field.
* [statement] = action performed when packet is matched. Some
              examples are: log, accept, drop, reject,
              counter, nat (dnat, snat, masquerade)

Rule Match options

ip [ saddr | daddr { ip | ip1-ip2 | ip/CIDR | ip1, ip2, ip3 } ]
tcp flags { syn, ack, psh, rst, fin }
tcp [ sport | dport { port1 | port1-port2 | port1, psudo iptables -A OUTPUT -p tcp -m multiport --ports 22,23,3389 -j ACCEPT
ort2, port3 } ]
udp [ sport| dport { port1 | port1-port2 | port1, port2, port3 } ]
icmp [ type | code { type# | code# } ]

Rule Match options

ct state { new, established, related, invalid, untracked }
iif [iface]
oif [iface]

Modify NFTables

nft { list | flush } ruleset
nft { delete | list | flush } table [family] [table]
nft { delete | list | flush } chain [family] [table] [chain]

Modify NFTables

List table with handle numbers

    nft list table [family] [table] [-a]

 Adds after position

    nft add rule [family] [table] [chain] [position <position>] [matches] [statement]

Inserts before position

    nft insert rule [family] [table] [chain] [position <position>] [matches] [statement]

Replaces rule at handle

    nft replace rule [family] [table] [chain] [handle <handle>] [matches] [statement]

 Deletes rule at handle

    nft delete rule [family] [table] [chain] [handle <handle>]

 Create the NAT table

    nft add table ip NAT

    Create the NAT chains

    nft add chain ip NAT PREROUTING { type nat hook prerouting priority 0 \; }

    nft add chain ip NAT POSTROUTING { type nat hook postrouting priority 0 \; }

Source NAT

    nft add rule ip NAT POSTROUTING ip saddr 10.10.0.40 oif eth0 snat 144.15.60.11

    nft add rule ip NAT POSTROUTING oif eth0 masquerade

Destination NAT

    nft add rule ip NAT PREROUTING iif eth0 ip daddr 144.15.60.11 dnat 10.10.0.40

    nft add rule ip NAT PREROUTING iif eth0 tcp dport { 80, 443 } dnat 10.1.0.3

    nft add rule ip NAT PREROUTING iif eth0 tcp dport 80 redirect to 8080
```
## Mangle examples with nftables
```
nft add table ip MANGLE

nft add chain ip MANGLE INPUT {type filter hook input priority 0 \; policy accept \;}

nft add chain ip MANGLE OUTPUT {type filter hook output priority 0 \; policy accept \;}

nft add rule ip MANGLE OUTPUT oif eth0 ip ttl set 128

nft add rule ip MANGLE OUTPUT oif eth0 ip dscp set 26
```

## IPTABLES - Filtering T1
```
Allow New and Established traffic to/from via SSH, TELNET, and RDP
sudo iptables -A INPUT -p tcp -m multiport --ports 22,23,3389 -j ACCEPT
sudo iptables -A OUTPUT -p tcp -m multiport --ports 22,23,3389 -j ACCEPT

Change the Default Policy in the Filter Table for the INPUT, OUTPUT, and FORWARD chains to DROP
sudo iptables -P INPUT DROP
sudo iptables -P OUTPUT DROP
sudo iptables -P FORWARD DROP

Allow ping (ICMP) requests (and reply) to and from the Pivot.
sudo iptables -A INPUT -p icmp --icmp-type 8 -s 10.10.0.40 -j ACCEPT
sudo iptables -A INPUT -p icmp --icmp-type 8 -d 10.10.0.40 -j ACCEPT
sudo iptables -A OUTPUT -p icmp --icmp-type 8 -s 10.10.0.40 -j ACCEPT
sudo iptables -A OUTPUT -p icmp --icmp-type 8 -d 10.10.0.40 -j ACCEPT

sudo iptables -A INPUT -p icmp --icmp-type 0 -s 10.10.0.40 -j ACCEPT
sudo iptables -A INPUT -p icmp --icmp-type 0 -d 10.10.0.40 -j ACCEPT
sudo iptables -A OUTPUT -p icmp --icmp-type 0 -s 10.10.0.40 -j ACCEPT
sudo iptables -A OUTPUT -p icmp --icmp-type 0 -d 10.10.0.40 -j ACCEPT

Allow ports 6579 and 4444 for both udp and tcp traffic
sudo iptables -A INPUT -p tcp -m multiport --ports 6579,4444 -j ACCEPT
sudo iptables -A INPUT -p udp -m multiport --ports 6579,4444 -j ACCEPT
sudo iptables -A OUTPUT -p tcp -m multiport --ports 6579,4444 -j ACCEPT
sudo iptables -A OUTPUT -p udp -m multiport --ports 6579,4444 -j ACCEPT

Allow New and Established traffic to/from via HTTP
sudo iptables -A INPUT -p tcp --sport 80 -j ACCEPT
sudo iptables -A INPUT -p tcp --dport 80 -j ACCEPT
sudo iptables -A OUTPUT -p tcp --sport 80 -j ACCEPT
sudo iptables -A OUTPUT -p tcp --dport 80 -j ACCEPT
```

## FILTERING T2
```
    Create input and output base chains with:
    Hooks
    Priority of 0
    Policy as Accept

    Allow New and Established traffic to/from via SSH, TELNET, and RDP

    Change your chains to now have a policy of Drop

    Allow ping (ICMP) requests (and reply) to and from the Pivot.

    Allow ports 5050 and 5150 for both udp and tcp traffic to/from

    Allow New and Established traffic to/from via HTTP


sudo nft add table ip CCTC

sudo nft add chain ip CCTC INPUT { type filter hook input priority 0 \; policy accept \;}
sudo nft add chain ip CCTC OUTPUT { type filter hook output priority 0 \; policy accept \;}

nft add rule ip CCTC OUTPUT tcp dport { 22, 23, 80, 3389 } ct state { new, established } accept
nft add rule ip CCTC INPUT tcp dport { 22, 23, 80, 3389 } ct state { new, established } accept
nft add rule ip CCTC OUTPUT tcp sport { 22, 23, 80, 3389 } ct state { new, established } accept
nft add rule ip CCTC INPUT tcp sport { 22, 23, 80, 3389 } ct state { new, established } accept

nft add rule ip CCTC INPUT udp sport { 5050, 5150 } accept
nft add rule ip CCTC INPUT udp dport { 5050, 5150 } accept
nft add rule ip CCTC OUTPUT udp sport { 5050, 5150 } accept
nft add rule ip CCTC OUTPUT udp dport { 5050, 5150 } accept

nft add rule ip CCTC INPUT tcp sport { 5050, 5150 } accept
nft add rule ip CCTC INPUT tcp dport { 5050, 5150 } accept
nft add rule ip CCTC OUTPUT tcp sport { 5050, 5150 } accept
nft add rule ip CCTC OUTPUT tcp dport { 5050, 5150 } accept

INBOUND
nft add rule ip CCTC INPUT icmp type 8 ip daddr 10.10.0.40 accept
nft add rule ip CCTC OUTPUT icmp type 0 ip saddr 10.10.0.40 accept
nft add rule ip CCTC INPUT icmp type 0 ip saddr 10.10.0.40 accept
nft add rule ip CCTC INPUT icmp type 8 ip saddr 10.10.0.40 accept

OUTBOUND
nft add rule ip CCTC OUTPUT icmp type 8 ip saddr 10.10.0.40 accept
nft add rule ip CCTC INPUT icmp type 0 ip daddr 10.10.0.40 accept
nft add rule ip CCTC OUTPUT icmp type 0 ip saddr 10.10.0.40 accept     
nft add rule ip CCTC OUTPUT icmp type 8 ip daddr 10.10.0.40 accept     

sudo nft add chain ip CCTC INPUT { type filter hook input priority 0 \; policy drop \;}
sudo nft add chain ip CCTC OUTPUT { type filter hook output priority 0 \; policy drop \;}
```

## NAT + IPTABLES 
```
On T1 edit the /proc/sys/net/ipv4/ip_forward file to enable IP Forwarding. Change the value from 0 to 1. On T1 change the FORWARD policy back to ACCEPT.

Configure POSTROUTING chain to translate T5 IP address to T1 (Create the rule by specifying the Interface information first then Layer 3)
iptables -t nat -A POSTROUTING -p tcp -o eth0 -j MASQUERADE
```

## NAT + NFTABLES
```
```
