@ECHO off

REM Install .NET 3.5
reg query "HKLM\Software\Microsoft\NET Framework Setup\NDP\v3.5" /v SP | find "0x1" >NUL
IF %ERRORLEVEL% == 0 GOTO havenet35
Dism /Online /Enable-Feature /FeatureName:NetFx3 /NoRestart

REM Trigger Windows Update
:havenet35
wuauclt /DetectNow
wuauclt /UpdateNow

REM Install Chocolatey
C:
IF EXIST C:\ProgramData\chocolatey GOTO :havechoco
powershell -NoProfile -ExecutionPolicy unrestricted -Command "iex ((new-object net.webclient).DownloadString('https://chocolatey.org/install.ps1'))" && SET PATH=%PATH%;%ALLUSERSPROFILE%\chocolatey\bin

REM Install stuff with Chocolatey
:havechoco
choco install Atom
choco install firefox
choco install githubforwindows
choco install keepassx
choco install owncloud-client
choco install Pencil
choco install steam

REM Keep the window open for scrollback inspection
PAUSE
