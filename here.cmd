path = %path%;%WINDIR%\Microsoft.NET\Framework\v4.0.30319\
powershell -ExecutionPolicy Unrestricted -NoExit -Command " &{import-module .\lib\psake\psake.psm1; Invoke-Psake -docs}"