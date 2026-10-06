@echo off
echo RUNNING NETWORK ENUMERATION....
echo ======================================
echo.

echo [+] IP Configuration:
ipconfig /all
echo.

echo [+] Routing Table:
route print
echo.

echo [+] Active Listening Ports:
netstat -ano | findstr /i "listening"