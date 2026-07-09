# Objective

This project focuses on applying fundamental Linux commands for efficient file manipulation, directory management, and system administration. It involves practicing essential utilities like grep, tar, and permissions management to build a functional mini-project for automated log analysis and backup procedures.

## Tools Used
* WSL2 Ubuntu OS

## Methodology
1. **Environment Setup:** Configured a Linux-based workspace using WSL2 Ubuntu OS to provide a native command-line interface.
2. **Directory & File Management:** Established a structured file system hierarchy using `mkdir` and `touch` to organize log files and reports, simulating real-world system logs.
3. **Log Analysis:** Employed text processing utilities, primarily `grep`, to filter and extract specific patterns (e.g., 'Failed' vs. 'Accepted' login attempts) from log files. Used pipes (`|`) and word count (`wc -l`) to quantify log events.
4. **Backup & Archive Management:** Implemented archiving procedures using `tar` to compress log files, followed by verifying file integrity with SHA256 checksums (`sha256sum`).
5. **Permission Control:** Applied system administration practices by managing file and directory access rights using `chmod` to ensure secure log storage.

## Observations

### 1. Path Syntax and Archive Metadata
The analysis demonstrates that path selection is critical when archiving files. Using relative paths (e.g., 'LinuxPractice') vs. absolute path shortcuts (e.g., '~/LinuxPractice') changes the metadata stored within the archive. When absolute paths are used, the archive preserves the full path structure, which alters the byte stream of the archive file itself. Consequently, this change in the byte stream results in a completely different SHA-256 checksum, highlighting that even minor variations in path specification affect data integrity verification.

### 2. The Cryptographic Null Hash Phenomenon
During experimentation, empty data streams or failed pipeline outputs consistently generated the universal null hash constant (`e3b0c442...`). This is critical for security analysts, as it serves as a distinct indicator of a null payload. If a monitoring tool reports this specific hash, it confirms that the process executed but failed to ingest or process any data, allowing analysts to quickly distinguish between successful empty operations and actual system errors or missing logs.

### 3. Storage Footprint Assessment
System free space calculations and directory sizing tools like 'du' reveal how the block architecture manages file storage. Analysis of the './logs' directory versus the resulting 'logs.tar.gz' archive shows the impact of compression on storage efficiency. Furthermore, observing the file system structure within the WSL2 environment highlights how user-space directories ('/home/sayak/') map to the underlying storage, contrasting with how potential Windows-mounted partitions might behave in terms of permission handling and block allocation.

## Images

### Image 1: Searching for failed login attempts in auth.log

<img width="816" height="108" alt="Screenshot 2026-06-19 200606" src="https://github.com/user-attachments/assets/8592e9d3-459c-43e4-ba86-ee55b8097e29" />

### Image 2: Displaying failed login attempts with line numbers

<img width="815" height="93" alt="Screenshot 2026-06-19 200936" src="https://github.com/user-attachments/assets/97e415f3-6c5a-4fa6-b378-ad6519fff5e8" />

### Image 3: Counting total failed login attempts using pipes and wc

<img width="870" height="62" alt="Screenshot 2026-06-19 200952" src="https://github.com/user-attachments/assets/9ebd0529-d571-4c9c-ae9e-0b24a4c3207b" />

### Image 4: Searching for accepted login attempts in auth.log

<img width="832" height="83" alt="Screenshot 2026-06-19 201224" src="https://github.com/user-attachments/assets/93d8ddfb-a453-4a95-83c5-d76f6aad27ce" />

### Image 5: Generating a SHA-256 checksum for authentication logs

<img width="1380" height="52" alt="Screenshot 2026-06-19 204145" src="https://github.com/user-attachments/assets/5f083490-7525-40c0-ab5d-067af219c924" />

### Image 6: Comparing SHA-256 hashes of archives created with absolute versus relative paths

<img width="943" height="127" alt="Screenshot 2026-06-19 205218" src="https://github.com/user-attachments/assets/2bee377d-6b49-4333-9ca4-6f2250e28ec1" />

### Image 7: Setting up the project environment by creating log and report directories

<img width="922" height="150" alt="Screenshot 2026-06-19 222616" src="https://github.com/user-attachments/assets/41c521c1-8043-4fcf-aa4c-2d0f826194eb" />

### Image 8: Displaying the contents of the web.log file

<img width="597" height="297" alt="Screenshot 2026-06-19 222727" src="https://github.com/user-attachments/assets/55bd2144-edaf-404f-912a-6343429da3fa" />

### Image 9: Case-insensitive search for failed web logs and counting occurrences

<img width="952" height="187" alt="Screenshot 2026-06-19 223448" src="https://github.com/user-attachments/assets/c9a62709-55c5-4d16-84ce-4d70d553097e" />

### Image 10: Creating a compressed tar archive of the log directory

<img width="742" height="161" alt="Screenshot 2026-06-19 224526" src="https://github.com/user-attachments/assets/416d20db-a7ef-4fc6-ba69-00f3f6aaaf04" />

### Image 11: Comparing the storage footprint of the archive versus the uncompressed directory

<img width="605" height="112" alt="Screenshot 2026-06-19 224611" src="https://github.com/user-attachments/assets/fcafe80b-2916-4cc7-9a4c-44e20ec68d8f" />

### Image 12: Verifying the integrity of the tar archive using SHA-256

<img width="1131" height="106" alt="Screenshot 2026-06-19 224826" src="https://github.com/user-attachments/assets/2aae5a8a-7639-426e-8f5c-0c48eecca4d0" />

### Image 13: Moving the archive to the backup directory

<img width="772" height="195" alt="Screenshot 2026-06-19 224957" src="https://github.com/user-attachments/assets/8b1c2965-370f-4d1e-9af0-fa7c48db5933" />

### Image 14: Listing the backup directory contents to confirm the move

<img width="782" height="227" alt="Screenshot 2026-06-19 225109" src="https://github.com/user-attachments/assets/d43df8df-889a-404f-8e62-0941849aa872" />

### Image 15: Modifying directory permissions using chmod to ensure secure access

<img width="756" height="327" alt="Screenshot 2026-06-19 225306" src="https://github.com/user-attachments/assets/d31ee0fe-75a0-4462-970f-c6f4962e36d1" />


## Conclusion
This project successfully demonstrated the practical application of essential Linux commands, ranging from file system navigation and management to advanced text processing and security auditing. By leveraging WSL2, the workflow highlighted critical nuances in path syntax, archive integrity, and permission control, reinforcing the importance of precise command execution in system administration and log analysis.

## Skills Learned
* **Environment Configuration:** Set up and utilized a Linux-based workspace using WSL2 Ubuntu OS.
* **File System Management:** Created and structured directories and files using basic commands like `mkdir`, `touch`, `cd`, `ls`, and `mv`.
* **Text Processing & Log Analysis:** Applied text processing utilities such as `grep` for pattern filtering (including case-insensitive searches) and used pipes (`|`) with `wc` for counting log events.
* **Archiving & Compression:** Executed `tar` commands to archive and compress directories, demonstrating an understanding of how to manage log files.
* **Data Integrity Verification:** Generated and compared SHA-256 checksums (`sha256sum`) to verify file integrity and observed how variations in path syntax (absolute vs. relative) affect checksum results.
* **System Administration:** Managed file and directory access rights using `chmod` to enforce secure storage practices.
* **Storage Assessment:** Evaluated storage footprints and compression efficiency using disk usage tools like `du`.
