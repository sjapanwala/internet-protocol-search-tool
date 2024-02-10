@echo off
chcp 65001
title IP Locator Advanced
:startscreen
mode 45,18
set version=[0.35 REN]
rem  -----------------------------------------------------------
rem 
rem     __                                 ________                               
rem    / /   ____  ____ ______     __     / ____/ /_  ____ _____  ____ ____  _____
rem   / /   / __ \/ __ `/ ___/  __/ /_   / /   / __ \/ __ `/ __ \/ __ `/ _ \/ ___/
rem  / /___/ /_/ / /_/ (__  )  /_  __/  / /___/ / / / /_/ / / / / /_/ /  __(__  ) 
rem /_____/\____/\__, /____/    /_/     \____/_/ /_/\__,_/_/ /_/\__, /\___/____/  
rem             /____/                                         /____/             
:: UPDATES AND CHANGES
::  Version 0.1
:: - Added All Features. Launch Versions

::  Version 0.2
:: - Added An Activation Key. Will be allowed to track users and keep an organized database.
:: - Developers will be able to override the activationkey, and will be able to add and modify without the database going crazy.
:: - Added an Updates and Status Section.
:: - Removed "Help", as it was not needed and the "Readme.md" file was a better alternative.
:: - Even though an update and status section has been added, the buttons dont really do anything other than the "wipe data" button. it does show update files and all that but does not really do anything

:: Version 0.3
:: -Added a new terminal command line to the interface
rem -----------------------------------------------------------



:: Modifyable Variables - You Can Modify These Variables

set safeip=1.1.1.1
set autosavestatus=true
set autosavefilename=savefile1
set credit=sjapanwala
set savedfolderip=IP_DATA_STORAGE
::set githublink=      
if exist developerfiles.dev set developermode=[Active]
if not exist developerfiles.dev set developermode=[Inactive]
set ipvformatsaccepted=[IPV4, IPV6]
set safeipmode=[False]
if %safeip%==%safeip% set safeipmode=[True]
if exist developerfiles.dev set deviceexposure=[Hidden]
if not exist developerfiles.dev set deviceexposure=[Always Shown]
:: start data vars      
FOR /F %%b IN ('curl https://ipv4.icanhazip.com/') DO set INITIALIPV4=%%b
FOR /F %%a IN ('curl https://ipv4.icanhazip.com/') DO set homeipv4=%%a
FOR /F %%c IN ('curl https://icanhazip.com/') DO set homeipv6=%%c
FOR /F %%d IN ('tzutil /g') DO set TIMEZONE=%%d
FOR /F %%e IN ('curl https://ipapi.co/%homeipv4%/country/') DO set country=%%e
FOR /F %%f IN ('curl https://ipapi.co/%homeipv4%/org/') DO set networkorg=%%f
FOR /F %%h IN ('curl https://ipapi.co/%targetip%/country/') DO set geolocation=%%h
set targetip=%INITIALIPV4%
set Iptype=IPV4
:: activation
:: check if activatedx
REM ACTIVATION FOR THIS BATCH
REM BATCH #    ║ ACTIVATION KEY #   ║ DATE VALID
rem -----------║--------------------║-------------
rem    1       ║ 001122334455       ║ ALLTIME
:: activation vars
set activationvbatchnumber=1
set activationkey=001122334455
set activationexpire=never
:: check activation status
if exist activationkey.ipst set activationkeystatus=[Active] && goto startfile
if exist developerfiles.dev goto startfile
if not exist activationkey.ipst goto activatesoftware
goto activatesoftware
:startfile
:: github connection
rem coming in the future
:: autosave functionality
if %autosavestatus%==true set autosave=on
if %autosavestatus%==false set autosave=off
:: formatibilityy of autosave
if %autosavestatus%==false set autosavedisplay=[False]
if %autosavestatus%==true set autosavedisplay=[True]
set developercode=0000
:: countires defined
:mainscreenupdatetest
:: developer update file
if exist developermodule.insrt goto developerupdatefile
:: regularupdatefile
if exist updatefile.ipst goto regularupdatefile
:mainscreen
title IPST %version%
set autosavefilename=savefile1
mode 45,25
cls
echo [40;37m╔══════════════════════════════════════════╗
echo [40;37m║
echo [40;37m║ ┍Target IP [[40;32m%iptype%[40;37m]
echo [40;37m║ └[[40;34m%targetip%[40;37m]
echo [40;37m║
echo [40;37m╠══════════════════════════════════════════╗ 
echo [40;37m║                                          [40;37m║
echo [40;37m║ [[40;31m1[40;37m] This Systems IP                      [40;37m║
echo [40;37m║ [[40;31m2[40;37m] Search IP                            [40;37m║
echo [40;37m║ [[40;31m3[40;37m] Change Target                        [40;37m║ 
echo [40;37m║ [[40;31m4[40;37m] WHOIS?                               [40;37m║ 
echo [40;37m║ [[40;31m5[40;37m] GeoLocation                          [40;37m║
echo [40;37m║ [[40;31m6[40;37m] Settings                             [40;37m║
echo [40;37m║ [[40;31m7[40;37m] Updates + Status                     [40;37m║
echo [40;37m║ [[40;31m8[40;37m] Recent IP's                          [40;37m║ 
echo [40;37m║                                          [40;37m║ 
echo [40;37m╚══════════════════════════════════════════╝
set choice=
set /p choice=→ 

if %choice%==1 goto systemip
if %choice%==2 goto site2
if %choice%==3 goto changeip
if %choice%==4 goto whois
if %choice%==5 goto geolocation
if %choice%==6 goto settings
if %choice%==7 goto updates
if %choice%==8 start recentips.txt && goto mainscreen
if %choice%==cmd goto commandline
if %choice%==commandline goto commandline
goto wronginput

:wronginput
echo x=msgbox("Wrong Input!" ,16, "Input Error") >> msgbox.vbs
start msgbox.vbs
timeout 1 >nul
del msgbox.vbs
goto mainscreen


:systemip
echo %homeipv4% Was Used [%time%] [%date%] [%iptype%]>>recentips.txt
mode 67, 40
cls
curl http://ip-api.com/?fields=status,message,continent,continentCode,country,countryCode,region,regionName,city,district,zip,lat,lon,timezone,offset,currency,isp,org,as,asname,mobile,proxy,hosting,query
pause>nul
:savesystemip
set filename=NATIVEIP.txt
if exist %filename% goto mainscreen
cls
echo IP TEST SYSTEM:----%computername%>>%filename%
echo IP TESTED:---------%homeipv4%>>%filename%
echo IP TEST DATE:------%date%>>%filename%
echo IP TEST TIME:------%time%>>%filename%
echo -------------------------------------->>%filename%
curl http://ip-api.com/line/?fields=status,message,continent,continentCode,country,countryCode,region,regionName,city,district,zip,lat,lon,timezone,offset,currency,isp,org,as,asname,reverse,mobile,proxy,hosting,query>>%filename%
echo -------------------------------------->>%filename%
move "%filename%" "%savedfolderip%"
goto mainscreen

:site1
if %targetip%==%safeip% goto ipcannotwork
if %iptype%==IPV4 goto continuetosite1
goto wrongformat1
:continuetosite1
echo %targetip% Was Used [%time%] [%date%] [%iptype%]>>recentips.txt
mode 67, 40
curl http://ip-api.com/line/?fields=%targetip%,status,message,continent,continentCode,country,countryCode,region,regionName,city,district,zip,lat,lon,timezone,offset,currency,isp,org,as,asname,reverse,mobile,proxy,hosting,query
echo.
echo.
if %autosave%==on set filename=%autosavefilename%
if %autosave%==on goto savefilesite1
set /p savechoice= Save File? (Y/N): 
if %savechoice%==y goto savefilesite1
if %savechoice%==Y goto savefilesite1
if %savechoice%==n goto mainscreen
if %savechoice%==N goto mainscreen
goto badinput
:savefilesite1
set /p filename=Set A File Name [Will Be Saved With .txt Extention]:
if exist %filename%.txt echo [40;31mFile Exists Already[40;37m && goto savefilesite1
echo IP ADDRESS------: %targetip% >>%filename%.txt
echo IPV FORMAT------: %iptype% >>%filename%.txt
echo IP REQUEST TIME-: %time% >>%filename%.txt
echo IP REQUEST DATE-: %date% >>%filename%.txt
echo HOME IPV4-------: %homeipv4% >>%filename%.txt
echo HOME IPV6-------: %homeipv6% >>%filename%.txt
echo HOME TIMEZONE---: %TIMEZONE% >>%filename%.txt
echo REQUEST USERNAME: %username% >>%filename%.txt
echo. >>%filename%.txt
echo.  >>%filename%.txt
echo TARGET IP-------: %targetip% >>%filename%.txt
curl http://ip-api.com/line/?fields=%targetip%,status,message,continent,continentCode,country,countryCode,region,regionName,city,district,zip,lat,lon,timezone,offset,currency,isp,org,as,asname,reverse,mobile,proxy,hosting,query>>%filename%.txt
goto filesaved

:site2
if %targetip%==%safeip% goto ipcannotwork
if %iptype%==IPV4 goto continuetosite2
if %iptype%==IPV6 goto continuetosite2
goto wrongformat2
:continuetosite2
set filename=%targetip%.txt
cls
echo %targetip% Was Used [%time%] [%date%] [%iptype%]>>recentips.txt
mode 67, 35
curl https://ipapi.co/%targetip%/json/
pause
if exist %filename% goto mainscreen
if %autosave%==on goto savedata
goto mainscreen
:savedata
echo IP TEST SYSTEM:----%computername%>>%filename%
echo IP TESTED:---------%targetip%>>%filename%
echo IP TEST DATE:------%date%>>%filename%
echo IP TEST TIME:------%time%>>%filename%
echo -------------------------------------->>%filename%
curl https://ipapi.co/%targetip%/json/>>%filename%
echo -------------------------------------->>%filename%
move "%filename%" "%savedfolderip%"
goto mainscreen

:changeip
mode 48,20
cls
echo ╔═════════════════════════════════════════════╗
echo  [[40;34m%networkorg%[40;37m] Communications
echo ╚═════════════════════════════════════════════╝
echo ╔═════════════════════════════════════════════╗
echo  ┍This Devices [[40;32mIPV4[40;37m]
echo  └[[40;31m*[40;37m] %homeipv4%
echo  ┍This Devices [[40;32mIPV6[40;37m]
echo  └[[40;31m*[40;37m] %homeipv6%
echo ╚═════════════════════════════════════════════╝
echo.
echo Set Your Target IP Form As [[40;32mIPV4[40;37m] or [[40;32mIPV6[40;37m]
set /p usersetiptype=→ 
if %usersetiptype%==IPV4 goto continueipset
if %usersetiptype%==IPV6 goto continueipset
goto iptypenotsupported

:continueipset
echo Set Your Target IP Following the Format Entered Previously
set /p usersetip=→ 

::check if IP is valid, usable, or block listed
if %usersetiptype%==IPV4 goto verifysetipsite1
if %usersetiptype%==IPV6 goto verifysetipsite1
:verifysetipsite1
echo %targetip% Was Set As A Target [%time%] [%date%] [%usersetiptype%]>>recentips.txt
echo ╔═════════════════════════════════════════════╗
curl http://ip-api.com/line/%usersetip%?fields=query
curl http://ip-api.com/line/%usersetip%?fields=status
curl http://ip-api.com/line/%usersetip%?fields=message
curl http://ip-api.com/line/%usersetip%?fields=org
echo ╚═════════════════════════════════════════════╝
echo.
echo If Line Says---: success, Connection Is Good
echo If Line Says---: fail   , Connection Is Bad
echo.
set targetip=%usersetip%
set iptype=%usersetiptype%
pause
FOR /F %%h IN ('curl https://ipapi.co/%targetip%/country/') DO set geolocation=%%h
goto mainscreen

:whois
cls
if %targetip%==%safeip% goto ipcannotwork
if %iptype%==IPV4 goto whoisallowed
goto wrongformat1
:whoisallowed
set filename=WHOIS%targetip%.txt
curl https://api.ipapi.is/?whois=%targetip%
pause>nul
if exist %filename% goto mainscreen
if %autosave%==on goto savedatawhois
goto mainscreen
:savedatawhois
echo WHOIS TEST SYSTEM:----%computername%>>%filename%
echo WHOIS TESTED:---------%targetip%>>%filename%
echo WHOIS TEST DATE:------%date%>>%filename%
echo WHOIS TEST TIME:------%time%>>%filename%
echo -------------------------------------->>%filename%
curl https://api.ipapi.is/?whois=%targetip%>>%filename%
echo -------------------------------------->>%filename%
move "%filename%" "%savedfolderip%"
goto mainscreen



:geolocation
cls
mode 80,25
if %geolocation%==US goto NA
if %geolocation%==CA goto NA 
if %geolocation%==MX goto NA
if %geolocation%==DE goto EU
if %geolocation%==AU goto OCE
if %geolocation%==PK goto ASIA
if %geolocation%==RU goto ASIA
goto nogeolocation
::chcp 65001
::mode 80,25
::cls
::echo GEO LOCATION OF [%targetip%]. Continent [%geolocation%]
::echo ------------------------------------------------------------------------------- 
::echo.
::echo              [40;31m        ○○○○z○ ○○○○○○   [40;33m                                  
::echo              [40;31m     ○○○○○○○○○○○○○○○○○○ [40;33m  ○○○○          [40;35m○○○               
::echo              [40;31m   ○○○○○○○○○○○○○○○○○○○  [40;33m   ○     [40;35m○○o○○○○○○○○○  ○○○       
::echo         [40;31m○○○○○[40;31m○○○○○○○○○○○○○○ ○○○○○○   [40;33m   ○○ooo[40;35m○○○○○○○○○○○○○○○○○○○○○○○○○ 
::echo         [40;31m○○○○○[40;31m○○○○○○○○○○○○○○○○○○○ ○○  [40;33m ○○oooo[40;35m○○○○○○○○○○○○○○○○○○○○○○○○○○○
::echo          [40;31m○○○○[40;31m○○○○○○○○○○○○○○○        [40;33m○○○oooo[40;35m○○○○○○○○○○○○○○○○○○○○○○○     
::echo                  [40;31m○○○○○○○○○○○○○       [40;33m○○○○○oooo[40;35m○○○○○○○○○○○○○○○○○○ ○     
::echo                  [40;31m○○○○○○○○○○○         [40;33m○○○○○○oooo[40;35m○○○○○○○○○○○○○○○○○        
::echo                   [40;31m○○○○○○           [40;33m○○○○○○○○oooo[40;35m○○○○○○○○○○○○○○○         
::echo                   [40;31m○○○○○○○○○       [40;34m○○○○○○○○○[40;35m○○○○○○○○○○○○○○○○            
::echo                       [40;31m○○○○       [40;34m○○○○○○○○○○○[40;35m○○   ○○  ○○○○○○           
::echo                           [40;32m○○○○○○○       [40;34m○○○○○ [40;36m○○○        ○○○○○○○○○○      
::echo                         [40;32m○○○○○○○○       [40;34m○○○○○○○○         [40;36m○○○○○○○○○○     
::echo                          [40;32m○○○○○        [40;34m○○○○○○○○          [40;36m○○○○○○○ ○○ ○  
::echo                          [40;32m○○○○○          [40;34m○○○○             [40;36m○○○○○○○  ○   
::echo                         [40;32m○○○○                                  [40;36m○○  ○○○  
::echo                         [40;32m○○○○                                      [40;36m○○   
::echo                          [40;32m○○    
::pause>nul
@echo off
cls
mode 80,25
:NA
cls
echo GEO LOCATION OF [%targetip%]. Country [%geolocation%]
echo ------------------------------------------------------------------------------- 
echo.
echo            [40;31m        ○○○○z○ ○○○○○○   [40;37m                                  
echo            [40;31m     ○○○○○○○○○○○○○○○○○○ [40;37m  ○○○○          [40;37mm○○○               
echo            [40;31m   ○○○○○○○○○○○○○○○○○○○  [40;37m   ○     [40;37mm○○o○○○○○○○○○  ○○○       
echo       [40;31mm○○○○○[40;31m○○○○○○○○○○○○○○ ○○○○○○   [40;37m   ○○ooo[40;37mm○○○○○○○○○○○○○○○○○○○○○○○○○ 
echo       [40;31mm○○○○○[40;31m○○○○○○○○○○○○○○○○○○○ ○○  [40;37m ○○oooo[40;37mm○○○○○○○○○○○○○○○○○○○○○○○○○○○
echo        [40;31mm○○○○[40;31m○○○○○○○○○○○○○○○        [40;37m○○○oooo[40;37mm○○○○○○○○○○○○○○○○○○○○○○○     
echo                [40;31mm○○○○○○○○○○○○○       [40;37m○○○○○oooo[40;37mm○○○○○○○○○○○○○○○○○○ ○     
echo                [40;31mm○○○○○○○○○○○         [40;37m○○○○○○oooo[40;37mm○○○○○○○○○○○○○○○○○        
echo                 [40;31mm○○○○○○           [40;37m○○○○○○○○oooo[40;37mm○○○○○○○○○○○○○○○         
echo                 [40;31mm○○○○○○○○○       [40;37mm○○○○○○○○○[40;37mm○○○○○○○○○○○○○○○○            
echo                     [40;31mm○○○○       [40;37mm○○○○○○○○○○○[40;37mm○○   ○○  ○○○○○○           
echo                           [40;37m○○○○○○○       [40;37mm○○○○○ ○○○        [40;37mm○○○○○○○○○○      
echo                         [40;37m○○○○○○○○       [40;37mm○○○○○○○○         [40;37mm○○○○○○○○○○     
echo                          [40;37m○○○○○        [40;37mm○○○○○○○○          [40;37mm○○○○○○○ ○○ ○  
echo                          [40;37m○○○○○          [40;37mm○○○○             [40;37mm○○○○○○○  ○   
echo                         [40;37m○○○○                                  [40;37mm○○  ○○○  
echo                         [40;37m○○○○                                      [40;37mm○○   
echo                          [40;37m○○    
pause>nul
goto mainscreen
:SA
mode 80,25
cls
echo GEO LOCATION OF [%targetip%]. Country [%geolocation%]
echo ------------------------------------------------------------------------------- 
echo.
echo            [40;37m        ○○○○z○ ○○○○○○   [40;37m                                  
echo            [40;37m     ○○○○○○○○○○○○○○○○○○ [40;37m  ○○○○          [40;37mm○○○               
echo            [40;37m   ○○○○○○○○○○○○○○○○○○○  [40;37m   ○     [40;37mm○○o○○○○○○○○○  ○○○       
echo       [40;37mm○○○○○[40;37m○○○○○○○○○○○○○○ ○○○○○○   [40;37m   ○○ooo[40;37mm○○○○○○○○○○○○○○○○○○○○○○○○○ 
echo       [40;37mm○○○○○[40;37m○○○○○○○○○○○○○○○○○○○ ○○  [40;37m ○○oooo[40;37mm○○○○○○○○○○○○○○○○○○○○○○○○○○○
echo        [40;37mm○○○○[40;37m○○○○○○○○○○○○○○○        [40;37m○○○oooo[40;37mm○○○○○○○○○○○○○○○○○○○○○○○     
echo                [40;37mm○○○○○○○○○○○○○       [40;37m○○○○○oooo[40;37mm○○○○○○○○○○○○○○○○○○ ○     
echo                [40;37mm○○○○○○○○○○○         [40;37m○○○○○○oooo[40;37mm○○○○○○○○○○○○○○○○○        
echo                 [40;37mm○○○○○○           [40;37m○○○○○○○○oooo[40;37mm○○○○○○○○○○○○○○○         
echo                 [40;37mm○○○○○○○○○       [40;37mm○○○○○○○○○[40;37mm○○○○○○○○○○○○○○○○            
echo                     [40;37mm○○○○       [40;37mm○○○○○○○○○○○[40;37mm○○   ○○  ○○○○○○           
echo                           [40;31m○○○○○○○       [40;37mm○○○○○ ○○○        [40;37mm○○○○○○○○○○      
echo                         [40;31m○○○○○○○○       [40;37mm○○○○○○○○         [40;37mm○○○○○○○○○○     
echo                          [40;31m○○○○○        [40;37mm○○○○○○○○          [40;37mm○○○○○○○ ○○ ○  
echo                          [40;31m○○○○○          [40;37mm○○○○             [40;37mm○○○○○○○  ○   
echo                         [40;31m○○○○                                  [40;37mm○○  ○○○  
echo                         [40;31m○○○○                                      [40;37mm○○   
echo                          [40;31m○○    
pause>nul
goto mainscreen
:EU
mode 80,25
cls
echo [40;37mGEO LOCATION OF [%targetip%]. Country [%geolocation%]
echo ------------------------------------------------------------------------------- 
echo.
echo            [40;37m        ○○○○z○ ○○○○○○   [40;31m                                  
echo            [40;37m     ○○○○○○○○○○○○○○○○○○ [40;31m  ○○○○          [40;37mm○○○               
echo            [40;37m   ○○○○○○○○○○○○○○○○○○○  [40;31m   ○     [40;37mm○○o○○○○○○○○○  ○○○       
echo       [40;37mm○○○○○[40;37m○○○○○○○○○○○○○○ ○○○○○○   [40;31m   ○○ooo[40;37mm○○○○○○○○○○○○○○○○○○○○○○○○○ 
echo       [40;37mm○○○○○[40;37m○○○○○○○○○○○○○○○○○○○ ○○  [40;31m ○○oooo[40;37mm○○○○○○○○○○○○○○○○○○○○○○○○○○○
echo        [40;37mm○○○○[40;37m○○○○○○○○○○○○○○○        [40;31m○○○oooo[40;37mm○○○○○○○○○○○○○○○○○○○○○○○     
echo                [40;37mm○○○○○○○○○○○○○       [40;31m○○○○○oooo[40;37mm○○○○○○○○○○○○○○○○○○ ○     
echo                [40;37mm○○○○○○○○○○○         [40;31m○○○○○○oooo[40;37mm○○○○○○○○○○○○○○○○○        
echo                 [40;37mm○○○○○○           [40;31m○○○○○○○○oooo[40;37mm○○○○○○○○○○○○○○○         
echo                 [40;37mm○○○○○○○○○       [40;31mm○○○○○○○○○[40;37mm○○○○○○○○○○○○○○○○            
echo                     [40;37mm○○○○       [40;37mm○○○○○○○○○○○[40;37mm○○   ○○  ○○○○○○           
echo                           [40;37m○○○○○○○       [40;37mm○○○○○ ○○○        [40;37mm○○○○○○○○○○      
echo                         [40;37m○○○○○○○○       [40;37mm○○○○○○○○         [40;37mm○○○○○○○○○○     
echo                          [40;37m○○○○○        [40;37mm○○○○○○○○          [40;37mm○○○○○○○ ○○ ○  
echo                          [40;37m○○○○○          [40;37mm○○○○             [40;37mm○○○○○○○  ○   
echo                         [40;37m○○○○                                  [40;37mm○○  ○○○  
echo                         [40;37m○○○○                                      [40;37mm○○   
echo                          [40;37m○○    
pause>nul
goto mainscreen
:AF
mode 80,25
cls
echo [40;37mGEO LOCATION OF [%targetip%]. Country [%geolocation%]
echo ------------------------------------------------------------------------------- 
echo.
echo            [40;37m        ○○○○z○ ○○○○○○   [40;37m                                  
echo            [40;37m     ○○○○○○○○○○○○○○○○○○ [40;37m  ○○○○          [40;37mm○○○               
echo            [40;37m   ○○○○○○○○○○○○○○○○○○○  [40;37m   ○     [40;37mm○○o○○○○○○○○○  ○○○       
echo       [40;37mm○○○○○[40;37m○○○○○○○○○○○○○○ ○○○○○○   [40;37m   ○○ooo[40;37mm○○○○○○○○○○○○○○○○○○○○○○○○○ 
echo       [40;37mm○○○○○[40;37m○○○○○○○○○○○○○○○○○○○ ○○  [40;37m ○○oooo[40;37mm○○○○○○○○○○○○○○○○○○○○○○○○○○○
echo        [40;37mm○○○○[40;37m○○○○○○○○○○○○○○○        [40;37m○○○oooo[40;37mm○○○○○○○○○○○○○○○○○○○○○○○     
echo                [40;37mm○○○○○○○○○○○○○       [40;37m○○○○○oooo[40;37mm○○○○○○○○○○○○○○○○○○ ○     
echo                [40;37mm○○○○○○○○○○○         [40;37m○○○○○○oooo[40;37mm○○○○○○○○○○○○○○○○○        
echo                 [40;37mm○○○○○○           [40;37m○○○○○○○○oooo[40;37mm○○○○○○○○○○○○○○○         
echo                 [40;37mm○○○○○○○○○       [40;37mm○○○○○○○○○[40;37mm○○○○○○○○○○○○○○○○            
echo                     [40;37mm○○○○       [40;31mm○○○○○○○○○○○[40;37mm○○   ○○  ○○○○○○           
echo                           [40;37m○○○○○○○       [40;31mm○○○○○ ○○○        [40;37mm○○○○○○○○○○      
echo                         [40;37m○○○○○○○○       [40;31mm○○○○○○○○         [40;37mm○○○○○○○○○○     
echo                          [40;37m○○○○○        [40;31mm○○○○○○○○          [40;37mm○○○○○○○ ○○ ○  
echo                          [40;37m○○○○○          [40;31mm○○○○             [40;37mm○○○○○○○  ○   
echo                         [40;37m○○○○                                  [40;37mm○○  ○○○  
echo                         [40;37m○○○○                                      [40;37mm○○   
echo                          [40;37m○○    
pause>nul
goto mainscreen
:ASIA
mode 80,25
cls
echo [40;37mGEO LOCATION OF [%targetip%]. Country [%geolocation%]
echo ------------------------------------------------------------------------------- 
echo.
echo            [40;37m        ○○○○z○ ○○○○○○   [40;37m                                  
echo            [40;37m     ○○○○○○○○○○○○○○○○○○ [40;37m  ○○○○          [40;31mm○○○               
echo            [40;37m   ○○○○○○○○○○○○○○○○○○○  [40;37m   ○     [40;31mm○○o○○○○○○○○○  ○○○       
echo       [40;37mm○○○○○[40;37m○○○○○○○○○○○○○○ ○○○○○○   [40;37m   ○○ooo[40;31mm○○○○○○○○○○○○○○○○○○○○○○○○○ 
echo       [40;37mm○○○○○[40;37m○○○○○○○○○○○○○○○○○○○ ○○  [40;37m ○○oooo[40;31mm○○○○○○○○○○○○○○○○○○○○○○○○○○○
echo        [40;37mm○○○○[40;37m○○○○○○○○○○○○○○○        [40;37m○○○oooo[40;31mm○○○○○○○○○○○○○○○○○○○○○○○     
echo                [40;37mm○○○○○○○○○○○○○       [40;37m○○○○○oooo[40;31mm○○○○○○○○○○○○○○○○○○ ○     
echo                [40;37mm○○○○○○○○○○○         [40;37m○○○○○○oooo[40;31mm○○○○○○○○○○○○○○○○○        
echo                 [40;37mm○○○○○○           [40;37m○○○○○○○○oooo[40;31mm○○○○○○○○○○○○○○○         
echo                 [40;37mm○○○○○○○○○       [40;37mm○○○○○○○○○[40;31mm○○○○○○○○○○○○○○○○            
echo                     [40;37mm○○○○       [40;37mm○○○○○○○○○○○[40;37mm○○   ○○  ○○○○○○           
echo                           [40;37m○○○○○○○       [40;37mm○○○○○ ○○○        [40;37mm○○○○○○○○○○      
echo                         [40;37m○○○○○○○○       [40;37mm○○○○○○○○         [40;37mm○○○○○○○○○○     
echo                          [40;37m○○○○○        [40;37mm○○○○○○○○          [40;37mm○○○○○○○ ○○ ○  
echo                          [40;37m○○○○○          [40;37mm○○○○             [40;37mm○○○○○○○  ○   
echo                         [40;37m○○○○                                  [40;37mm○○  ○○○  
echo                         [40;37m○○○○                                      [40;37mm○○   
pause>nul
goto mainscreen
:OCE
mode 80,25
cls
echo [40;37mGEO LOCATION OF [%targetip%]. Country [%geolocation%]
echo ------------------------------------------------------------------------------- 
echo.
echo            [40;37m        ○○○○z○ ○○○○○○   [40;37m                                  
echo            [40;37m     ○○○○○○○○○○○○○○○○○○ [40;37m  ○○○○          [40;37mm○○○               
echo            [40;37m   ○○○○○○○○○○○○○○○○○○○  [40;37m   ○     [40;37mm○○o○○○○○○○○○  ○○○       
echo       [40;37mm○○○○○[40;37m○○○○○○○○○○○○○○ ○○○○○○   [40;37m   ○○ooo[40;37mm○○○○○○○○○○○○○○○○○○○○○○○○○ 
echo       [40;37mm○○○○○[40;37m○○○○○○○○○○○○○○○○○○○ ○○  [40;37m ○○oooo[40;37mm○○○○○○○○○○○○○○○○○○○○○○○○○○○
echo        [40;37mm○○○○[40;37m○○○○○○○○○○○○○○○        [40;37m○○○oooo[40;37mm○○○○○○○○○○○○○○○○○○○○○○○     
echo                [40;37mm○○○○○○○○○○○○○       [40;37m○○○○○oooo[40;37mm○○○○○○○○○○○○○○○○○○ ○     
echo                [40;37mm○○○○○○○○○○○         [40;37m○○○○○○oooo[40;37mm○○○○○○○○○○○○○○○○○        
echo                 [40;37mm○○○○○○           [40;37m○○○○○○○○oooo[40;37mm○○○○○○○○○○○○○○○         
echo                 [40;37mm○○○○○○○○○       [40;37mm○○○○○○○○○[40;37mm○○○○○○○○○○○○○○○○            
echo                     [40;37mm○○○○       [40;37mm○○○○○○○○○○○[40;37mm○○   [40;31○○  ○○○○○○           
echo                           [40;37m○○○○○○○       [40;37mm○○○○○ ○○○        [40;31mm○○○○○○○○○○      
echo                         [40;37m○○○○○○○○       [40;37mm○○○○○○○○         [40;31mm○○○○○○○○○○     
echo                          [40;37m○○○○○        [40;37mm○○○○○○○○          [40;31mm○○○○○○○ ○○ ○  
echo                          [40;37m○○○○○          [40;37mm○○○○             [40;31mm○○○○○○○  ○   
echo                         [40;37m○○○○                                  [40;31mm○○  ○○○  
echo                         [40;37m○○○○                                      [40;31mm○○   
echo                          [40;37m○○    
pause>nul
goto mainscreen
:settings
mode 45,25
cls
echo [40;37m------------------Settings------------------
echo.
echo Version State---------------:%version%
echo Current Formats Accepted----:%ipvformatsaccepted%
echo Developer Mode--------------:%developermode%
echo Safe IP Mode----------------:%safeipmode%
echo Device Exposure-------------:%deviceexposure%
echo Auto Save-------------------:%autosavedisplay%
echo.
echo ------------------Details-------------------
echo.
echo Computer Name---------------:%computername%
echo User Name-------------------:%username%
echo Country---------------------:%country%
echo Time Zone-------------------:%TIMEZONE%
echo Activation Status-----------:%activationkeystatus%
echo Activation Key--------------:%activationkey%
echo GitHub Connection-----------:Not Available
pause 
goto mainscreen

:activatesoftware
goto activationerror && goto activatesoftware2
:activatesoftware2
cls
set autosavefilename=savefile1
mode 45,25
cls
echo [40;37m╔══════════════════════════════════════════╗
echo [40;37m║
echo [40;37m║ ┍Target IP [[40;32m%iptype%[40;37m]
echo [40;37m║ └[[40;34m%targetip%[40;37m]
echo [40;37m║
echo [40;37m╠══════════════════════════════════════════╗ 
echo [40;37m║                                          [40;37m║
echo [40;37m║ [40;31m Please Activate Before Use.             [40;37m║
echo [40;37m║ [40;31m Activation Key Can Be Bought or         [40;37m║
echo [40;37m║ [40;31m Provided.                               [40;37m║ 
echo [40;37m║                                          [40;37m║
echo [40;37m║  [40;37m(1) Enter Activation Key                [40;37m║
echo [40;37m║                                          [40;37m║
echo [40;37m║                                          [40;37m║ 
echo [40;37m╚══════════════════════════════════════════╝
set activationchoice=
set /p activationchoice=→ 

if %activationchoice%==1 goto activatekey
if %activationchoice%==0 goto override
if %activattionchoice%==onetimeuse goto onetimeuse
goto activationerror

:onetimeuse
goto mainscreen

:activatekey
cls
echo [40;37m╔══════════════════════════════════════════╗ 
echo [40;37m║                                          [40;37m║
echo [40;37m║ [40;31m Please Enter Activation Key             [40;37m║
echo [40;37m║ [40;33m [xxxxxxxxxx]                            [40;37m║
echo [40;37m║                                          [40;37m║          
echo [40;37m╚══════════════════════════════════════════╝
echo.
set /p userenteredactivationkey=→[40;33m 
if %userenteredactivationkey%==%activationkey% goto activated
goto keynotverified

:activated
cls
echo KEY VALIDATED.
echo. 
echo ASSIGNING %activationkey% to %username%...
echo -----------------------------------------------------------
echo.
echo Please Enter The Following Details To Create Support Reciept.
set /p useremail=Please Enter An Email Address: 
set /p usergovname=Please Enter Your Name: 
set /p userage=Please Enter Your Age: 
echo. 
echo -----------------------------------------------------------
echo Making Support Reciept.
echo Support Reciept>>supportrecipt.txt
echo ----------------------------------------------------------->>supportrecipt.txt
echo Personal Details - %computername%>>supportrecipt.txt
echo ----------------------------------------------------------->>supportrecipt.txt
echo Email: %useremail%>>supportrecipt.txt
echo Name: %usergovname%>>supportrecipt.txt
echo Home IPv4: %homeipv4%>>supportrecipt.txt
echo Home IPv6: %homeipv6%>>supportrecipt.txt
echo Region: %geolocation%>>supportrecipt.txt
echo Timezone: %timezone%>>supportrecipt.txt
echo ----------------------------------------------------------->>supportrecipt.txt
echo App Data - %version%>>supportrecipt.txt
echo ----------------------------------------------------------->>supportrecipt.txt
echo Version: %version%>>supportrecipt.txt
echo Dev Mode: %developermode%>>supportrecipt.txt
echo Device Name: %computername%>>supportrecipt.txt
echo Activation Code: %activationcode%>>supportrecipt.txt
echo ----------------------------------------------------------->>supportrecipt.txt
echo For Issues And Trouble Shooting, Please Refer to "Readme.md">>supportrecipt.txt
echo ----------------------------------------------------------->>supportrecipt.txt
echo %activationkey%>>activationkey.ipst
echo.
:RECENTIPS
echo     ____                       __  __         __  __              __   ________ _      >recentips.txt
echo    / __ \___  ________  ____  / /_/ /_  __   / / / /_______  ____/ /  /  _/ __ ( )_____>>recentips.txt
echo   / /_/ / _ \/ ___/ _ \/ __ \/ __/ / / / /  / / / / ___/ _ \/ __  /   / // /_/ /// ___/>>recentips.txt
echo  / _, _/  __/ /__/  __/ / / / /_/ / /_/ /  / /_/ (__  )  __/ /_/ /  _/ // ____/ (__  ) >>recentips.txt
echo /_/ l_l\___/\___/\___/_/ /_/\__/_/\__, /   \____/____/\___/\__,_/  /___/_/     /____/  >>recentips.txt
echo                                  /____/                                              >>recentips.txt
echo --------------------------------------------------------------------------------------->>recentips.txt
echo.>>recentips.txt
echo.>>recentips.txt
mkdir %savedfolderip%
echo Done!
pause
goto mainscreen

:override
cls
echo //OVERRIDE
echo -----------------------------------------------------------
echo Please Enter Your Details
echo -----------------------------------------------------------
echo.
set /p userdevelopercode=
if %userdevelopercode%==%developercode% echo developerfiles.dev>>developerfiles.dev && goto RECENTIPS
goto activatesoftware
:developermodesetup
cls
echo Granting Developermode 
echo developerfiles.dev>>developerfiles.dev
timeout 3>nul
goto mainscreen
pause>nul
goto mainscreen


:updates
cls
set recentupdate=N/A
echo Last Updated - [%recentupdate%]
echo --------------------------------------------
if exist updates.ipst echo [40;32mUPDATES AVAILABLE[40;37m && set updatestatus=true
if not exist updates.ipst echo [40;31mNO UPDATES AVAILABLE[40;37m && set updatestatus=false
if exist developermodule.insrt echo [40;32mDev UPDATES AVAILABLE[40;37m && set updatestatus=true
if not exist developermodule.insrt echo [40;31mNO Dev UPDATES AVAILABLE[40;37m && set updatestatus=false
echo --------------------------------------------
echo (1) Apply Updates
echo (2) Diagnostics
echo (3) Connect to IP DataBase
if not exist developerfiles.dev echo (4) Search For Developer Module
if exist developerfiles.dev echo (4) Developer Options
echo (5) Wipe Data
echo --------------------------------------------
set /p updatechoice=→ 
if %updatechoice%==1 goto applyupdate
if %updatechoice%==2 goto diagnose
if %updatechoice%==3 goto connect
if %updatechoice%==4 goto developersettings
if %updatechoice%==5 goto deletefiles
goto mainscreen

:developersettings
if not exist developerfiles.dev goto searchfordevmodules
cls
echo (1) Start Command Line
echo (2) GOTO IP Branches
set /p developerchoice=: 
if %developerchoice%==1 goto commandline
if %developerchoice%==2 goto runiproot
goto developerchoice


:applyupdate
if %updatestatus%==true goto continueupdate
if %updatestatus%==false goto noupdates
goto noupdates


:diagnose
cls
echo Check For Missing Files?
set /p choice=(Y/N)
if %choice%==y goto checkfiles
if %choice%==Y goto checkfiles
if %choice%==n goto mainscreen
if %choice%==N goto mainscreen
:checkfiles
cls
echo.
if exist activationkey.ipst echo IP Activation File [[40;32mEXISTS[40;37m]
if not exist activationkey.ipst echo IP Activation File [[40;31mMissing[40;37m]
if exist developerfiles.dev echo Developer Files [[40;32mEXISTS[40;37m
if not exist developerfiles.dev echo Developer Files [[40;31mMissing[40;37m]
if exist recentips.txt echo Recent IP File [[40;32mEXISTS[40;37m
if not exist recentips.txt echo Recent IP File [[40;31mMissing[40;37m]
if exist supportrecipt.txt echo Support Reciept [[40;32mEXISTS[40;37m
if not exist supportrecipt.txt echo Support Reciept [[40;31mMissing[40;37m]
pause>nul
goto mainscreen
:connect
:deletefiles
cls
echo Delete Files? && goto deletefilesconfirm
:choiceconfirmed
set /p choice=(Y/N)
if %choice%==y goto delfiles
if %choice%==Y goto delfiles
if %choice%==n goto mainscreen
if %choice%==N goto mainscreen
:delfiles
del "activationkey.ipst"
del "supportrecipt.txt"
if exist developerfiles.dev del developerfiles.dev
del recentips.txt
goto startscreen

:searchfordevmodules
cls
if exist developermodule.insrt echo Developer Module Recieved, Activate? && goto activatedev
echo Developer Module Has Not Been Found && pause>nul
goto mainscreen
:activatedev
set /p choice=(Y/N)
if %choice%==y goto unboxdevpackage
if %choice%==Y goto unboxdevpackage
if %choice%==n goto mainscreen
if %choice%==N goto mainscreen
goto searchfordevmodules

:searchagain
if %choice%==y goto searchfordevmodules
if %choice%==Y goto searchfordevmodules
if %choice%==n goto mainscreen
if %choice%==N goto mainscreen
goto searchfordevmodules

:unboxdevpackage
cls
set unboxprocess=ACTIVE
echo Unboxing Developer Module Package. [Process: %unboxprocess%]
rename "developermodule.insrt" "developermodule.bat" && start developermodule.bat
timeout 5 >nul
echo Developer Package Has Been Used, Please Install a New Package>developermodule.bat
rename "developermodule.bat" "developermodule.insrt"
echo.
set unboxprocess=FINISHED
echo Unboxing Developer Module Package. [Process: %unboxprocess%]
echo Process Finished! Clean Files?
:cleanfileschoice
set /p choice=(Y/N)
if %choice%==y goto cleanfiles
if %choice%==Y goto cleanfiles
if %choice%==n goto mainscreen
if %choice%==N goto mainscreen
goto cleanfileschoice
:cleanfiles
if exist developermodule.bat del developermodule.bat
if exist developermodule.insrt del developermodule.insrt
echo Files Cleaned!
pause>nul
goto mainscreen

:commandline
if exist developerfiles.dev goto continuecmd
goto devfilesmissing
:continuecmd
cls
mode 95,15
title CommandLine For IPST.
:commandlinestart
echo.
set /p commandlineinput= [40;32mIPST[40;37m/[40;31m%username%[40;32m→[40;37m 
::commands
if %commandlineinput%==help goto helpcommand
if %commandlineinput%==return goto mainscreen
if %commandlineinput%==esc goto mainscreen
if %commandlineinput%==escape goto mainscreen
if %commandlineinput%==exit goto mainscreen
if %commandlineinput%==cls goto continuecmd
if %commandlineinput%==clear goto continuecmd
if %commandlineinput%==clearscreen goto continuecmd
if %commandlineinput%==changesettings goto changesettings
if %commandlineinput%==showip echo %homeipv4% && goto commandlinestart
if %commandlineinput%==showgeolocation echo %geolocation% && goto commandlinestart
if %commandlineinput%==showcountry echo %country% && goto commandlinestart
IF %commandlineinput%==shownetworkorg echo %networkorg% && goto commandlinestart
if %commandlineinput%==showtimezone echo %TIMEZONE% && goto commandlinestart
if %commandlineinput%==setsafeip goto resetsafeip
if %commandlineinput%==whoami goto whoami
if %commandlineinput%==runiproot goto runiproot
if %commandlineinput%==goto goto go_to
if %commandlineinput%==rootapis goto rootapis


:go_to 
set /p goto=GO SOMEWHERE IN THE CODE
if %goto%==%goto% goto %goto%
goto no_goto
:helpcommand
cls
echo Commands
echo.
echo help - brings up command menu
echo return, esc, escape, exit - exits the command line, returns to the main menu
echo cls, clear, clearscreen - clears previous commands
echo changesettings - modifies built in settings that are modifyable using an IDE
echo showip - displays ip address (IPV4)
echo showgeolocation - displays geolocation
echo showcountry - display region
echo shownetworkorg - display the network organization
echo showtimezone - displays timezone 
echo setsafeip - sets a new safe ip
echo whoami - shows the programinformation
echo.
goto commandlinestart


:resetsafeip
set /p safeip=
echo [40;32mSafe Ip Changed To [%safeip%] [40;37m
goto commandlinestart

:changesettings
cls
echo (1)
echo (2)
goto commandlinestart

:whoami
echo.
echo         _.-----._                              ║   IPST. Developed Release[2023] 
echo       .'.-'''''-.'._                           ║   Native user:~~~~~%username%  
echo      //          `\\\                          ║   Native computer:~%computername%
echo     ;;  Internet   ;;'.__.===============,     ║   App version:~~~~~%version%
echo     II  Protocol   II  __                 I    ║   Public Release:~~[Y]
echo     ;;  Search     ;;.'  '==============='     ║   Github:~~~~~~~~~~[%credit%]
echo      \\ Tool      ///                          ║
echo       ':.._____..:'~                           ║
echo         `'-----'`                              ║
pause >nul
goto continuecmd


::since im aboloshing the 2 IP options, im keeping option 2 available only. option 1 and 2 are still accessable throught the command line.
::along with option 1,2 im also adding an option 3,4,5. these options will be available through the command line.
:: creating a free space for option #2 a new function can be added
:runiproot
echo ENTER AN IP [IPV4]
set /p rootip=→
echo.
echo CHOOSE AN OPTION
echo.
echo [40;31m1[40;37m) BRANCH 1 - RELIABLE [[40;32mACTIVE[40;37m]   
echo [40;31m2[40;37m) BRANCH 2  LIMITED USE [[40;32mACTIVE[40;37m]
echo [40;31m3[40;37m) BRANCH 3 - UNTESTED [[40;32mACTIVE[40;37m]
set /p branchoption=
if %branchoption%==1 goto branch1
if %branchoption%==2 goto branch2
if %branchoption%==3 goto branch3

:branch1
curl http://ip-api.com/line/%rootip%?fields=status,message,continent,continentCode,country,countryCode,region,regionName,city,district,zip,lat,lon,timezone,offset,currency,isp,org,as,asname,reverse,mobile,proxy,hosting,query
echo.
goto commandlinestart
:branch2
curl https://ipapi.co/%rootip%/json/
echo.
goto commandlinestart
:branch3
curl https://api.ipapi.is?q=%rootip%
echo.
goto commandlinestart





::errror keys
::error keys starts
:wrongformat1
echo x=msgbox("Wrong IPV Format. This Function Requires IPV4. Please Check Your Format For Writing Errors" ,16, "IP Format Error") >> msgbox.vbs
start msgbox.vbs
timeout 1 >nul
del msgbox.vbs
goto mainscreen

:wrongformat2
echo x=msgbox("Wrong IPV Format. This Function Requires IPV4 or IPV6. Please Check Your Format For Writing Errors" ,16, "IP Format Error") >> msgbox.vbs
start msgbox.vbs
timeout 1 >nul
del msgbox.vbs
goto mainscreen

:badinput
echo x=msgbox("Bad Input Detected. File Not Saved. Please Enter IP Again And Save File" ,16, "Input Error") >> msgbox.vbs
start msgbox.vbs
timeout 1 >nul
del msgbox.vbs
goto mainscreen

:filesaved
echo x=msgbox("File Saved As [ %filename%.txt ]" ,64, "Save Successful") >> msgbox.vbs
start msgbox.vbs
timeout 1 >nul
del msgbox.vbs
goto mainscreen

:iptypenotsupported
echo x=msgbox("Sorry, This IP Type Is Not Supported Or Is Entered Incorrectly. Please Check For Errors In Typing" ,16, "Input Error") >> msgbox.vbs
start msgbox.vbs
timeout 1 >nul
del msgbox.vbs
goto changeip

:ipcannotwork
echo x=msgbox("Sorry [%targetip%] Has Been Saved as a Safe IP and Cannot Be Searched. Please Enter A Different IP or Remove SafeIP" ,16, "IP Safe Error") >> msgbox.vbs
start msgbox.vbs
timeout 1 >nul
del msgbox.vbs
goto mainscreen

:nogeolocation
echo x=msgbox("Sorry The GeoLocation For [%targetip%] Is not Available Or is Not Recorded. Please Note, All Countries Geolocation Have Not Been Uploaded, Future Updates Will Solve This Issue." ,16, "GeoLocation Not Found") >> msgbox.vbs
start msgbox.vbs
timeout 1 >nul
del msgbox.vbs
goto mainscreen

:activationerror
echo x=msgbox("This Software Cannot Be Used Without Activation. Please Use Activation Key Given, Or Purchase An Activation Key" ,16, "Please Activate") >> msgbox.vbs
start msgbox.vbs
timeout 1 >nul
del msgbox.vbs
goto activatesoftware2

:keynotverified
echo x=msgbox("The Activation Key Provided Cannot Be Verified. Please Double Check The Key Entered, Or Check Activation Date Valid" ,16, "Key Not Accessable") >> msgbox.vbs
start msgbox.vbs
timeout 1 >nul
del msgbox.vbs
goto activatekey

:devfilesmissing
echo x=msgbox("This Feature Is Locked And Cannot Be Accessed With This Users Permissions, Please Check Readme.md For Further Assistance" ,16, "Developer Mode Feature Locked") >> msgbox.vbs
start msgbox.vbs
timeout 1 >nul
del msgbox.vbs
goto mainscreen

:deletefilesconfirm
echo x=msgbox("All Files Will Be Deleted, And Customized Data Will Be Lost" ,32, "Confirm") >> msgbox.vbs
start msgbox.vbs
timeout 1 >nul
del msgbox.vbs
goto choiceconfirmed

:noupdates
echo x=msgbox("No Updates Are Available To Download, Check Github or Local Files" ,16, "No Updates Found") >> msgbox.vbs
start msgbox.vbs
timeout 1 >nul
del msgbox.vbs
goto updates

:developerupdatefile
echo x=msgbox("Developer Update File Available!" ,64, "Update File") >> msgbox.vbs
start msgbox.vbs
timeout 1 >nul
del msgbox.vbs
goto mainscreen

:regularupdatefile
echo x=msgbox("Update File Available!" ,64, "Update File") >> msgbox.vbs
start msgbox.vbs
timeout 1 >nul
del msgbox.vbs
goto mainscreen

:no_goto
echo x=msgbox("%goto% Is Not a Part of The Code" ,16, "Goto Error") >> msgbox.vbs
start msgbox.vbs
timeout 1 >nul
del msgbox.vbs
goto commandlinestart
::errorkeysend

:rootapis
if exist developerfiles.dev goto controot
goto devfilesmissing
:controot
echo     ____  ____  ____  ______   ___    ____  _____      
echo    / __ \/ __ \/ __ \/_  __/  /   │  / __ \/  _( )_____
echo   / /_/ / / / / / / / / /    / /│ │ / /_/ // / │// ___/
echo  / _, _/ /_/ / /_/ / / /    / ___ │/ ____// /   (__  ) 
echo /_/ │_│\____/\____/ /_/    /_/  │_/_/   /___/  /____/  
echo.                                                        
echo ----------------------------------------------------------------------------------- 
echo LINKS ARE IN SOURCE CODE
echo ----------------------------------------------------------------------------------- 
echo. 
echo SITE NAME - http://ip-api.com
::echo "http://ip-api.com/?fields=status,message,continent,continentCode,country,countryCode,region,regionName,city,district,zip,lat,lon,timezone,offset,currency,isp,org,as,asname,mobile,proxy,hosting,query"
::echo "http://ip-api.com/line/?fields=status,message,continent,continentCode,country,countryCode,region,regionName,city,district,zip,lat,lon,timezone,offset,currency,isp,org,as,asname,reverse,mobile,proxy,hosting,query"
echo.
echo SITE NAME - IPAPI
::echo "https://ipapi.co/%targetip%/json/"
echo.
echo SITE NAME - API.IPAPI.IS
::echo "https://api.ipapi.is?q=%targetip%"
goto commandlinestart