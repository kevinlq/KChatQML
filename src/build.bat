@echo off
echo.
echo ��ʼʱ�� %DATE%%TIME%
echo.

title ��Դ�ļ����ܴ���
::���ô��ڴ�С
::mode con cols=70 lines=30
::�����������ɫ
color 2E

set QML_ResDirectory=KQML

cd %QML_ResDirectory%

echo ��ǰ·��: %~df0


::���ñ������ļ�·��
set RCC_Foler=bin
set RCC_FullFoler=%~dp0\%RCC_Foler%
echo ���õ�ǰ������·��Ϊ:%RCC_Foler%

::���ñ�������Դ�ļ���
set skinName=KSkinRes.rcc
echo ���ñ�������Դ�ļ�����Ϊ:%skinName%

echo.
::��⵱ǰ�������Դ·���Ƿ����
if exist %RCC_FullFoler% (
	echo �ļ�Ŀ¼ %RCC_FullFoler%�Ѿ�����
)else (
	echo �ļ�Ŀ¼ %RCC_FullFoler%������,���ڴ����ļ���
	md %RCC_FullFoler%
	if exist %RCC_FullFoler% (
		echo �Ѿ����� %RCC_FullFoler% ·��
	)else (
		echo �����ļ�·��ʧ��,���˳�
		goto stop
	)
)

cd %QML_ResDirectory%

set rccfile=%~dp0\qml.qrc
echo qml.qrc ·��: %rccfile%
echo.

echo [Start] ��������qrc�ļ�����
echo ^<RCC^> > %rccfile%
echo ^<qresource prefix^="/"^> >> %rccfile%
for /R %%i in (*.qml) do call ../addfile.bat %%i %rccfile% %QML_ResDirectory% 
for /R %%i in (*.js) do call ../addfile.bat %%i %rccfile% %QML_ResDirectory% 
for /R %%i in (*.png) do call ../addfile.bat %%i %rccfile% %QML_ResDirectory% 
for /R %%i in (*.jpg) do call ../addfile.bat %%i %rccfile% %QML_ResDirectory% 
for /R %%i in (*.gif) do call ../addfile.bat %%i %rccfile%  %QML_ResDirectory%
for /R %%i in (*.svg) do call ../addfile.bat %%i %rccfile%  %QML_ResDirectory%
for /R %%i in (*qmldir) do call ../addfile.bat %%i %rccfile%  %QML_ResDirectory%

echo ^</qresource^> >> %rccfile%
echo ^</RCC^> >> %rccfile%

echo [End] ��������qrc�ļ�����
cd ..

echo [Start] Build....%DATE%%TIME%
%~dp0\tool\MinGW\rcc.exe -binary %~dp0\qml.qrc -o %~dp0\bin\%skinName%

copy /y %~dp0\bin\%skinName% %~dp0\..\bin\Win32\MinGW\Release\config
echo.
echo [End] Build....%DATE%%TIME%

echo.
echo ����ʱ�� %DATE%%TIME%
echo.

:stop
pause