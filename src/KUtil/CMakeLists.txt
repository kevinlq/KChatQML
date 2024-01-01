cmake_minimum_required(VERSION 3.20)

set(TARGET_NAME KUtil${FILE_POSTFIX})
add_compile_definitions(KUTIL_LIBRARY)

set(CMAKE_AUTOMOC ON)
set(CMAKE_AUTORCC ON)
set(CMAKE_AUTOUIC ON)

if (APP_BUILD_STATIC_LIB)
    set(LIB_TYPE "STATIC")
else()
    set(LIB_TYPE "SHARED")
endif()

find_package(QT NAMES Qt6 Qt5 REQUIRED COMPONENTS Core Gui Widgets)
find_package(Qt${QT_VERSION_MAJOR} REQUIRED COMPONENTS Core Gui Widgets)

# Qt lib include
include_directories(
    ${Qt${QT_VERSION_MAJOR}Core_INCLUDE_DIRS}
    ${Qt${QT_VERSION_MAJOR}Gui_INCLUDE_DIRS}
    ${Qt${QT_VERSION_MAJOR}Widgets_INCLUDE_DIRS}
)

file(GLOB HEADER_FILES ./*.h)
file(GLOB_RECURSE SRC_FILES ./*.cpp)

add_library (${TARGET_NAME} ${LIB_TYPE} ${HEADER_FILES} ${SRC_FILES}
    KFileUtil.h KFileUtil.cpp)
set(LIBRARY_OUTPUT_PATH ${IDE_LIBRARY_PATH})

# Mingw delete lib prefix
if(MINGW)
    set_target_properties(${TARGET_NAME} PROPERTIES PREFIX "")
endif()

target_link_libraries(${TARGET_NAME} PUBLIC
    Qt${QT_VERSION_MAJOR}::Core
    Qt${QT_VERSION_MAJOR}::Gui
    Qt${QT_VERSION_MAJOR}::Widgets
)
