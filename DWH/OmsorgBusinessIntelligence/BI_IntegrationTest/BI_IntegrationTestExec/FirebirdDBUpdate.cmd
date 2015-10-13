REM Update Firebird Database 
TestDBup.exe -old C:\OMSORG\Omsorg.fdb FirebirdUpdates

IF ERRORLEVEL 1 EXIT /B 1