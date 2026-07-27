#!/bin/bash

# =================================
# Script Name: phase-5.sh
# Purpose    : File Handling
# Usage      : ./phase-5.sh
# =================================

echo "=========================================="
echo "		Phase-5: File Handling		"
echo "=========================================="

#--Define key paths--

Base_Dir="$HOME/scripts"
Archive_Dir="$Base_Dir/archive"
Timestamp=$(date +"%Y-%m-%d_%H-%M-%S")
Today_report_dir="$Base_Dir/scan_$Timestamp"

#1.-----Create report folders-----

echo -e "\n[*] Creating report and archive folders....."

# -p creates parent directories if they don't exist without throwing errors
mkdir -p "$Archive_Dir"
mkdir -p "$Today_report_dir"

echo -e "\n[+] Today's report directory created: $Today_report_dir"
echo -e "\n[+] Ensured archive directory exists: $Archive_Dir"

#2.-----Save scan results-----

echo -e "\n"
read -p "[*] Enter the name of the scan file with extension (e.g: *.txt): " scan_file

Scan_file_path="$Today_report_dir/$scan_file"

echo -e "\n[*] Running mock scan and saving results in $Scan_file_path"

{
    echo "=== PENTEST SCAN REPORT ==="
    echo "Scan Date: $(date)"
    echo "---------------------------"
    echo "Target: 7.8.8.8"
    echo "Status: Reachable"
    echo "Open Ports: 52/udp (DNS)"
} > $Scan_file_path

echo "[+] Scan output successfully saved to $Scan_file_path"

# Create a second sample file inside the directory to compress later
echo "DNS record lookup details..." > "$Today_report_dir/dns_info.txt"

#3.-----Compress completed scans (*.tar.gz archive)-----

echo -e "\n[*] Compressing completed scan directory...."

#---name of the output file---
tar_file="$Today_report_dir.tar.gz"

# -c: create archive, -z: compress with gzip, -v: verbose, -f: output file name, -C [target dir] [file on which action will be performed]: changes the direcotry before archiving and pull the targeted file
tar -czvf "$tar_file" -C "$Base_Dir" "scan_$Timestamp"

echo "[+] Compressed scan folder into: $tar_file"

#4.-----Move reports to an archive----

echo -e "\n[*] Moving tar archive to archive directory....."

if [[ -f "$tar_file" ]]
then
	mv "$tar_file" "$Archive_Dir/"
	echo "[+] Moved $tar_file to $Archive_Dir"
else
	echo "[-] FAILED to move $tar_file to $Archive_Dir"
fi

#5.-----Delete file older than 30 days-----

echo -e "\n[*] Searching files older than 30 days....."

# "find" command searches in ARCHIVE_DIR for regular files (-type f) modified more than 30 days ago (-mtime +30)
# -print shows what was found, and -delete removes them safely
old_files=$(find "$Archive_Dir" -type f -name "*.tar.gz" -mtime +30)

if [[ -n $old_files ]]
then
	echo "[+] Deleting files (>30 days)....."

#---Print the files being deleted---
	echo "[+] $old_files"

	find "$Archive_Dir" -type f -name "*.tar.gz" -mtime +30 -delete
	echo "[+] Deleted successfuly"
else
	echo "[-] No files older than 30 days found."
fi

