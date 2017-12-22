@echo off

rem bd.cmd
rem Big Delete = del (erase) + rd (rmdir)

rem Purpose: Recursively deletes all and removes the directory tree
rem
rem Arguments: the directories you want to delete. If an argument is not a
rem directory, it is treated as a file and is simply deleted using del. Passing
rem the wildcard character as an argument will only work for files, not
rem directories.

rem Warning: This permanently deletes files, bypassing the recycle bin

rem Credit: stolen from several stack overflow answers

rem Just a reference for what all these tilda things mean:
rem percent asterisk is %*
rem echo percent tilda d p 0 is %~dp0
rem echo percent 0 is %0
rem echo percent tilda s 0 is %~s0
rem echo percent tilda n 0 is %~n0
rem echo percent tilda d p x 0 is %~dpx0
rem echo percent tilda p x 0 is %~px0
rem echo percent tilda s 0 is %~s0
rem echo percent tilda d p n x 0 is %~dpnx0

rem A test to see if this script can take both directories and files: It can if
rem they are all named. If a wildcard is passed in, only the file paths will be
rem expanded and the directories are ignored
rem
rem for %%i in (%*) do (
rem     echo %%i
rem     if exist %%~si\ ( 
rem         echo %%~si is a directory
rem     ) else (
rem         echo %%~si is a file
rem     )
rem )
rem goto :EOF

set startTime=%time%

rem delete all files recursively and then delete directory tree:
for %%i in (%*) do (
    if exist %%~si\ ( 
        echo Deleting directory %%~si
        del /s /q /f %%i > nul
        rd /s /q %%i
    ) else (
        if exist %%~si (
            echo Deleting file %%~si
            del /q /f %%i > nul
        ) else (
            echo %%~si doesn't exist. Skipping...
        )
        
    )
)

set endTime=%time%
echo Start Time: %startTime%
echo Finished Time: %endTime%

set end=%time%
set options="tokens=1-4 delims=:.,"
for /f %options% %%a in ("%startTime%") do set start_h=%%a&set /a start_m=100%%b %% 100&set /a start_s=100%%c %% 100&set /a start_ms=100%%d %% 100
for /f %options% %%a in ("%endTime%") do set end_h=%%a&set /a end_m=100%%b %% 100&set /a end_s=100%%c %% 100&set /a end_ms=100%%d %% 100

set /a hours=%end_h%-%start_h%
set /a mins=%end_m%-%start_m%
set /a secs=%end_s%-%start_s%
set /a ms=%end_ms%-%start_ms%
if %ms% lss 0 set /a secs = %secs% - 1 & set /a ms = 100%ms%
if %secs% lss 0 set /a mins = %mins% - 1 & set /a secs = 60%secs%
if %mins% lss 0 set /a hours = %hours% - 1 & set /a mins = 60%mins%
if %hours% lss 0 set /a hours = 24%hours%
if 1%ms% lss 100 set ms=0%ms%

set /a totalsecs = %hours%*3600 + %mins%*60 + %secs% 
echo Operation took %hours%:%mins%:%secs%.%ms% (%totalsecs%.%ms%s total)
