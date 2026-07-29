# Objective
To configure and analyze DHCP services in Cisco Packet Tracer, specifically focusing on the DORA process (**D**iscover, **O**ffer, **R**equest, **A**cknowledge) and validating IP address assignment in both GUI and CLI environments.

## Tool Used
* **Cisco Packet Tracer**

## Methodology
The lab is conducted in two main phases:

1. **GUI-based Configuration:** A topology was created with a Server and two PCs connected to a switch. The DHCP service was enabled on the server to dynamically assign IP addresses to the PCs. Packet simulation was used to capture and analyze the DHCP handshake process.
2. **CLI-based Configuration:** A router-based topology was implemented. The router interface (`GigabitEthernet0/0`) was configured with a static IP address, and a DHCP pool was created via CLI, including address exclusion and necessary network parameters (default router, DNS).

## Observations

### Analysis of the DHCP Process (DORA)
* **Discover:** The DHCP client broadcasts a Discover packet on the network to locate available DHCP servers.
* **Offer:** Upon receiving the Discover, the server responds with a DHCP Offer packet, proposing an IP configuration (IP address, subnet mask).
* **Request:** The client accepts the offer by sending a DHCP Request packet, formally asking to lease the offered IP address.
* **Acknowledge:** Finally, the DHCP server sends a DHCP Acknowledge (ACK) packet, confirming the lease and finalizing the configuration.

Captured data in **Figure 5** (PDU details) and **Figure 6** (Simulation Panel) confirm this DORA sequence. **Figure 6** also shows background Spanning Tree Protocol (STP) traffic, which is typical for network switches, but confirms the DHCP handshake is captured successfully.

## Images

### Using GUI
#### Figure 1: Network topology featuring a switch, server, and two PCs in Cisco Packet Tracer.

<img width="1920" height="1080" alt="Screenshot (98)" src="https://github.com/user-attachments/assets/8b5eef04-d735-4c43-b8ac-54752f5029e3" />

#### Figure 2: DHCP service configuration settings on Server1.

<img width="1887" height="517" alt="Screenshot 2026-07-28 124839" src="https://github.com/user-attachments/assets/c956eac2-5691-48d3-888b-49a14a2b7d42" />

#### Figure 3: Successful DHCP IP configuration on PC1.

<img width="1896" height="335" alt="Screenshot 2026-07-28 125306" src="https://github.com/user-attachments/assets/e809a52c-2a75-4ba4-b6ed-e317ae4474cb" />

#### Figure 4: Successful DHCP IP configuration on PC2.

<img width="1117" height="307" alt="Screenshot 2026-07-28 125410" src="https://github.com/user-attachments/assets/111abadd-f07d-44a2-9246-25cf0463a2c5" />

#### Figure 5: PDU information window showing the DHCP release packet details.

<img width="590" height="636" alt="Screenshot 2026-07-28 125837" src="https://github.com/user-attachments/assets/1d68aa76-7c1c-49f1-8b04-38dbffef046e" />

#### Figure 6: Simulation panel displaying the captured DHCP and STP events.

<img width="1920" height="1080" alt="Screenshot (99)" src="https://github.com/user-attachments/assets/f69f9c4d-2f9a-493d-8b7f-f62095257992" />


### Using Router's CLI
#### Figure 7: Updated network topology including a router connected to the switch and PCs.

<img width="1920" height="1080" alt="Screenshot (100)" src="https://github.com/user-attachments/assets/7cb7e5a4-9226-4f37-a492-758b9d9c093c" />

#### Figure 8: CLI commands for configuring the router's `GigabitEthernet0/0` interface.

<img width="890" height="220" alt="Screenshot 2026-07-28 131839" src="https://github.com/user-attachments/assets/6942441a-89b8-41ee-99be-f52711c7ae0b" />

#### Figure 9: CLI commands for setting up the DHCP pool named `LAN_POOL`.

<img width="525" height="128" alt="Screenshot 2026-07-28 133543" src="https://github.com/user-attachments/assets/924f07ed-15a7-42c7-8898-2932d579cf4a" />

#### Figure 10: Output showing the active DHCP bindings and pool status on the router.

<img width="712" height="273" alt="Screenshot 2026-07-28 133851" src="https://github.com/user-attachments/assets/80355613-44e8-4731-8c8d-bdbdf770ce4b" />


## Conclusion
DHCP services were successfully implemented using both GUI-based server settings and CLI-based router configuration. The simulation successfully captured the DORA process, verifying that IP addresses were assigned correctly to clients in both test scenarios.

## Skills Learned
* Configuring DHCP server pools and address exclusions.
* Router CLI commands for network interface and DHCP setup.
* Practical network simulation using Cisco Packet Tracer.
* Packet analysis, including inspecting PDU layers and interpreting DHCP handshake sequences.
