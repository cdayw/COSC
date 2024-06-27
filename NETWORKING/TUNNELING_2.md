```
Task 4 - Donovian Data Collection: Will open when Task 3 is complete

    T5 Float IP address is - 10.50.27.147
    Credentials: Same as Task 3.
```
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
IH> proxychains telnet 172.16.0.60
IH> ssh net1_comrade5@localhost -R 10588:192.168.0.40:22


## Establish tunnels and telnet, bridge tunnels to and from 172.16.0.60
IH> telnet 10.50.27.147
ssh-01> ssh student@10.50.37.63 -R 10501:localhost:22
IH> ssh net1_student5@localhost -p 10501 -L 10502:192.168.0.40:5555
IH> ssh net1_student5@localhost -p 10503 -L 10504:172.16.0.60:23
IH> telnet localhost 10504
IH> ssh-06> ssh net1_student5@192.168.0.40 -p 5555 -R 10511:localhost:22
IH> ssh net1_student5@localhost -p 10503 -L 10540:localhost:10511
IH> ssh net1_comrade5@localhost -D 9050 -p 10540
IH> ssh net1_student5@localhost -p 10502 -L 10503:192.168.0.40:5555


```
