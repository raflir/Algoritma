@echo off
SET THEFILE=e:\datama~1\tugas\alpro\tugas_~2\tugas_~1.exe
echo Linking %THEFILE%
c:\dev-pas\bin\ldw.exe  E:\DATAMA~1\Tugas\Alpro\TUGAS_~2\rsrc.o -s   -b base.$$$ -o e:\datama~1\tugas\alpro\tugas_~2\tugas_~1.exe link.res
if errorlevel 1 goto linkend
goto end
:asmend
echo An error occured while assembling %THEFILE%
goto end
:linkend
echo An error occured while linking %THEFILE%
:end
