@echo off
:: Sets working directory to the script's home location
cd /d "%~dp0"

:: Ensures required directories exist
if not exist reports mkdir reports
if not exist logs mkdir logs
if not exist config mkdir config

:MENU
cls
echo ==============================
echo 	Windows Pentest Toolkit
echo ==============================
echo.
echo 1. System Enumeration
echo 2. User Enumeration
echo 3. Network Enumeration
echo 4. Process Enumeration
echo 5. Service Enumeration
echo 6. Generate Full Report
echo 7. Archive Reports
echo 8. Exit
echo.
set /p choice="Select an option [1-8]: "

if "%choice%"=="1" goto SYSTEM
if "%choice%"=="2" goto USERS
if "%choice%"=="3" goto NETWORK
if "%choice%"=="4" goto PROCESS
if "%choice%"=="5" goto SERVICE
if "%choice%"=="6" goto FULL_REPORT
if "%choice%"=="7" goto ARCHIVE
if "%choice%"=="8" goto EXIT

echo [!] Invalid option, please try again with valid option [1-8].
pause
goto MENU

:SYSTEM
cls
call modules\system.bat
pause
goto MENU

:USERS
cls
call modules\users.bat
pause
goto MENU

:NETWORK
cls
call modules\network.bat
pause
goto MENU

:PROCESS
cls
call modules\processes.bat
pause
goto MENU

:SERVICE
cls
call modules\services.bat
pause
goto MENU

:FULL_REPORT
cls

echo [+] Generating Full Penetration Testing Recon Report....
for /f %%T in ('powershell -Command "Get-Date -Format 'yyyyMMdd_HHmmss'"') do set TIMESTAMP=%%T
set REPORT_FILE=reports\full_recon_%TIMESTAMP%.txt
set LOG_FILE=logs\recon_errors_%TIMESTAMP%.log

(
echo ===================================================
echo       FULL WINDOWS PENTEST ENUMERATION REPORT
echo ===================================================
echo Generated On: %DATE% @ %TIME%
echo.
call modules\system.bat
echo.
call modules\users.bat
echo.
call modules\network.bat
echo.
call modules\processes.bat
echo.
call modules\services.bat
) > "%REPORT_FILE%" 2>> "%LOG_FILE%"
echo [+] Full report saved successfully to: %REPORT_FILE%
pause
goto MENU

:ARCHIVE
cls

echo [+] Archiving all reports into ZIP file....
for /f %%T in ('powershell -Command "Get-Date -Format 'yyyyMMdd_HHmmss'"') do set TIMESTAMP=%%T
set ARCHIVE_NAME=reports\recon_archive_%TIMESTAMP%.zip

powershell -Command "Compress-Archive -Path 'reports\*.txt' -DestinationPath '%ARCHIVE_NAME%'"

if exist "%ARCHIVE_NAME%" (
echo [+] Reports archived to %ARCHIVE_NAME%
) else (
echo [!] Archiving failed or no reports found to compress.
)
pause
goto MENU

:EXIT
echo Exiting, Goodbye...
exit /b 0