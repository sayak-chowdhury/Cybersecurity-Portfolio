#!/bin/bash

# =================================================
# Script Name: phase-10.sh
# Purpose: Web Enumeration Automation
# Usage: ./phase-10.sh <target_url_or_domain>
# =================================================

# 1.-----URL Normalization-----
INPUT_TARGET="${1:-example.com}"

# Ensure scheme exists (prepend https:// if omitted)

if [[ ! "$INPUT_TARGET" =~ ^https?:// ]]
then
	TARGET_URL="https://$INPUT_TARGET"
else
	TARGET_URL="$INPUT_TARGET"
fi
	
# Strip trailing slashes
TARGET_URL="${TARGET_URL%/}"

echo "=================================================="
echo "    PHASE 10 - WEB ENUMERATION AUTOMATION        "
echo "=================================================="
echo "[*] Target URL: $TARGET_URL"
echo "[*] Scan Date:  $(date)"
echo "=================================================="

# 2.-----Check HTTP Status Codes & Follow Redirects-----

echo -e "\n[+] Checking Status Codes & Redirect Path"

# Get initial direct response status code
INITIAL_CODE=$(curl -s -o /dev/null -w "%{http_code}" --max-time 5 "$TARGET_URL")
echo "  [*] Initial HTTP Status Code: $INITIAL_CODE"

# Follow redirects to final landing destination
FINAL_URL=$(curl -s -L -o /dev/null -w "%{url_effective}" --max-time 5 "$TARGET_URL")
FINAL_CODE=$(curl -s -L -o /dev/null -w "%{http_code}" --max-time 5 "$TARGET_URL")

echo "  [*] Final Landing URL:        $FINAL_URL"
echo "  [*] Final HTTP Status Code:   $FINAL_CODE"

# Trace intermediate HTTP redirect status codes (if any)
echo "[*] Redirect Trace: "
curl -s -I -L --max-time 10 "$TARGET_URL" | grep -Ei "^http/" | sed 's/^/      /'

# 3.-----Fetch Response Body & Headers for Enumeration-----
HTTP_HEADERS=$(curl -s -IL --max-time 10 "$TARGET_URL")
HTML_BODY=$(curl -s -L --max-time 10 "$TARGET_URL")

# 4.-----Identify Common Technologies (Headers & HTML Signatures)-----
echo -e "\n[+] Identifying Web Technologies & Headers"

# Web Server Banner
SERVER_BANNER=$(echo "$HTTP_HEADERS" | grep -i "^Server:" | tail -n 1 | tr -d '\r')

if [[ -n "$SERVER_BANNER" ]]
then
	echo "     [+] $SERVER_BANNER"
else
	echo "     [-] Server Header: Not disclosed"
fi

# Backend Framework / Language (X-Powered-By)

POWERED_BY=$(echo "$HTTP_HEADERS" | grep -i "^X-Powered-By" | tail -n 1 | tr -d '\r')

if [[ -n "$POWERED_BY" ]]
then
	echo "     [+] $POWERED_BY"
fi

# Common CMS & Frontend Fingerprints inside HTMLecho

echo "  [*] Fingerprinting CMS & Libraries..."
CMS_FOUND=false

if echo "$HTML_BODY" | grep -qi "wp-content"; then echo "      [!] Detected: WordPress CMS"; CMS_FOUND=true; fi
if echo "$HTML_BODY" | grep -qi "drupal"; then echo "      [!] Detected: Drupal CMS"; CMS_FOUND=true; fi
if echo "$HTML_BODY" | grep -qi "joomla"; then echo "      [!] Detected: Joomla CMS"; CMS_FOUND=true; fi
if echo "$HTML_BODY" | grep -qi "react"; then echo "      [!] Detected: React JS"; CMS_FOUND=true; fi
if echo "$HTML_BODY" | grep -qi "bootstrap"; then echo "      [!] Detected: Bootstrap Framework"; CMS_FOUND=true; fi
if echo "$HTML_BODY" | grep -qi "jquery"; then echo "      [!] Detected: jQuery"; CMS_FOUND=true; fi

if [ "$CMS_FOUND" = false ]; then
    echo "      [-] No common CMS or frameworks detected."
fi

# 5.-----Extract Links from HTML (href & src attributes)-----
echo -e "\n[+] Extracting Links from HTML"

# Matches href="..." or src="..." links, sorts, and filters unique entries
EXTRACTED_LINKS=$(echo "$HTML_BODY" | grep -Eoi '(href|src)="[^"]+"' | cut -d '"' -f2 | sort -u)

if [[ -n "$EXTRACTED_LINKS" ]]
then
	TOTAL_COUNT=$( echo "$EXTRACTED_LINKS" | wc -l )
	echo "  [+] Found $TOTAL_COUNT unique links/assets (showing top 10):"
	echo "$EXTRACTED_LINKS" | head -n 10 | sed 's/^/      /'
else
	echo "  [-] No links or source tags could be extracted."
fi

# 6.-----Detect robots.txt and sitemap.xml-----
echo -e "\n[+] Detecting robots.txt & sitemap.xml"

# Check robots.txt
ROBOTS_URL="$TARGET_URL/robots.txt"
ROBOTS_STATUS=$(curl -s -o /dev/null -w "%{http_code}" --max-time 5 "$ROBOTS_URL")

if [[ "$ROBOTS_STATUS" -eq 200 ]]
then
	echo "   [+] robots.txt FOUND at $ROBOTS_URL (HTTP 200)"
    	echo "   --- Disallowed Paths Preview ---"
	curl -s --max-time 5 "$ROBOTS_URL" | grep -i "^Disallow:" | head -n 5 | sed 's/^/      /'
else
	echo "   [-] robots.txt NOT found at $ROBOTS_URL (HTTP $ROBOTS_STATUS)"
fi

# Check sitemap.xml

SITEMAP_URL="$TARGET_URL/sitemap.xml"
SITEMAP_STATUS=$(curl -s -o /dev/null -w "%{http_code}" --max-time 5 "$SITEMAP_URL")

if [[ "$SITEMAP_STATUS" -eq 200 ]]
then
	echo "   [+] sitemap.xml FOUND at $SITEMAP_URL (HTTP 200)"
else
	echo "   [-] sitemap.xml NOT found at $SITEMAP_URL (HTTP $SITEMAP_STATUS)"
fi

echo -e "\n=================================================="
echo "          WEB ENUMERATION COMPLETE                "
echo "=================================================="

