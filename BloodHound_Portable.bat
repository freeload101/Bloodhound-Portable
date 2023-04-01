@echo off


echo '!!!!!!So updated JAMBOREE to run Bloodhound don't feel like maintaining bloodhound-portable .bat file :'

echo 'https://github.com/freeload101/Java-Android-Magisk-Burp-Objection-Root-Emulator-Easy'


















echo '-----------------------------------------------------------------------------------------'
echo '-----------------------------------------------------------------------------------------'


Setlocal EnableDelayedExpansion EnableExtensions

echo '-----------------------------------------------------------------------------------------'
echo 'rmccurdy.com Bloodhound Installer'
echo 'ver 1.0a'
echo '-----------------------------------------------------------------------------------------'


:LOOP
CALL :MENU
CALL :LOOP

:MENU
echo ========================= rmccurdy.com =========================
ECHO 1.Start Sharphound (runas domain user or from non domain host with runas /netonly /user:"DOMAIN\USER" cmd )
ECHO 2.Start Neo4j ^( You must change password at http://localhost:7474 ^)
ECHO 3.Start Bloodhound ^( It may take a while to allow you to connect to neo4j ^)
ECHO.
CHOICE /C 1234 /N /M "Enter your choice:"


IF ERRORLEVEL 3 CALL :BLOODHOUND
IF ERRORLEVEL 2 CALL :NEO
IF ERRORLEVEL 1 CALL :SHARPHOUND
EXIT /B 0


:INIT
:: PATHS
echo %date% %time% INFO: Setting Path and Environment Variables 
set BASE=%~dp0
cd "%BASE%"

:: JAVA
echo %date% %time% INFO: Setting Java Path and Environment Variables 
set JAVA_HOME="%BASE%jdk-11.0.1\"
set PATH="%BASE%jdk-11.0.1\bin";%PATH%
)
EXIT /B 0


:SHARPHOUND
CALL :INIT
echo Example runas usage
echo runas /user:"nr.ad.COMPANY.com\USERNAME" /netonly cmd
if exist "%BASE%SharpHound.exe" (
	echo %date% %time% INFO: Starting Sharphound
	%BASE%SharpHound.exe -s --CollectionMethods All --prettyprint true
	explorer .
) else (
	echo %date% %time% INFO: Sharphound Missing Downloading
	powershell "(New-Object Net.WebClient).DownloadFile('https://github.com/BloodHoundAD/BloodHound/raw/master/Collectors/DebugBuilds/SharpHound.exe', '.\SharpHound.exe')" > %temp%/null
	%BASE%SharpHound.exe -s --CollectionMethods All --prettyprint true
)
EXIT /B 0


:CHECKJAVA
CALL :INIT
if exist "%BASE%jdk-11.0.1\bin" (
	echo %date% %time% INFO: Java Found
) else (
	echo %date% %time% INFO: Java Missing Downloading
	powershell "(New-Object Net.WebClient).DownloadFile('https://download.java.net/java/GA/jdk11/13/GPL/openjdk-11.0.1_windows-x64_bin.zip', '.\openjdk-11.0.1_windows-x64_bin.zip')" > %temp%/null
	powershell "Expand-Archive .\openjdk-11.0.1_windows-x64_bin.zip -DestinationPath .\ "  > %temp%/null

)
EXIT /B 0


:NEO
CALL :INIT
CALL :CHECKJAVA
if exist "%BASE%neo4j-community-4.3.4" (
	echo %date% %time% INFO: Starting Neo4j
	taskkill /F /IM java.exe 2> %temp%\null
	CHOICE /T 3 /C y /CS /D y > %temp%\null
	start "" CMD /c @"!BASE!jdk-11.0.1\bin\java.exe" -cp "!BASE!\neo4j-community-4.3.4/lib/*" -Dbasedir="!BASE!\neo4j-community-4.3.4" org.neo4j.server.startup.Neo4jCommand "console" 
) else (
	echo %date% %time% INFO: Neo4j Missing Downloading
	powershell "(New-Object Net.WebClient).DownloadFile('https://neo4j.com/artifact.php?name=neo4j-community-4.3.4-windows.zip', '.\neo4j-community-4.3.4-windows.zip')" > %temp%/null
	powershell "Expand-Archive .\neo4j-community-4.3.4-windows.zip -DestinationPath .\ "  > %temp%/null

	echo %date% %time% INFO: Starting Neo4j
	taskkill /F /IM java.exe 2> %temp%\null
	CHOICE /T 3 /C y /CS /D y > %temp%\null
	start "" CMD /c @"!BASE!jdk-11.0.1\bin\java.exe" -cp "!BASE!\neo4j-community-4.3.4/lib/*" -Dbasedir="!BASE!\neo4j-community-4.3.4" org.neo4j.server.startup.Neo4jCommand "console" 
	
)
EXIT /B 0

:BLOODHOUND
CALL :INIT
	if exist "%BASE%BloodHound-win32-x64\" (

	echo %date% %time% INFO: Starting Bloodhound Please wait
	start /i cmd /c "!BASE!BloodHound-win32-x64\BloodHound.exe"
) else (
	echo %date% %time% INFO: Bloodhound Missing Downloading Please Wait This can take 1 to 5 Minutes
	powershell "(New-Object Net.WebClient).DownloadFile('https://github.com/BloodHoundAD/BloodHound/releases/download/4.1.0/BloodHound-win32-x64.zip', '.\BloodHound-win32-x64.zip')" > %temp%/null
	echo %date% %time% INFO: Extracting Bloodhound zip file
	powershell  -command "& {Add-Type -Assembly "System.IO.Compression.Filesystem"; [System.IO.Compression.ZipFile]::ExtractToDirectory(\"%BASE%BloodHound-win32-x64.zip\",  \"%BASE%\\")  }"	 > %temp%\null
	
	echo %date% %time% INFO: Starting Bloodhound Please wait
	start /i cmd /c "!BASE!BloodHound-win32-x64\BloodHound.exe"
)
EXIT /B 0
