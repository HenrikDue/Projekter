@echo off
ECHO Update Firebird database
call FirebirdDBUpdate.cmd

if ERRORLEVEL 1 GOTO TESTEXIT

ECHO Execute SSIS packages
BI_ExecuteSSISPackages.exe

if ERRORLEVEL 1 GOTO TESTEXIT


GenerateNCompare.exe -generate -compare

if ERRORLEVEL 1 GOTO TESTEXIT
ECHO Success!
EXIT /B 0

:TESTEXIT
ECHO Failure!
EXIT /B 1