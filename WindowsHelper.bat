:start
@echo off & cls
color d
echo +-----------------------------------------+
echo +               Main Menu                 +
echo +-----------------------------------------+
echo + 1 - Delete WD Protection History        +
echo + 2 - Search for Software Need Update     +
echo + 3 - Clear PageFile Cache                + 
echo + 4 - Reset PageFile Cache to Default     +
echo + 5 - Disk Repair and Clean Temp Files    +
echo + 6 - About                               +
echo + 0 - EXIT                                +
echo +-----------------------------------------+
set /p op= Insert an Option:

if "%op%" equ "1" (goto:op1)
if "%op%" equ "2" (goto:op2)
if "%op%" equ "3" (goto:op3)
if "%op%" equ "4" (goto:op4)
if "%op%" equ "5" (goto:op5)
if "%op%" equ "6" (goto:op6)
if "%op%" equ "0" (goto:exit)

:op1
echo
echo Delete WD Protection History 
echo 
cd C:\ProgramData\Microsoft\Windows Defender\Scans\History\Service
del /S /Q *.* 
pause
goto:start

:op2
echo
echo Software Update 
echo 
winget upgrade
winget upgrade -h --all
pause
goto:start

:op3
echo
echo Clear PageFile Cache 
echo
echo After This Restart your computer to make effect...
reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management" /v ClearPageFileAtShutdown /t REG_DWORD /d 1
pause
goto:start

:op4
echo
echo Reset PageFile Cache to Default 
echo
echo After This Restart your computer to make effect...
reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management" /v ClearPageFileAtShutdown /t REG_DWORD /d 0
pause
goto:start

:op5
echo 
echo Disk Repair and Clean Temp Files 
echo
echo Sometimes a fix it s all we need!
echo chkdsk 
sfc /scannow
echo dism /online /cleanup-image /checkhealth 
echo dism /online /cleanup-image /scanhealth 
echo dism /online /cleanup-image /restorehealth 
Del /S /F /Q %temp%
Del /S /F /Q %Windir%\Temp
pause
goto:start

:op6
echo
echo About 
echo
echo This is a small project done with intention to automate some tasks to help user during is work.
echo
echo +-------------------------------------+
echo + Made by https://github.com/Huggos25 +
echo +-------------------------------------+
pause
goto:start


:exit
exit