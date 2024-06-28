# Network Analysis

# Types of Sensors
```
IN-LINE
  - Test Access Point (TAP)
    -- Placed between two network devices

  - IPS 
  - Firewall
  - Man-in-the-middle (MitM)
  
OUT of BAND (Passive)
  - Switched Port Analyzer (SPAN)
    -- Configured on Network Switch
  - IDS
```
## Ephemeral Ports
```
    IANA 49152–65535

    Linux 32768–60999

    Windows XP 1025–5000

    Win 7/8/10 use IANA

    Win Server 2008 1025–60000

    Sun Solaris 32768–65535
```
## P0F (Passive OS Fingerprinting)
```
    Looks at variations in initial TTL, fragmentation flag, default IP header packet length, window size, and TCP options

 Configuration stored in:

 /etc/p0f/p0f.fp
```
## Anomaly Detection
```
Indicator of Attack (IOA)
  - Code Execuction, Persistence, lateral movement

Indicator of Compromise (IOC)
  - Malware, Exploits, Signatures

Examples of Indicators:
   - .exe/executable files
   - NOP sled
   - Repeated Letters
   - Well Known Signatures
   - Mismatched Protocols
   - Unusual traffic
   - Large amounts of traffic/ unusual times
```
