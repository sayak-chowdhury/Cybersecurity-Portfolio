# Executive Summary
This report presents a technical analysis of a complete web browsing session, capturing the full lifecycle from initial DNS resolution to connection teardown. The primary objective is to investigate network behaviors, including TCP handshakes, TLS 1.3 negotiation, packet retransmission handling, and session termination. By analyzing packet-level data, we gain critical visibility into protocol RFC compliance and modern encryption patterns.


## Tool Used
* **Wireshark**


## Methodology
1. **Preparation:** Flushed local DNS cache (`ipconfig /flushdns`) to ensure fresh network requests.
2. **Capture:** Initiated live packet capture on the active network interface.
3. **Execution:** Performed a standard web browsing request to `example.com`.
4. **Analysis:** Applied display filters to isolate the specific session stream, reconstructed TCP segments, and analyzed TLS handshake metadata.


## Observations
* **DNS Resolution (Figures 1, 2):** Observed standard query and response patterns. Note that DNS over TCP utilizes a 2-byte length prefix.
* **Connection Establishment (Figure 3):** The TCP 3-way handshake (SYN, SYN-ACK, ACK) was successfully captured, confirming link initiation.
* **TLS Negotiation (Figures 4, 5, 6):** Analysis confirmed TLS 1.3 protocol usage, with browser-based "Middlebox Compatibility" detected. Fingerprinting via JA3/JA4 identified the client's specific cipher suite configuration.
* **Data Transfer (Figure 7):** Application data transmission commenced immediately following the server's change cipher spec.
* **Teardown (Figure 9):** Session closure was handled via a standard FIN/ACK exchange, confirming graceful termination.
* **Error Handling (Figure 8):** TCP retransmission analysis highlighted the distinction between standard lost packets and spurious retransmissions.


## Deep Packet Inspection & Security Insights
By inspecting the packet headers, we identified significant security and performance markers:
* **Middlebox Compatibility:** The presence of legacy TLS 1.2 headers within a 1.3 session confirms that modern browsers prioritize backward compatibility to bypass strict firewall rules.
* **Traffic Fingerprinting:** The use of JA3/JA4 hashing allows for the baseline identification of client applications. This is a vital technique for detecting unauthorized or malicious tools masquerading as standard web traffic.


## Images
#### Figure 1: DNS Query Traffic Analysis
<img width="1640" height="459" alt="Screenshot 2026-08-03 213330" src="https://github.com/user-attachments/assets/0f7de7c1-50f2-4279-bf33-40f7343ef0f4" />

#### Figure 2: DNS Query Packet Details
<img width="823" height="350" alt="Screenshot 2026-08-03 213452" src="https://github.com/user-attachments/assets/9231eeec-845e-4379-b1a4-7f6f3fe9bee6" />

#### Figure 3: TCP 3-Way Handshake
<img width="1448" height="130" alt="Screenshot 2026-08-03 215341" src="https://github.com/user-attachments/assets/f2c861fe-7c23-46c0-8154-1e0185eb0513" />

#### Figure 4: TLS Client Hello Summary
<img width="987" height="26" alt="Screenshot 2026-08-03 215716" src="https://github.com/user-attachments/assets/29295a09-9bcf-4fc7-931c-aa04b120e671" />

#### Figure 5: TLS Client Hello Protocol Details
<img width="940" height="435" alt="Screenshot 2026-08-03 215752" src="https://github.com/user-attachments/assets/b06d4f76-bd4e-4619-ae2d-b5a30b36743e" />

#### Figure 6: TLS Fingerprinting (JA3/JA4)
<img width="901" height="387" alt="Screenshot 2026-08-03 220531" src="https://github.com/user-attachments/assets/64cc0e50-6c9f-4032-ab7d-b82466fd8653" />

#### Figure 7: TLS Server Hello and Application Data
<img width="1549" height="61" alt="Screenshot 2026-08-03 221056" src="https://github.com/user-attachments/assets/39d56de2-e542-42eb-b5e2-3914620d4221" />

#### Figure 8: TCP Retransmission Analysis
<img width="1740" height="312" alt="Screenshot 2026-08-03 221829" src="https://github.com/user-attachments/assets/88edb0dd-4f1b-4127-b205-dc4fe24324ac" />

#### Figure 9: TCP Session Teardown (FIN/ACK)
<img width="1250" height="110" alt="Screenshot 2026-08-03 230030" src="https://github.com/user-attachments/assets/53cbde2f-87e3-4bb4-84d1-f700dbe302fd" />


## Future Enhancements & Scalability
* **Automation:** Transition from manual capture to automated `tshark` processing for large-scale analysis.
* **Decryption:** Incorporate SSL/TLS key logging to decrypt captured payload data for content-level security analysis.
* **Integration:** Export packet metrics to an IDS/SIEM for real-time threat detection and alerting.


## Cybersecurity Best Practices
* **Monitor Retransmissions:** Spikes in retransmission rates often indicate network congestion or active packet dropping by security appliances.
* **Audit Encryption:** Regularly review TLS configurations using JA3/JA4 signatures to ensure authorized client behavior.
* **Secure DNS:** Implement DNS-over-HTTPS (DoH) where possible to prevent observation of cleartext queries.


## Skills Learned
* **Full Session Lifecycle Capture:** Executed packet captures by flushing DNS caches and isolating end-to-end web browsing flows, from initiation to connection teardown.
* **Deep Packet Inspection (DPI):** Analyzed protocol layers, including DNS (UDP/TCP), TCP 3-Way Handshake, TLS 1.3 encryption handshakes, and session termination (FIN/RST).
* **Advanced Wireshark Filtering:** Developed complex display filters using boolean operators and logical groupings for precise traffic isolation.
* **Network Fingerprinting (JA3 / JA4):** Leveraged Client Hello cipher suite and extension hashing to identify specific client applications and potential malware tools within encrypted streams.
* **TCP Stream Analysis & Diagnostics:** Interpreted TCP segment reassembly, window sizes, relative sequence numbers, and protocol RFC behaviors, such as DNS-over-TCP length prefixes.


## Problems Faced and Solutions
* **TCP Segment Reassembly:**
  * *Challenge:* Observed multi-frame data splits in Wireshark (e.g., a 31-byte DNS query spanning Frames #35 and #36).
  * *Solution:* Confirmed that Wireshark effectively recombines Layer 4 fragments into an application-level view, while noting the mandatory 2-byte length prefix required for DNS over TCP.
* **Multiple ACKs for a Single Message:**
  * *Challenge:* Encountered sequential ACK packets (e.g., #98 and #99) immediately following a single Client Hello.
  * *Solution:* Identified that payloads exceeding the Maximum Segment Size (MSS) are fragmented into multiple TCP chunks, necessitating independent TCP-level acknowledgments from the server.
* **Legacy TLS Compatibility:**
  * *Challenge:* Discrepancy between Wireshark’s TLSv1.3 session flag and the TLS 1.0/1.2 record headers.
  * *Solution:* Identified the use of TLS Middlebox Compatibility Mode, where browsers include legacy header values to maintain compatibility with older firewalls.
* **Retransmission Analysis:**
  * *Challenge:* Distinguishing between `tcp.analysis.retransmission` and `tcp.analysis.spurious_retransmission`.
  * *Solution:* Clarified that standard retransmissions indicate actual packet loss, whereas spurious retransmissions are unnecessary duplicates resulting from delayed ACK responses.


## Conclusion
This analysis successfully mapped the end-to-end lifecycle of a secure web request. By combining deep packet inspection with protocol-level diagnostics, we validated the integrity of the connection and established a framework for identifying normal versus anomalous traffic patterns. The methodologies explored here are essential for robust network troubleshooting and security auditing.
