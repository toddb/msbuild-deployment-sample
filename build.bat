@echo off
:: 
:: I find it incredibly useful to run batch files from within visual studio environment ,If you are like me ,here is how you do it
:: All you have to do is, setup command prompt in external tools with following option
:: Title :RunTasks
:: Command c:\windows\System32\cmd.exe
:: Arguments: /k $(ItemPath)
:: Initial directory: $(SolutionDir)
:: Check Use Output window
:: 
:: Once you setup this option,assuming that you have a batch file under your project.
:: Click on batch file,then tools->RunTasks

set propfile=%USERPROFILE%\web.build.rsp

IF "%1" == "" GOTO start
set propfile=%1

:start
if not exist "%propfile%" echo. > "%propfile%"

%WINDIR%\Microsoft.NET\Framework\v3.5\msbuild.exe build.proj @"%propfile%" /t:Package /v:d /fl

echo ************************************************************************
echo *                                                                      *
echo * Update %USERPROFILE%\web.build.rsp               
echo * Or, override on command line:                                        *
echo *                                                                      *
echo ************************************************************************
