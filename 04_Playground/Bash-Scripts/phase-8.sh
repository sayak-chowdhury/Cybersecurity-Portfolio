#!/bin/bash

# =========================================================================================================
# Script name: phase-8.sh
# Purpose: Using the native "getopts" built-in tool for command-line flags as well as positional arguments
# Usage: ./phase-8.sh [options] [target]
# =========================================================================================================

#1.------Default Variable Initialization------
Target=""
Output_File=""
Ports="22,80,443"
Verbose=false

#2.------Help Function------
show_help(){
	echo "Usage: $0 [options] [target]"
	echo ""
	echo "OPTIONS:"
	echo "	-t <target>		Specify target IP address or domain"
	echo "	-p <ports>		Specify ports (default: 22,80.443)"
	echo "	-o <file>		Specify file path to save ouput"
	echo "	-v			Enable verbose output"
	echo "	-h			Display this help menu and exit"
	echo ""
	echo "Example:"
	echo "[*] $0 -t 192.168.1.10 -p 80 -o output.txt -v"
	echo "[*] $0 -p 80 -v example.com (Positional arguments must always be at the last.)"
	exit 0
}

#3------Arguements passing with "getopts"------
# getopts: Bash built-in command that parses short flags.
# ":t:p:o:vh": Option string defining accepted flags:
# Leading : enables silent error mode so we can write custom error handling.
# t:, p:, o:: The trailing colon : indicates that these flags require an argument (e.g., -t target.com).
# v, h: No colons mean these are standalone boolean switches.
# OPTION: Variable storing the current flag character being processed during each loop iteration.

while getopts ":t:p:o:vh" OPTION
do
	case "$OPTION" in
		t)
			Target="$OPTARG"
			;;
		p)
			Ports="$OPTARG"
			;;
		o)
			Output_File="$OPTARG"
			;;
		v)
			Verbose=true
			;;
		h)
			show_help
			;;
		\?)
			echo "[-] ERROR: Invalid option -$OPTARG." >&2
			echo "Run $0 -h for usage information."
			exit 1
			;;
		:)
			echo "[-] ERROR: Option $OPTARG requires an argument." >&2
			exit 1
			;;
	esac
done

#4------Positional Argument Fallback & Validation------
shift $((OPTIND-1))

# If -t flag wasn't used, check if a target was passed as a positional argument (e.g. ./phase8.sh target.com)
if [[ -z "$Target" ]] && [[ -n "$1" ]]
then
	Target="$1"
elif [[ -z "$Target" ]] && [[ -z "$1" ]]
then
	echo "[-] Error: Target is required. Use -t <target> or supply target as an argument."
	echo "Run '$0 -h' for help."
	exit 1
fi

#5------Main Script Execution------
echo "=================================================="
echo "       PHASE 8 - COMMAND-LINE PARSER              "
echo "=================================================="

# a.----Verbose Header (Runs ONLY if verbose mode is enabled)---
if [[ "$Verbose" = true ]]
then
	echo "[*] [VERBOSE] Mode enabled"
	echo "[*] [VERBOSE] Successfully parsed $((OPTIND-1)) options."
fi

# b.----Terminal Summary (ALWAYS runs)----
echo "[+] Target:	$Target"
echo "[+] Ports:	$Ports"

# c.----Output File Processing----
if [[ -n "$Output_File" ]]
then
	echo "[+] Output File:	$Output_File"
	
	if [[ "$Verbose" = true ]]
	then
		echo "[*] [VERBOSE] Writing summary report to $Output_File...."
	fi

	{
		echo "=== SCAN REPORT ==="
        	echo "Target: $Target"
        	echo "Ports:  $Ports"
        	echo "Date:   $(date)"
	} > $Output_File
	echo "[+] Output successfully saved to $Output_File"
fi

