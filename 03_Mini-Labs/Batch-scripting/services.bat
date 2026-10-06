@echo off
echo RUNNING SERVICE ENUMERATION....
echo ======================================
echo.

echo [+] Running Windows Sevices:
sc query state= all | findstr /i "SERVICE_NAME DISPLAY_NAME STATE"