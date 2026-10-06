@echo off
echo RUNNING SYSTEM ENUMERATION....
echo ======================================
systeminfo
echo.
echo [+] OS Architecture and version:
reg query "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion" /v ProductName

