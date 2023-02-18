::This Startup of the code force the program open as admin
@echo off 
if "%PROCESSOR_ARCHITECTURE%"=="x86" if not "%PROCESSOR_ARCHITEW6432%"=="" goto :UAC_check

:UAC_check
net session >nul 2>&1
if %errorlevel% == 0 goto :UAC_privileged

echo Set UAC = CreateObject^("Shell.Application"^) > "%temp%\getadmin.vbs"
echo UAC.ShellExecute "%~s0", "", "", "runas", 1 >> "%temp%\getadmin.vbs"
"%temp%\getadmin.vbs"
exit /B
:UAC_privileged

::After pass the request admin show a menu to choose an option
:start
@echo off & cls
color d
echo For best experience recommend using it as admin
echo +-----------------------------------------+
echo +               Main Menu                 +
echo +-----------------------------------------+
echo + 1 - Delete WD Protection History        +
echo + 2 - Search for Software Need Update     +
echo + 3 - Clear PageFile Cache                + 
echo + 4 - Reset PageFile Cache to Default     +
echo + 5 - Disk Repair                         + 
echo + 6 - Clean Temp Files                    +
echo + 7 - About                               +
echo + 0 - EXIT                                +
echo +-----------------------------------------+
set /p op= Insert an Option:

::if stament that the "op" value is equal a function
if "%op%" equ "1" (goto:op1)
if "%op%" equ "2" (goto:op2)
if "%op%" equ "3" (goto:op3)
if "%op%" equ "4" (goto:op4)
if "%op%" equ "5" (goto:op5)
if "%op%" equ "6" (goto:op6)
if "%op%" equ "7" (goto:op7)
if "%op%" equ "0" (goto:exit)

:: This code goes to folder where all protection history of WD are saved and delete them,
:: it s helpfull when it s full or the WD is with some bug
:op1
cls
echo Delete WD Protection History 
cd C:\ProgramData\Microsoft\Windows Defender\Scans\History\Service
del /S /Q *.* 
pause
goto:start

::This code search for update in softwares of the system and upgrade all 
:op2
cls
echo Software Update 
winget upgrade
winget upgrade -h --all
pause
goto:start

::This code goes to regedit and change value of a "dword" called "ClearPageFileAtShutdown" to 1 
::which is to when user turn off the computer it clear the cache saved
:op3
cls
echo Clear PageFile Cache 
echo After This Restart your computer to make effect...
reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management" /v ClearPageFileAtShutdown /t REG_DWORD /d 1
pause
goto:start

::This code is the reverse of the code above make the "dword" called "ClearPageFileAtShutdown" to 0
::return the value to 0 is important cause we don t need to clear this cache all time 
::just when we notice a amount of space from C: disk get used to this
:op4
cls
echo Reset PageFile Cache to Default 
echo After This Restart your computer to make effect...
reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management" /v ClearPageFileAtShutdown /t REG_DWORD /d 0
pause
goto:start

::This code works to repair disk from corrupted files and etc...
:op5
cls
echo Disk Repair 
echo Sometimes a fix it s all we need!
chkdsk 
sfc /scannow
dism /online /cleanup-image /checkhealth 
dism /online /cleanup-image /scanhealth 
dism /online /cleanup-image /restorehealth 
pause
goto:start

::This code works to delete temp files who occupy space in disk C:
:op6
cls
echo Clean Temp Files
Del /S /F /Q %temp%
Del /S /F /Q %Windir%\Temp
Del /S /F /Q C:\Windows\Prefetch
pause
goto:start

:op7
cls
echo About 
echo This is a small project done with intention to automate some tasks to help user during is work.
echo +-------------------------------------+
echo + Made by https://github.com/Huggos25 +
echo +-------------------------------------+
pause
goto:start


:exit
exit
