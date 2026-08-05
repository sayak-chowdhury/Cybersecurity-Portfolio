#!/bin/bash

# ========================================================================================
# Script Name: phase6.sh
# Purpose: Extract pentesting assets from target scan results using text processing tools
# Usage: ./phase-6.sh scan_results.txt(source file)
# ========================================================================================

#--Ensure input file is provided--
if [[ -z "$1" ]]
then
	echo "Usage: $0 <path_to_scan_file>"
	exit 1
fi

Scan_file="$1"

#--Check if the file exists--
if [[ ! -f "$Scan_file" ]]
then
	echo "Error: File $Scan_file not found!!!!"
fi

echo "=================================================="
echo "          TEXT PROCESSING REPORT                  "
echo "  	    Source File: $Scan_file					"
echo "=================================================="

#1.-----Extract Open Ports (grep, awk, cut, sort, uniq, sed)-----

echo -e "\n[+]Open Ports: "
grep -i "open" "$Scan_file" | awk '{print $1}' | cut -d'/' -f1 | sort -n | uniq | sed 's/^/ -/'

#2.-----Extract Running Services (grep, awk, sort, uniq, sed)-----

echo -e "\n[+]Running services: "
grep -i "open" "$Scan_file" | awk '{print $3}' | sort -u | sed 's/^/ -/'

#3.-----Extract IPv4 Addresses (grep -E, sort, uniq, sed)-----
#---Regex breakdown: ([0-9]{1,3}\.){3}[0-9]{1,3}---
# 1. ([0-9]{1,3}\.){3} -> Matches 1 to 3 digits with 0-9 followed by a dot(matches numbers like 1, 19, or 192), which is repeated 3 times as a whole (e.g., "192.168.1.")
# 2. [0-9]{1,3}        -> Matches the 4th octet (1 to 3 digits without a trailing dot, e.g., "50")

echo -e "\n[+]IPv4 Addressess found: "
grep -E -o "([0-9]{1,3}\.){3}([0-9]{1,3})" "$Scan_file" | sort -u | sed 's/^/ -/'

#4.-----Extract URLs (grep -E, sort, uniq)-----
#----Regex breakdown: https?://[a-zA-Z0-9./_-]+----
# 1. https?://          -> Matches "http://" or "https://" ('s' is optional due to ?)
# 2. [a-zA-Z0-9./_-]+   -> Matches 1+ valid URL characters (letters, numbers, '.', '/', '_', '-')

echo -e "\n[+]URLs discovered: "
grep -E -o "https?://[a-zA-Z0-9./_-]+" "$Scan_file" | sort -u | sed 's/^/ -/'

#5.-----Extract Email Addresses (grep -E, sort, uniq)-----
#----Regex breakdown: [a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}----
# 1. [a-zA-Z0-9._%+-]+ -> Username ( letters, numbers, or allowed symbols requires one or more of these characters before rest due to "+" sign)
# 2. @[a-zA-Z0-9.-]+   -> Domain name after @ (1+ letters, numbers, dots, hyphens)
# 3. \.[a-zA-Z]{2,}    -> TLD extension (dot followed by 2 or more letters like .com, .co.uk, .org)

echo -e "\n[+]Email addresses found: "
grep -E -o "[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}" "$Scan_file" | sort -u | sed 's/^/ -/'

#6.-----Extract HTTP Status Codes & Counts (grep, awk, sort, uniq)-----
#----Pipeline breakdown: Extract & count HTTP status codes----
# 1. grep -E -o "...|..." -> Finds HTTP headers (HTTP/1.1 200) or HTTP codes (2xx, 3xx, 4xx, 5xx)
# 2. grep -E -o "[0-9]{3}" -> Isolates just the 3-digit status code number
# 3. sort | uniq -c       -> Counts occurrences of each unique status code
# 4. sort -nr             -> Sorts highest frequency to lowest frequency

echo -e "\n[+]HTTP Status Code Breakdown (Count - Code): "
grep -E -o "HTTP/[0-9\.]+ [0-9]{3} | [2345] [0-9]{2}" "$Scan_file" | grep -E -o "[0-9]{3}" | sort | uniq -c | sort -nr | sed 's/^/ -/'

echo -e "\n================================================"
echo 	"      Extraction Completed Successfully           "
echo 	"=================================================="

