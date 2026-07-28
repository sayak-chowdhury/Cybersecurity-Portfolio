## Objective
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
* **Figure 1:** Network topology featuring a switch, server, and two PCs in Cisco Packet Tracer.
* **Figure 2:** DHCP service configuration settings on Server1.
* **Figure 3:** Successful DHCP IP configuration on PC1.
* **Figure 4:** Successful DHCP IP configuration on PC2.
* **Figure 5:** PDU information window showing the DHCP release packet details.
* **Figure 6:** Simulation panel displaying the captured DHCP and STP events.

### Using Router's CLI
* **Figure 7:** Updated network topology including a router connected to the switch and PCs.
* **Figure 8:** CLI commands for configuring the router's `GigabitEthernet0/0` interface.
* **Figure 9:** CLI commands for setting up the DHCP pool named `LAN_POOL`.
* **Figure 10:** Output showing the active DHCP bindings and pool status on the router.

## Conclusion
DHCP services were successfully implemented using both GUI-based server settings and CLI-based router configuration. The simulation successfully captured the DORA process, verifying that IP addresses were assigned correctly to clients in both test scenarios.

## Skills Learned
* Configuring DHCP server pools and address exclusions.
* Router CLI commands for network interface and DHCP setup.
* Practical network simulation using Cisco Packet Tracer.
* Packet analysis, including inspecting PDU layers and interpreting DHCP handshake sequences.
