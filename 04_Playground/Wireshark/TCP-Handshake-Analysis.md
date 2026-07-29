# Objective
The objective of this analysis is to capture and examine network traffic when accessing a website to understand the underlying TCP 3-way handshake mechanism, which establishes a reliable connection between a client and a server.


## Tool Used
* **Wireshark**


## Methodology
1. **Launch Wireshark** and select the appropriate network interface for traffic capture.
2. **Filter the traffic** using the IP address of the target web server (e.g., `ip.addr == 172.66.147.243`) to isolate relevant communications.
3. **Initiate a connection** to the website (e.g., `www.example.com`) via a browser.
4. **Stop the capture** once the initial handshake and data exchange are observed.
5. **Analyze individual packets** to observe the flag settings (`SYN`, `SYN-ACK`, `ACK`) that constitute the TCP 3-way handshake.


## Observations
The captured traffic demonstrates the classic TCP 3-way handshake process:

* **Packet 1723:** The client sends a `SYN` packet to the server to initiate the connection. The `SYN` flag is set.
* **Packet 1732:** The server responds with a `SYN-ACK` packet, acknowledging the client's request and sending its own sequence number. Both `SYN` and `ACK` flags are set.
* **Packet 1733:** The client sends an `ACK` packet to the server, confirming the connection is established. The `ACK` flag is set.

Following this handshake, the subsequent packets show the TLS handshake and data transfer, indicating a secure connection initiation.


## Images
#### Figure 1: Packet capture summary showing the start of a TCP 3-way handshake.

<img width="1651" height="567" alt="Screenshot 2026-07-30 013443" src="https://github.com/user-attachments/assets/6a7b5176-2756-4a31-a51b-2c0d771b9c8c" />

#### Figure 2: Detailed view of the `SYN` packet (Packet 1723) with the `SYN` flag set.

<img width="1920" height="1080" alt="Screenshot (104)" src="https://github.com/user-attachments/assets/0e82bf36-1ae9-46bd-a119-ec9b4738d13c" />

#### Figure 3: Detailed view of the `SYN, ACK` packet (Packet 1732) with both `SYN` and `ACK` flags set.

<img width="1920" height="1080" alt="Screenshot (105)" src="https://github.com/user-attachments/assets/c4fb7ef5-a8e4-435a-834c-1db61ceff246" />

#### Figure 4: Detailed view of the `ACK` packet (Packet 1733) with the `ACK` flag set, completing the 3-way handshake.

<img width="1920" height="1080" alt="Screenshot (106)" src="https://github.com/user-attachments/assets/ef0b33bc-02cd-4cb4-bc5a-f96c031e9892" />


## Conclusion
The analysis successfully confirmed the TCP 3-way handshake process. By observing the `SYN`, `SYN-ACK`, and `ACK` flags in Wireshark, the mechanics of how TCP establishes reliable, connection-oriented communication were verified. This practical exercise highlights the importance of sequence numbers and flags in maintaining network session integrity.


## Skills Learned
* Using Wireshark for network traffic analysis.
* Ability to filter specific network traffic using IP addresses.
* Practical understanding of the TCP 3-way handshake and packet flag manipulation.
