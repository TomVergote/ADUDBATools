@echo off

REM -- =============================================
REM -- Author: Bjorn Mistiaen
REM -- Create date: 2018-04-06
REM -- Run AX Client as another user than the user with which you're logged in.
REM -- =============================================


REM === UserName ===
REM -- Provide the windows username for which you wish to run the AX client 
REM -- Example: 
REM -- set aduUserName=Adu01
REM --
set aduUserName=


REM === AX Client ===
REM -- Provide the paths without a trailing backslash (\)
REM -- Example:
REM -- set aduClientPath=C:\Program Files (x86)\Microsoft Dynamics AX\60\Client\Bin
REM -- set axcPath=\\GU01SQL1601\AxConfigs\X64
REM --
set aduClientPath=
set axcPath=


REM === ACX File ===
REM -- Example:
REM -- set axcName=AX2012R3_BRU_DEV.axc
REM -- 
set axcName=



REM === Check inputs ===
REM -- Do not modify
REM --
IF NOT DEFINED aduUserName (ECHO ERROR: aduUserName is not defined. & SET hasError=Yes)
IF NOT DEFINED aduClientPath (ECHO ERROR: aduClientPath is not defined. & SET hasError=Yes)
IF NOT DEFINED axcPath (ECHO ERROR: axcPath is not defined. & SET hasError=Yes)
IF NOT DEFINED axcName (ECHO ERROR: axcName is not defined. & SET hasError=Yes)
IF DEFINED hasError (PAUSE & GOTO END)


REM === Compose variables ===
REM -- Do not modify
REM --
set aduUser=%USERDOMAIN%\%aduUserName%
set aduClient=%aduClientPath%\Ax32.exe
set aduAxc=%axcPath%\%axcName%


REM === Start AX client ===
REM -- Do not modify
REM --
runas /user:%aduUser% "%aduClient% %aduAxc%"


:END
