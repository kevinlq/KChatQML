@echo off
echo.
echo 开始时间 %DATE%%TIME%
echo.

title 资源文件加密处理
::设置窗口大小
::mode con cols=70 lines=30
::设置字体和颜色
color 2E

set QML_ResDirectory=KQML

cd %QML_ResDirectory%

echo 当前路径: %~df0


::设置编译后的文件路径
set RCC_Foler=bin
set RCC_FullFoler=%~dp0\%RCC_Foler%
echo 设置当前编译后的路径为:%RCC_Foler%

::设置编译后的资源文件名
set skinName=KSkinRes.rcc
echo 设置编译后的资源文件名称为:%skinName%

echo.
::检测当前编译后资源路径是否存在
if exist %RCC_FullFoler% (
	echo 文件目录 %RCC_FullFoler%已经存在
)else (
	echo 文件目录 %RCC_FullFoler%不存在,正在创建文件夹
	md %RCC_FullFoler%
	if exist %RCC_FullFoler% (
		echo 已经创建 %RCC_FullFoler% 路径
	)else (
		echo 创建文件路径失败,将退出
		goto stop
	)
)

cd %QML_ResDirectory%

set rccfile=%~dp0\qml.qrc
echo qml.qrc 路径: %rccfile%
echo.

echo [Start] 正在生成qrc文件……
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

echo [End] 正在生成qrc文件……
cd ..

echo [Start] Build....%DATE%%TIME%
%~dp0\tool\MinGW\rcc.exe -binary %~dp0\qml.qrc -o %~dp0\bin\%skinName%

copy /y %~dp0\bin\%skinName% %~dp0\..\bin\Win32\MinGW\Release\config
echo.
echo [End] Build....%DATE%%TIME%

echo.
echo 结束时间 %DATE%%TIME%
echo.

:stop
pause