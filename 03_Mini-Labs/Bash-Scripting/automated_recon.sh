#!/bin/bash

# ==========================================
# Mini Project 1: Automated Recon Framework
# Script Name: automated_recon.sh
# Usage: ./automated_recon.sh
# ==========================================

#-----ANSI color codes for terminal output-----

RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
CYAN='\033[0;36m'
NC='\033[0m' #No Color

#----Global Variables----

TARGET=""
BASE_DIR="$HOME/scripts/automated_recon_results"
TARGET_DIR=""
ERROR_LOGS=""
SUMMARY_REPORTS=""

# ------------------------------------------
# Helper Logging & Output Functions
# ------------------------------------------

log_success()	{ echo -e "${GREEN}[SUCCESS]${NC} $1"; } 
log_info()	{ echo -e "${BLUE}[INFO]${NC} $1"; } 
log_warn()	{ echo -e "${YELLOW}[WARNING]${NC} $1"; } 
log_error()	{ 
	echo -e "${RED}[ERROR]${NC} $1"
	[ -n "$ERROR_LOGS" ] && echo "[$(date '+%Y-%m-%d  %H-%M-%S')] [ERROR] $1" >> "$ERROR_LOGS"
}

# ------------------------------------------
# Target Validation & Directory Setup
# ------------------------------------------

set_target() {

	echo -ne "${CYAN}Enter Target (Domain/IPv4): ${NC}"
	read -r input_target

	# Regex for IPv4 or Domain name validation
	IP_REGEX="^([0-9]{1,3}\.){3}[0-9]{1,3}$"
	DOMAIN_REGEX="^([a-zA-Z0-9]([a-zA-Z0-9\-]{0,61}[a-zA-Z0-9])?\.)+[a-zA-Z]{2,}$"

	if [[ "$input_target" =~ $IP_REGEX ]] || [[ "$input_target" =~ $DOMAIN_REGEX ]]
	then
		TARGET="$input_target"
		TIMESTAMP=$(date +"+%Y%m%d_%H%M%S")
		TARGET_DIR="$BASE_DIR/${TARGET}_${TIMESTAMP}"
		ERROR_LOGS="$TARGET_DIR/logs/errors.log"
		SUMMARY_REPORTS="$TARGET_DIR/summary_report.txt"

		# Create structured folder hierarchy
		mkdir -p "$TARGET_DIR/dns" \
			 "$TARGET_DIR/http"\
			 "$TARGET_DIR/logs"

		# Initialize summary report
		cat <<EOF > "$SUMMARY_REPORTS"
		"==================================================
       			 AUTOMATED RECON SUMMARY REPORT
		==================================================
			Target     : $TARGET
			Start Time : $(date '+%Y-%m-%d %H:%M:%S')
		==================================================
EOF

		log_success "Target validated: $TARGET"
		log_info "Results will be stored in: $TARGET_DIR"
	else
		log_error "Invalid target format. Provide a valid domain or IPv4 address."
		TARGET=""
	fi

}

check_target_set() {
		if [[ -z "$TARGET" ]]
		then
			log_warn "No target set. Please select Option 1 first."
			return 1
		fi
}

# ------------------------------------------
# Recon Modules
# ------------------------------------------

run_ping() {
	check_target_set || return
	log_info "Executing ICMP Ping Test against $TARGET...."

	local ping_file="$TARGET_DIR/ping_results.txt"
	if ping -c 4 -W 4 "$TARGET" > "$ping_file" 2>> "$ERROR_LOGS"
	then
		log_success "Host is reachable via Ping."
		echo -e "\n[+] Ping Status: UP" >> "$SUMMARY_REPORTS"
	else
		log_warn "Host is unreachable via ICMP (may block ping)."
		echo -e "\n[-] Ping Status: DOWN/BLOCKED" >> "$SUMMARY_REPORTS"
	fi
	log_info "Ping results saved in: $ping_file"
}


run_dns() {
	check_target_set || return
	log_info "Running DNS Reconnaissance for $TARGET...."

	if ! command -v dig &>/dev/null
	then
		log_error "'dig' command not found. Skipping DNS enumeration."
		return
	fi

	local dns_file="$TARGET_DIR/dns/dns_records.txt"
	echo "---- DNS Record for $TARGET ----" > "$dns_file"
	echo -e "\n[+] DNS Records discovered:" >> "$SUMMARY_REPORTS"

	for rtype in A AAAA MX NS TXT SOA
	do
		echo "===> $rtype RECORDS <===" >> "$dns_file"
		local result=$(dig +short "$TARGET" "$rtype" 2>> "$ERROR_LOGS")
		if [[ -n "$result" ]]
		then
			echo "$result" >> "$dns_file"
			echo "$rtype: $(echo "$result" | head -n 1)" >> "$SUMMARY_REPORTS"
		else
			echo "Not Found" >> "$dns_file"
		fi
	done
	log_success "[+] DNS saved to $dns_file"
}

run_http() {
	check_target_set || return
	log_info "Collecting HTTP Headers & Page Title of $TARGET...."

	if ! command -v curl &>/dev/null
	then
		log_error "'curl' command not found. Skipping HTTP reconnaissance."
		return
	fi

	local header_file="$TARGET_DIR/http/headers.txt"
	local html_file="$TARGET_DIR/http/index.html"

	# Extract Headers
	curl -s -I -L -m 5 "http://$TARGET" > "$header_file" 2>> "$ERROR_LOGS"
	log_success "HTTP Headers saved to $header_file"

	# Extract Web Page Title
	curl -s -L -m 5 "http://$TARGET" > "$html_file" 2>> "$ERROR_LOGS"
	local web_title=$(grep -oPi "(?<=<title>)(.*?)(?=</title>)" "$html_file" 2>> "$ERROR_LOGS" | tr -d '\n\r' | sed 's/^[ \t]*//;s/[ \t]*$//')

	if [[ -n "$web_title" ]]
	then
		log_success "Website Title: $web_title"
		echo -e "\n[+] Website Title: $web_title" >> "$SUMMARY_REPORTS"
	else
		log_warn "Website title could not be extracted or page does not serve HTML."
		echo -e "[-] Website Title: Not Found" >> "$SUMMARY_REPORTS"
	fi

	# Append server banner to summary
	local server_header=$(grep -i "^Server:" "$header_file" | head -n 1)
	[ -n "$server_header" ] && echo "$server_header" >> "$SUMMARY_REPORTS"
}

compress_report() {
	check_target_set || return

	cat << EOF >> "$SUMMARY_REPORTS"
============================================
Scan Finished: $(date '+%Y-%m-%d %H:%M:%S')
============================================
EOF

	# Compress results directory
	local archive_name="${TARGET_DIR}.tar.gz"
	tar -czf "$archive_name" -C "$BASE_DIR" "$(basename "$TARGET_DIR")" 2>> "$ERROR_LOGS"

	log_success "Reconnaissance complete!"
	log_info "Summary Report: $SUMMARY_REPORTS"
	log_info "Compressed Report: $archive_name"
}

run_full_recon() {
	check_target_set || return
	run_ping
	run_dns
	run_http
	compress_report
}

# ------------------------------------------
# Interactive Menu Loop
# ------------------------------------------

while true
do
	echo -e "\n${CYAN}==============================================${NC}"
    	echo -e "${YELLOW}       AUTOMATED RECON FRAMEWORK              ${NC}"
    	echo -e "${CYAN}==============================================${NC}"
   	echo -e "Current Target: ${GREEN}${TARGET:-None}${NC}"
    	echo -e "1) Set / Change Target"
    	echo -e "2) Run ICMP Ping Test"
    	echo -e "3) Run DNS Reconnaissance"
    	echo -e "4) Collect HTTP Headers & Page Title"
        echo -e "5) Run Complete Scan (All Modules & Compress)"
    	echo -e "6) Compress Current Results"
    	echo -e "7) Exit"
   	echo -ne "${CYAN}Choose an option [1-8]: ${NC}"
    	read -r opt

	case "$opt" in
		1) set_target ;;
		2) run_ping ;;
		3) run_dns ;;
		4) run_http ;;
		5) run_full_recon ;;
		6) compress_report ;;
		7) log_info "Exiting $(basename "$0")"; exit 0 ;;
		*) log_error "Invalid Selection. Please enter a number between 1 and 7." ;;
	esac
done

