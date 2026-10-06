@echo off
echo RUNNING USER ENUMERATION....
echo ======================================
echo.

echo [+] Local Users:
net user
echo.

echo [+] Local Administrators Group:
net localgroup administrators
echo.

echo [+] Current logged-in users:
whoami /all
