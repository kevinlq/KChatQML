@echo off

set TOP_DIR=%~dp0
set BUILD_OUT=%TOP_DIR%\build
::Qt相关路径
set QT_PATH=D:/Qt/Qt5.15.2/5.15.2

set PATH=%QT_PATH%/5.15.2/mingw81_64/bin;%QT_PATH%/5.15.2/Tools/CMake_64/bin;%QT_PATH%/5.15.2/Tools/mingw810_64/bin;%PATH%

echo "TOP_DIR: %TOP_DIR%"
echo "QT_PATH: %QT_PATH%"
::echo "PATH: %PATH%"

if not exist %BUILD_OUT% md %BUILD_OUT%

cd %BUILD_OUT%

cmake -G "MinGW Makefiles" -DCMAKE_BUILD_TYPE=Release -DCMAKE_MESSAGE_LOG_LEVEL=STATUS -DCMAKE_PREFIX_PATH=D:/KChat/bin ../../

pause