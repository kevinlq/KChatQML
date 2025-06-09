
rem @echo off

set filepath=%1
set delstr=%cd%
set outfile=%2
set resPath=%3

echo %1

:loop
if not "%delstr%"=="" (
set delstr=%delstr:~1%
set filepath=%filepath:~1%
goto loop
)

set filepath=%filepath:~1%
set filepath=%filepath:\=/%
echo ^<file^>%resPath%/%filepath%^</file^> >> %2






