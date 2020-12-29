@echo off
set ORIGINAL=%CD%
:checkPrivileges
NET FILE 1>NUL 2>NUL
if '%errorlevel%' == '0' ( goto gotPrivileges ) else ( goto getPrivileges )
 
:getPrivileges
if '%1'=='ELEV' (echo ELEV & shift /1 & goto gotPrivileges)
 
setlocal DisableDelayedExpansion
set "batchPath=%~0"
setlocal EnableDelayedExpansion
ECHO Set UAC = CreateObject^("Shell.Application"^) > "%temp%\OEgetPrivileges.vbs"
ECHO args = "ELEV " >> "%temp%\OEgetPrivileges.vbs"
ECHO For Each strArg in WScript.Arguments >> "%temp%\OEgetPrivileges.vbs"
ECHO args = args ^& strArg ^& " "  >> "%temp%\OEgetPrivileges.vbs"
ECHO Next >> "%temp%\OEgetPrivileges.vbs"
ECHO UAC.ShellExecute "!batchPath!", args, "", "runas", 1 >> "%temp%\OEgetPrivileges.vbs"
"%SystemRoot%\System32\WScript.exe" "%temp%\OEgetPrivileges.vbs" %*
exit /B
 
:gotPrivileges
cls
set O=\
set /p DIR=Insert the directory you want your YTLOADER to be in(for example D:\Files):
if ""%DIR:~-1%""==""%O%"" set  DIR=%DIR:~0,-1% 
set DIR=%L: =%
cls
cd /D C:\
if NOT EXIST ffmpeg goto continue
echo "Your ffmpeg will be overwritten, you can deny that by exiting this prompt."
pause
:continue
if EXIST ffmpeg rmdir /s C:\ffmpeg\
mkdir ffmpeg
cd /D %DIR%\
if NOT EXIST Youtube-Loader goto further
echo %DIR%
rmdir /s "%DIR%\youtube-loader\"
:further
cd /D %DIR%\
mkdir Youtube-Loader
cd %DIR%\youtube-loader\
mkdir Videos
mkdir Audios
mkdir Media
cd C:\ffmpeg\
cls
echo Installing the first package...
powershell -Command "Start-BitsTransfer -Source "https://dl.dropboxusercontent.com/s/loaomktqxwy6wnq/ddd.zip?dl=0" -Destination "C:\ffmpeg\ddd.zip""
cls
echo Unzipping Data...
powershell -Command "Expand-Archive C:\ffmpeg\ddd.zip -DestinationPath C:\ffmpeg"
cls
cd /D C:\ffmpeg\ 
del C:\ffmpeg\ddd.zip 
set SCRIPT="%TEMP%\%RANDOM%-%RANDOM%-%RANDOM%-%RANDOM%.vbs"


echo Set oWS = WScript.CreateObject("WScript.Shell") >> %SCRIPT%
echo sLinkFile = "%DIR%\youtube-loader\YTMUSIC.lnk" >> %SCRIPT%
echo Set oLink = oWS.CreateShortcut(sLinkFile) >> %SCRIPT%
echo oLink.IconLocation = "C:\ffmpeg\bin\ico.ico" >> %SCRIPT%
echo oLink.TargetPath = "C:\ffmpeg\bin\YTMUSIC.bat" >> %SCRIPT%
echo oLink.Save >> %SCRIPT%

cscript /nologo %SCRIPT%
del %SCRIPT%
set SCRIPT="%TEMP%\%RANDOM%-%RANDOM%-%RANDOM%-%RANDOM%.vbs"


echo Set oWS = WScript.CreateObject("WScript.Shell") >> %SCRIPT%
echo sLinkFile = "%DIR%\youtube-loader\YTVIDEO.lnk" >> %SCRIPT%
echo Set oLink = oWS.CreateShortcut(sLinkFile) >> %SCRIPT%
echo oLink.IconLocation = "C:\ffmpeg\bin\ico.ico" >> %SCRIPT%
echo oLink.TargetPath = "C:\ffmpeg\bin\YTVIDEO.bat" >> %SCRIPT%
echo oLink.Save >> %SCRIPT%

cscript /nologo %SCRIPT%
del %SCRIPT%
set SCRIPT="%TEMP%\%RANDOM%-%RANDOM%-%RANDOM%-%RANDOM%.vbs"


echo Set oWS = WScript.CreateObject("WScript.Shell") >> %SCRIPT%
echo sLinkFile = "%DIR%\youtube-loader\ILOAD.lnk" >> %SCRIPT%
echo Set oLink = oWS.CreateShortcut(sLinkFile) >> %SCRIPT%
echo oLink.IconLocation = "C:\ffmpeg\bin\ico.ico" >> %SCRIPT%
echo oLink.TargetPath = "C:\ffmpeg\bin\ILOAD.bat" >> %SCRIPT%
echo oLink.Save >> %SCRIPT%

cscript /nologo %SCRIPT%
del %SCRIPT%
setx /m Path "%Path%+;C:\ffmpeg\bin"
cd /D C:\ffmpeg\bin\
echo %DIR%> yt-ldirectory.txt
cls
echo Thank you for installing Noqel's Youtube-Loader
pause
