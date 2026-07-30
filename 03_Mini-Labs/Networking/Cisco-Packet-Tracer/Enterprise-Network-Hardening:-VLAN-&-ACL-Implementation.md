# Executive Summary
This project demonstrates the design and deployment of a secure, segmented enterprise network architecture to prevent unauthorized lateral movement between departments. By leveraging VLAN-based logical isolation and Extended Access Control Lists (ACLs), the implementation enforces a "Least Privilege" security model. The architecture successfully restricts inter-departmental data exposure while maintaining operational availability for critical services, providing a robust, scalable blueprint for secure multi-departmental infrastructure.

## Tool Used
* **Cisco Packet Tracer**


## Methodology
1. **Network Architecture:** Designed a topology centered around a Cisco 2901 router and 2960 switch, creating distinct segments for:
   * HR (`VLAN 10`)
   * IT (`VLAN 20`)
   * Finance (`VLAN 30`)
   * Server Farm (`VLAN 100`)
2. **VLAN & Trunking:** Configured VLANs and switch ports; implemented trunking on the router-switch link to carry inter-VLAN traffic.
3. **Routing:** Enabled Router-on-a-Stick by defining 802.1Q subinterfaces on the router (`Gig0/1.10`, `Gig0/1.20`, `Gig0/1.30`, `Gig0/1.100`) and assigning appropriate gateway IP addresses.
4. **Security Policy:** Deployed an `Enterprise_Security_Policy` Extended ACL on the router subinterfaces to permit IT full access, grant HR web server access, and restrict HR-to-Finance database communication.


## Observations
* **Initial Testing:** Connectivity was established across segments; however, there was no granular access control between departments, as shown by PDU ping tests.
* **Security Validation:** After applying the Extended ACL, HR devices were successfully restricted from accessing the Finance database server while maintaining access to web services.
* **Final Connectivity:** Post-implementation testing confirmed that security policies functioned as expected, allowing only authorized traffic flows while blocking restricted departmental access.


## Images
#### Figure 1: Cisco Packet Tracer network topology setup with multiple departments, servers, and routers.
<img width="1920" height="1080" alt="Screenshot (108)" src="https://github.com/user-attachments/assets/c91635bb-2c77-488a-9123-643e9251e18e" />

#### Figure 2: Switch CLI configuration commands for VLAN creation and port assignment.
<img width="567" height="620" alt="Screenshot 2026-07-30 134449" src="https://github.com/user-attachments/assets/ccca3645-29b4-458f-97dc-c8d763f62407" />

#### Figure 3: Router CLI configuration commands for subinterfaces and IP addressing.
<img width="763" height="840" alt="Screenshot 2026-07-30 135443" src="https://github.com/user-attachments/assets/752ac9af-df30-468d-a11f-c990dbfb9f11" />

#### Figure 4: PDU list window showing initial ping connectivity status between various devices.
<img width="640" height="155" alt="Screenshot 2026-07-30 135641" src="https://github.com/user-attachments/assets/dd9efb02-2f74-4cb1-8094-5995ee9d9ad2" />

#### Figure 5: Router CLI configuration commands for setting up extended Access Control Lists (ACLs).
<img width="925" height="467" alt="Screenshot 2026-07-30 155214" src="https://github.com/user-attachments/assets/a244002a-c83b-4119-a38b-10e2ca4b0a18" />

#### Figure 6: HR PC1 web browser accessing the web server at `10.10.100.10` (Web/App Server1).
<img width="1152" height="321" alt="Screenshot 2026-07-30 155331" src="https://github.com/user-attachments/assets/c92deea1-f4e0-4dfc-8123-207e60be9def" />

#### Figure 7: Command prompt on HR PC1 showing a failed ping attempt to `10.10.30.10` (Finance PC1).
<img width="510" height="347" alt="Screenshot 2026-07-30 155545" src="https://github.com/user-attachments/assets/fdf8da5d-4265-46e4-a822-17767643294e" />

#### Figure 8: Display of the extended access list `Enterprise_Security_Policy` rules.
<img width="632" height="126" alt="Screenshot 2026-07-30 155717" src="https://github.com/user-attachments/assets/c689e9ac-e462-4eb5-b0b6-44d4a08c3191" />

#### Figure 9: PDU list window showing post-configuration connectivity tests.
<img width="645" height="233" alt="Screenshot 2026-07-30 160013" src="https://github.com/user-attachments/assets/96d15353-e814-4c4e-a7dc-1fadc6bab645" />

#### Figure 10: Router CLI commands demonstrating an attempt to block HR access to the Finance DB Server.
<img width="620" height="180" alt="Screenshot 2026-07-30 161326" src="https://github.com/user-attachments/assets/362367ab-7e30-4ca8-a3d5-bfe790bda297" />

#### Figure 11: Final PDU list window showing successful and failed ping attempts after applying security policies.
<img width="608" height="97" alt="Screenshot 2026-07-30 161148" src="https://github.com/user-attachments/assets/f4a2c6d1-aa1d-4ddb-8aed-01b496526388" />


## Future Enhancements & Scalability
* **Transition to Dedicated Security Appliances:** Integrate a dedicated hardware firewall (e.g., Cisco ASA or Firepower) for deep packet inspection (DPI) and advanced threat protection beyond standard L3/L4 ACLs.
* **Centralized Security Monitoring:** Implement a Syslog server and SIEM integration to capture, correlate, and analyze network logs for real-time anomaly detection.


## Cybersecurity Best Practices
* **Principle of Least Privilege:** Restrict access rights for users and devices to the absolute minimum permissions required for their specific job functions.
* **Regular Policy Audits:** Periodically review and update Access Control Lists (ACLs) to ensure they remain aligned with evolving business needs and security threats.
* **Continuous Traffic Monitoring:** Implement network log analysis to proactively identify and investigate anomalous traffic patterns or unauthorized access attempts.
* **Infrastructure Hardening:** Regularly update firmware on networking hardware to mitigate risks associated with known vulnerabilities and potential security exploits.


## Skills Learned
* **Enterprise Network Design:** Experience in building and managing multi-department segmented network topologies using subnets and VLANs.
* **Layer 2 Segmentation:** Practical application of 802.1Q VLAN configuration and trunk port management to isolate broadcast domains.
* **Layer 3 & 4 Security:** Technical proficiency in writing Extended ACLs, utilizing wildcard masks, and filtering traffic based on specific port protocols like HTTP (80) and HTTPS (443).
* **Defense-in-Depth:** Understanding the integration of Layer 2 isolation and Layer 3 traffic filtering to secure network assets.


## Problems Faced and Solutions
* **ACL Syntax Configuration:**
  * *Problem:* Initially encountered errors with IP matching.
  * *Solution:* Resolved this by learning that single-host entries require the `host` keyword, whereas subnet blocks use the network address with a wildcard mask.
* **ACL Evaluation Order:**
  * *Problem:* Found that HR retained unauthorized access to the Finance database.
  * *Solution:* Corrected this by realizing ACL rules are processed sequentially; deleted the incorrectly placed rule and used sequence numbers to prioritize `deny` statements over `permit` statements.


## Conclusion
* Successfully demonstrated the ability to design and secure a complex network environment.
* Validated that combining VLAN segmentation with precise ACL enforcement provides an effective defense mechanism for enterprise networks.
* Confirmed the importance of syntax accuracy and rule ordering in professional network administration.
