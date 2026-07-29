# Objective
The objective of this project is to configure Virtual Local Area Networks (VLANs) on a Cisco switch to segment network traffic for HR, IT, and Guest PCs. The primary goal is to organize network devices into logical groups and implement security by preventing unauthorized communication between these distinct groups.


## Tool Used
* **Cisco Packet Tracer**


## Methodology
1. **Topology Design:** Create a network topology in Cisco Packet Tracer with a central switch connected to various end devices (HR, IT, and Guest PCs).
2. **VLAN Creation:** Configure the switch to define three separate VLANs:
   * **VLAN 10:** HR
   * **VLAN 20:** IT
   * **VLAN 30:** Guest
3. **Port Assignment:** Assign specific switch interface ranges to each VLAN to ensure that devices are logically separated into their respective network segments.
4. **IP Configuration:** Assign static IP addresses to each PC within their respective VLAN subnets:
   * `192.168.10.x` for HR
   * `192.168.20.x` for IT
   * `192.168.30.x` for Guest
5. **Testing and Verification:** Perform connectivity tests (ICMP/Ping) to verify that communication is successful within the same VLAN and restricted between different VLANs.


## Observations
The connectivity tests, as displayed in the PDU List Window (**Figure 5**), confirmed that communication was successful between devices within the same VLAN (e.g., HR PC to HR PC). Conversely, ping requests between devices in different VLANs (e.g., HR to IT, Guest to HR) failed, demonstrating that the VLAN configuration successfully segmented the network and prevented unauthorized cross-departmental communication.


## Images
#### Figure 1: Network topology diagram in Cisco Packet Tracer showing connections between HR, IT, and Guest PCs and a central switch.
<img width="1920" height="1080" alt="Screenshot (101)" src="https://github.com/user-attachments/assets/84aaac6d-54b1-4b13-87e9-a2cec4c3775d" />

#### Figure 2: Cisco IOS commands for creating HR (VLAN 10), IT (VLAN 20), and Guest (VLAN 30) VLANs on the switch.
<img width="502" height="211" alt="Screenshot 2026-07-29 132801" src="https://github.com/user-attachments/assets/b589bd5e-e2b8-438d-941c-a122b1b4890b" />

#### Figure 3: Cisco IOS commands for assigning specific switch ports to the HR, IT, and Guest VLANs.
<img width="422" height="240" alt="Screenshot 2026-07-29 133335" src="https://github.com/user-attachments/assets/9942444e-8cf4-4d7d-b9ff-ed2c17486db9" />

#### Figure 4: Static IP address configuration for HR PC1, IT PC2, and Guest PC1.
<img width="1920" height="1080" alt="Screenshot (102)" src="https://github.com/user-attachments/assets/31e7028f-d9eb-48f0-ab14-e58820327195" />

#### Figure 5: PDU List Window in Cisco Packet Tracer showing the status (successful or failed) of ICMP packet transmissions between different network devices.
<img width="642" height="207" alt="Screenshot 2026-07-29 151219" src="https://github.com/user-attachments/assets/13a0fe1d-8871-4dd2-8dd1-9b70667a28ea" />


## Conclusion
The VLAN configuration successfully isolated network traffic into functional groups (HR, IT, and Guest). By assigning specific switch ports to designated VLANs and establishing distinct IP subnets, I effectively prevented unauthorized cross-communication between the different departments while maintaining internal connectivity within each group.


## Skills Learned
* Proficiency in using Cisco Packet Tracer for network simulation.
* Understanding of VLAN creation and switch management.
* Experience in assigning switch ports to VLANs using CLI commands.
* Ability to configure static IP addressing and perform connectivity testing to troubleshoot network segmentation.
