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

if "%op%" equ "1" (goto:op1)
if "%op%" equ "2" (goto:op2)
if "%op%" equ "3" (goto:op3)
if "%op%" equ "4" (goto:op4)
if "%op%" equ "5" (goto:op5)
if "%op%" equ "6" (goto:op6)
if "%op%" equ "7" (goto:op7)
if "%op%" equ "0" (goto:exit)

:op1
echo Delete WD Protection History 
cd C:\ProgramData\Microsoft\Windows Defender\Scans\History\Service
del /S /Q *.* 
pause
goto:start

:op2
echo Software Update 
winget upgrade
winget upgrade -h --all
pause
goto:start

:op3
echo Clear PageFile Cache 
echo After This Restart your computer to make effect...
reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management" /v ClearPageFileAtShutdown /t REG_DWORD /d 1
pause
goto:start

:op4
echo Reset PageFile Cache to Default 
echo After This Restart your computer to make effect...
reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management" /v ClearPageFileAtShutdown /t REG_DWORD /d 0
pause
goto:start

:op5
echo Disk Repair and Clean Temp Files 
echo Sometimes a fix it s all we need!
echo chkdsk 
sfc /scannow
dism /online /cleanup-image /checkhealth 
dism /online /cleanup-image /scanhealth 
dism /online /cleanup-image /restorehealth 
pause
goto:start


:op6
echo Clean Temp Files
Del /S /F /Q %temp%
Del /S /F /Q %Windir%\Temp
pause
goto:start

:op7
echo About 
echo This is a small project done with intention to automate some tasks to help user during is work.
echo +-------------------------------------+
echo + Made by https://github.com/Huggos25 +
echo +-------------------------------------+
pause
goto:start


:exit
exit
