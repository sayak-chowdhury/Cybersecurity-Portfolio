# Objective

Analyze DNS protocol behavior and packet structure using Wireshark to gain insights into network resolution processes.

## Tool Used
* Wireshark

## Methodology
* Initiated live packet capture on the active network interface.
* Filtered traffic to isolate DNS protocol packets.
* Systematically resolved various domains to generate distinct query and response logs.
* Analyzed extracted packets, specifically examining domain name resolution, record types (A, AAAA, CNAME), and server-side responses.

## Observations
* Identified load balancing techniques where major providers like Google utilize multiple IP addresses to distribute network traffic efficiently.
* Observed domain redirection patterns, notably Wikipedia's use of non-canonical redirects to consolidate secondary or typo-prone requests onto the official domain.
* Validated alias (CNAME) record functionality, specifically documenting how GitHub.com resolves through alias records to Microsoft Azure hosted infrastructure.

| DOMAIN | Query Type | Response IP |
| :--- | :---: | :--- |
| google.com | A | 142.251.156.119 |
| github.com | A | 20.207.73.82 |
| wikipedia.com | A | 103.102.166.226 |
| ubuntu.com | A | 185.125.190.122 |

## Security Implications of DNS Traffic
* **Lack of Encryption (Cleartext):** Standard DNS queries (UDP Port 53) are sent in cleartext. I observed that anyone sniffing network traffic can see exactly which domains a user is visiting, which in a real-world scenario allows for user profiling or eavesdropping.
* **Mitigation:** Organizations should implement DNS over HTTPS (DoH) or DNS over TLS (DoT) to encrypt queries.
* **Potential Attacks:** DNS traffic is vulnerable to DNS Spoofing/Cache Poisoning (where an attacker injects a malicious IP for a legitimate domain) and DNS Tunneling (where attackers sneak malicious data out of a network inside DNS queries).

When looking at the answers section for github.com, I observed a CNAME record pointing to github.map.fastly.net before it resolved to the final A record IP address. This demonstrates how Content Delivery Networks (CDNs) manage traffic redirection.

## Images

### Github Query
<img width="353" height="147" alt="unnamed" src="https://github.com/user-attachments/assets/a6ae5bff-60d5-41f9-9870-2cb7b59c8c80" />

*Figure 1: Wireshark packet detail showing a DNS Query for github.com.*

### Github Answers
<img width="646" height="306" alt="Screenshot 2026-06-18 195122" src="https://github.com/user-attachments/assets/08a2fec1-3f35-44bb-9a54-5ae10fa57f4e" />

*Figure 2: Wireshark packet detail displaying the CNAME record for github.com.*

### Wikipedia Query
<img width="407" height="150" alt="Screenshot 2026-06-18 192244" src="https://github.com/user-attachments/assets/e01cd06f-2c04-45b0-ae2f-58b0bb6aea19" />

*Figure 3: Wireshark packet detail showing a DNS Query for www.wikipedia.com.*

### Wikipedia Answers
<img width="771" height="312" alt="Screenshot 2026-06-18 194109" src="https://github.com/user-attachments/assets/56521d4b-368f-4618-9026-85673a2389be" />

*Figure 4: Wireshark packet detail displaying the CNAME record for www.wikipedia.com pointing to ncredir-lb.wikimedia.org.*

### Ubuntu Query
<img width="418" height="147" alt="Screenshot 2026-06-18 192139" src="https://github.com/user-attachments/assets/ff1dc38a-1bf8-431b-bd46-21561a76d9b0" />

*Figure 5: Wireshark packet detail showing an AAAA (IPv6) DNS Query for 1.ntp.ubuntu.com.*

### Ubuntu Answers
<img width="593" height="172" alt="Screenshot 2026-06-18 203110" src="https://github.com/user-attachments/assets/2316d6df-1bcf-4fc3-af95-46d4c00d5026" />

*Figure 6: Wireshark packet detail showing the resolved IP address for 1.ntp.ubuntu.com.*

### Google Query
<img width="377" height="150" alt="Screenshot 2026-06-18 192209" src="https://github.com/user-attachments/assets/4fb89cfd-5fd6-4e3f-85fd-b399b77b7b26" />

*Figure 7: Wireshark packet detail showing a DNS Query for www.google.com.*

### Google Answers
<img width="596" height="407" alt="Screenshot 2026-06-18 200843" src="https://github.com/user-attachments/assets/045dc9ef-781e-435d-ae01-b50fd4cb1e4c" />

*Figure 8: Wireshark packet detail showing multiple A record responses for www.google.com, indicating load balancing.*

## Conclusion
Successfully performed a comprehensive analysis of DNS traffic, distinguishing between standard query packets and authoritative responses, and correlating domain names with their resolved IP addresses.

## Skills Learned
* Proficiency in using Wireshark for capturing and filtering network traffic.
* Enhanced understanding of DNS query and response mechanisms, including A and CNAME record types.
* Ability to interpret packet details, such as domain names, IP addresses, and time-to-live values.
* Practical experience in identifying load balancing techniques and domain redirection patterns through network analysis.
* Learnt the use of specific DNS filters: 
```bash
  dns.flags.response==0 # for queries
  dns.flags.response==1 # for responses
  dns.qry.name contains "..." # to search for specific domain names
```
* Observed that DNS primarily utilizes UDP for speed, but can fall back to TCP for zone transfers.
