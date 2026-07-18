# Objective

Set up a network with multiple routers (Router A, Router B, Router C) using Cisco Packet Tracer to explore and compare routing behaviors, specifically focusing on Static Routing, RIPv2 (Distance Vector), and OSPF (Link-State).

## Tools Used
* Cisco Packet Tracer

## Methodology
* Construct a network topology with three routers (A, B, C) and two endpoints (PC1, PC2).
* Configure interface IP addresses on all routers.
* Test connectivity using three different methods:
  * **Method A:** Static Routing (Manual path definition).
  * **Method B:** RIPv2 (Dynamic distance vector routing).
  * **Method C:** OSPF (Dynamic link-state routing). 

## Observation
* Initially, connectivity fails (Figure 1).
* Manual interface configuration (Figure 2) and routing table entries (Figure 3) enable Static Routing (Figure 4).
* Transitioning to Dynamic Routing (RIPv2) allows the routers to automatically learn routes (Figures 5, 6, 7).
* Implementing OSPF further optimizes routing path determination (Figures 8, 9, 10).

## Images

### Method A: Static Routing (The Manual Approach)

#### Figure 1: Initial network topology in Cisco Packet Tracer showing a failed connection status.

<img width="512" height="288" alt="ss 1" src="https://github.com/user-attachments/assets/584c644e-e64d-4d68-a6b4-50b76819a4b6" />

#### Figure 2: CLI configuration commands for interface setup on the router.

<img width="717" height="497" alt="Screenshot 2026-07-18 232027" src="https://github.com/user-attachments/assets/676ea215-8624-4d8a-9770-c0525eddcb73" />

#### Figure 3: IP route configuration in the IOS Command Line Interface for Router A and Router C.

<img width="1920" height="1080" alt="Screenshot (85)" src="https://github.com/user-attachments/assets/e0e9147e-20be-4be8-b525-2a730a16fc76" />

#### Figure 4: Updated network topology in Cisco Packet Tracer indicating a successful connection status.

<img width="1920" height="1080" alt="Screenshot (84)" src="https://github.com/user-attachments/assets/23fffe55-3086-4c2d-b9fd-c435b64ab60e" />

### Method B: RIPv2 (Dynamic-Distance Vector)

#### Figure 5: Configuration commands for RIPv2 on Routers A, B, and C.

<img width="1920" height="1080" alt="Screenshot (86)" src="https://github.com/user-attachments/assets/22dffdac-6b0d-422b-a142-e9245c846874" />

#### Figure 6: Routing table output displaying RIP-learned routes on the router.

<img width="743" height="370" alt="Screenshot 2026-07-19 002050" src="https://github.com/user-attachments/assets/5aba687d-a64d-426c-ba77-8a7a5ef42d3a" />

#### Figure 7: Final network topology in Cisco Packet Tracer confirming successful connectivity with dynamic routing.

<img width="1920" height="1080" alt="Screenshot (87)" src="https://github.com/user-attachments/assets/26f122a2-c3ab-46ae-a9ac-e7988fa9c374" />

### Method C: OSPF (Dynamic-Link State)

#### Figure 8: Configuration commands for OSPF on Routers A, B, and C.

<img width="1920" height="1080" alt="Screenshot (88)" src="https://github.com/user-attachments/assets/0d06ed93-b52e-47e0-b7b0-0626b0fa311f" />

#### Figure 9: Routing table output displaying OSPF-learned routes on the router.

<img width="587" height="190" alt="Screenshot 2026-07-19 010051" src="https://github.com/user-attachments/assets/9bb2c2a8-66f1-4d3f-996b-7ec84bc59585" />

#### Figure 10: Final network topology in Cisco Packet Tracer confirming successful connectivity with OSPF routing.

<img width="1920" height="1080" alt="Screenshot (89)" src="https://github.com/user-attachments/assets/ae00bce3-e164-4701-a431-70b9bce81848" />

## Conclusion
The lab successfully demonstrates the differences between static and dynamic routing. Static routing provides manual control but lacks scalability. RIPv2 automates routing but is limited by hop count metrics. OSPF provides a more robust, scalable, and faster-converging solution for dynamic link-state routing.

## Skills Learned
* Network topology design in Cisco Packet Tracer.
* Interface IP configuration and management.
* Understanding and implementing Static routes.
* Configuring Dynamic Routing Protocols (RIPv2 and OSPF).
* Analyzing routing tables to verify connectivity and protocol performance.
* Calculate network entries by mapping local versus remote subnets.
* OSPF wildcard masks as interface filters.
* The structural importance of OSPF Area 0 for scalability.
* Identify how OSPF load-balances traffic using multiple paths "Equal-Cost Multi-Path (ECMP)".
