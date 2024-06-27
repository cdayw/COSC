```
Task 4 - Donovian Data Collection: Will open when Task 3 is complete

    T5 Float IP address is - 10.50.27.147
    Credentials: Same as Task 3.
```
#Setup Remote Tunnel from Internal Machine at 10.50.27.147 
#Setup Dyanmic Tunnel to exploit web server
IH> telnet 10.50.27.147
SSH01> ssh student@10.50.37.63 -R 10599:localhost:22
IH> ssh net1_student5@localhost -D 9050 -p 10599
IH> proxychains wget -r http://192.168.0.10

#Setup Tunnel to SSH-02 based off previous Reverse Tunnel
IH> ssh net1_student5@localhost -p 10599 -L 10550:192.168.0.20:3333
IH> ssh net1_student5@localhost -p 10550

#Setup Dynamic Tunnel for proxychains
IH> ssh ssh net1_student5@localhost -D 9050 -p 10550
IH> proxychains wget -r ftp://192.168.0.50
IH> proxychains wget -r http://192.168.0.50

#Setup Tunnel to SSH-04 based of original Reverse Tunnel 
IH> ssh net1_student5@localhost -p 10599 -L 10551:192.168.0.40:5555
IH> ssh net1_student5@localhost -p 10551
