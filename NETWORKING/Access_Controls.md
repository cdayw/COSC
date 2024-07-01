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

iptables -t [table] -A [chain] [rules] -j [action]

    Table: filter*, nat, mangle

    Chain: INPUT, OUTPUT, PREROUTING, POSTROUTING, FORWARD
```
