# Objective

The objective of this laboratory exercise is to perform an ACL (Access Control List) Firewall simulation using Cisco Packet Tracer.

## Tool Used
* Cisco Packet Tracer

## Methodology
* **Network Topology Design:** Created a network topology in Cisco Packet Tracer consisting of a central router connecting three distinct networks: a Guest network, an Employee network, and an Admin Server network.
* **IP Configuration:** Configured the router interfaces to assign specific IP addresses to each network: `192.168.10.0/24` for the Guest network, `192.168.20.0/24` for the Employee network, and `10.0.0.0/24` for the Admin Server network. (See Figure 2 for configuration details).
* **Connectivity Testing:** Conducted initial connectivity tests using ICMP (ping) to ensure all devices could communicate with each other before applying security restrictions. (See Figure 3).
* **ACL Implementation:** Configured an Extended Access Control List (ACL) on the router to deny traffic from the Guest network (`192.168.10.0/24`) to the Admin Server host (`10.0.0.100`), while permitting all other traffic. (See Figure 4).
* **Policy Application:** Applied the configured ACL to the appropriate router interface (GigabitEthernet0/0) to enforce the traffic filtering policy. (See Figure 5).
* **Verification:** Performed post-implementation testing to verify that the Guest PC could no longer ping the Admin Server, confirming the ACL was successfully blocking the specified traffic while maintaining other connectivity. (See Figures 6 and 7).

## Observations
* The initial network topology demonstrated successful end-to-end connectivity between all devices before security policies were applied.
* Post-implementation testing confirmed that the Guest network was effectively blocked from accessing the Admin Server host while other network communication remained functional.
* The `show access-lists` command verified the correct application of the ACL rules, showing specific matches for the denied traffic.

## Images

### Figure 1: Network topology diagram created in Cisco Packet Tracer, showing connectivity between Guest PC, Employee PC, Admin Server, and a central router.

<img width="1920" height="1080" alt="Screenshot (91)" src="https://github.com/user-attachments/assets/40da9c0f-5245-4cec-93c9-712e83666430" />

### Figure 2: Router configuration showing interface IP address assignments for the Guest, Employee, and Server networks.

<img width="877" height="486" alt="Screenshot 2026-07-22 224631" src="https://github.com/user-attachments/assets/73ee0d14-5328-43e0-a50d-7474a3f0dc77" />

### Figure 3: Initial connectivity test results showing successful ICMP pings between network devices.

<img width="507" height="120" alt="Screenshot 2026-07-22 224832" src="https://github.com/user-attachments/assets/a902f49c-77e2-4598-9d1a-0eb77b8c5b4f" />

### Figure 4: Router configuration snippet showing the creation of Extended Access Control List (ACL) 100 to deny traffic from the Guest network to the Admin Server.

<img width="646" height="106" alt="Screenshot 2026-07-22 225216" src="https://github.com/user-attachments/assets/b6d24171-e023-4ab6-8c71-d28309226282" />

### Figure 5: Router interface configuration applying Access Control List 100 to the GigabitEthernet0/0 interface.

<img width="343" height="70" alt="Screenshot 2026-07-22 225448" src="https://github.com/user-attachments/assets/c4a88c5f-f1bf-4f87-98c9-0b9e1fd2c323" />

### Figure 6: Post-ACL implementation connectivity test results, confirming that the ping from the Guest PC (PC1) to the Admin Server (Server1) now fails, while other connectivity remains successful.

<img width="511" height="97" alt="Screenshot 2026-07-22 225611" src="https://github.com/user-attachments/assets/19492756-dc5e-43e5-b623-72f69e5e9fc9" />

### Figure 7: Output of the "show access-lists" command, displaying the configured ACL 100 with the specific deny rule and the permit any any rule, showing one match for the blocked traffic.

<img width="560" height="101" alt="Screenshot 2026-07-22 225702" src="https://github.com/user-attachments/assets/cbb89fef-cdab-4115-b777-d4ee8d4fd2d3" />

## Conclusion
The experiment successfully demonstrated the implementation of network security policies using Access Control Lists in Cisco Packet Tracer. By configuring an Extended ACL, I was able to effectively restrict unauthorized access from a specific network (Guest) to a sensitive host (Admin Server) without impacting legitimate traffic between other devices. This reinforces the importance of ACLs as a fundamental tool for traffic filtering and network segmentation in enhancing overall network security.

## Skills Learned
* Designing and configuring multi-network topologies using Cisco Packet Tracer.
* Gained practical experience in creating and applying Extended Access Control Lists (ACLs) to filter network traffic.
* Developed an understanding of network security policy implementation and verification techniques.
