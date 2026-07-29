# Objective
The objective of this lab is to perform a network traffic analysis by simulating an attack scenario using Cisco Packet Tracer. This involves configuring an attacker node to generate traffic and analyzing the resulting packets using a network sniffer.


## Tool Used
* **Cisco Packet Tracer**


## Methodology
1. **Network Topology Setup:** Establish a network topology consisting of an Attacker PC, a Switch, and a Target Server connected via appropriate media.
2. **Traffic Generation:** Configure the Attacker PC to generate specific traffic types, such as PING and TFTP, directed toward the Target Server's IP address.
3. **Traffic Monitoring:** Implement port monitoring (SPAN) on the Switch to mirror traffic from the source interface (Attacker PC connection) to a destination interface where a sniffer device is connected.
4. **Capture and Analysis:** Use the sniffer device in the simulation environment to capture and examine the generated traffic packets, observing header information and protocol details.


## Observations
* **Topology Construction:** The network was successfully set up with an Attacker PC (`IP: 192.168.1.100`) and a Target Server (`IP: 192.168.1.10`).
* **Traffic Simulation:** PING and TFTP traffic were successfully generated from the Attacker PC to the Target Server.
* **Monitoring Configuration:** SPAN was configured on the switch using the commands: 
  ```
  monitor session 1 source interface fa0/1
  monitor session 1 destination interface fa0/3
allowing traffic to be mirrored to the sniffer.
* **Packet Capture:** The sniffer device successfully captured the traffic, revealing packet details such as source/destination IP addresses, protocol headers, and port numbers.


## Images
#### Figure 1: Cisco Packet Tracer network topology showing the Attacker PC, switch, and Target Server.

<img width="1920" height="1080" alt="Screenshot (93)" src="https://github.com/user-attachments/assets/700514b0-67d0-4977-b5de-f4028cd23338" />

#### Figure 2: Traffic Generator settings on the Attacker PC configured for PING.

<img width="1586" height="702" alt="Screenshot 2026-07-24 131624" src="https://github.com/user-attachments/assets/8d4632c7-30c4-4270-b65d-6b6273df69dc" />

#### Figure 3: Complex PDU creation settings for TFTP traffic.

<img width="370" height="662" alt="Screenshot 2026-07-24 133546" src="https://github.com/user-attachments/assets/e8ae7bd4-f051-40fa-9b57-23b1ce0a34d0" />

#### Figure 4: Simulation panel displaying successful traffic transmission between the Attacker and Target.

<img width="1920" height="1080" alt="Screenshot (94)" src="https://github.com/user-attachments/assets/3240621f-176f-4264-a7e9-af858b709f07" />

#### Figure 5: Network topology with a Sniffer device connected to the switch for traffic monitoring.

<img width="1920" height="1080" alt="Screenshot (95)" src="https://github.com/user-attachments/assets/d4826101-1931-48c3-b704-efdff95a7f9f" />

#### Figure 6: Switch configuration commands to set up port monitoring (SPAN) for traffic analysis.

<img width="671" height="253" alt="Screenshot 2026-07-24 135743" src="https://github.com/user-attachments/assets/688904f5-3426-4d20-9733-f127b2bd3d70" />

#### Figure 7: Sniffer device capturing and displaying detailed packet information.

<img width="1920" height="1080" alt="Screenshot (97)" src="https://github.com/user-attachments/assets/61c1a487-7dbb-451b-82b6-363970479a6e" />


## Conclusion
This lab successfully demonstrated the ability to simulate and capture network traffic for analysis. By configuring SPAN on a network switch and utilizing a sniffer, I was able to intercept and inspect packet data. This process is fundamental for identifying suspicious traffic patterns and understanding network security vulnerabilities.


## Skills Learned
* Setting up network topologies in Cisco Packet Tracer.
* Understanding and configuring Port Mirroring (SPAN) for traffic analysis.
* Generating and simulating different types of network traffic (ICMP, TFTP).
* Analyzing packet headers and protocol structures using a network sniffer.
