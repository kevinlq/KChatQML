cmake_minimum_required(VERSION 3.20)

#--------------------------------------------
# Project setting
#--------------------------------------------
include(cmake/messagecolor.cmake)
include(cmake/utils.cmake)
KCHAT_APP_EXTRACT_VERSION()

set(IDE_APP_NAME KChatApp)
project(${IDE_APP_NAME} VERSION ${KCHAT_APP_VERSION} LANGUAGES CXX)

option(BUILD_TESTS "Build with tests" OFF)

#--------------------------------------------
# Set default build to debug
#--------------------------------------------
if(NOT CMAKE_BUILD_TYPE)
    set(CMAKE_BUILD_TYPE "Debug" CACHE STRING "Choose Release or Debug" FORCE)
endif()

#--------------------------------------------
# Set compilation options
#--------------------------------------------
message(INFO "--------------------------------")
include(cmake/toolchain_options.cmake)
include(cmake/load_3rdparty.cmake)


if (CMAKE_BUILD_TYPE MATCHES Debug)
    set(FILE_POSTFIX "d")
    set(DIR_COMPILEMODE "Debug")
else ()
    set(FILE_POSTFIX "")
    set(DIR_COMPILEMODE "Release")
endif ()

if (WIN32)
    set(DIR_PLATFORM "win32")
    set(DIR_COMPILER "MinGW")
    if (MSVC)
        set(DIR_COMPILER "MSVC")
    endif()
elseif (UNIX)
    set(DIR_PLATFORM "Linux")
    set(DIR_COMPILER "GCC64")
endif ()


if(NOT DIR_PLATFORM)
    set(DIR_PLATFORM win32)
endif()

if(NOT YOUR_TARGET_ARCH)
    set(YOUR_TARGET_ARCH x86-64)
endif()

set(IDE_SOURCE_PATH ${CMAKE_CURRENT_LIST_DIR})
set(IDE_APP_PATH ${IDE_SOURCE_PATH}/bin)
set(APP_PREFIX ${IDE_APP_PATH}/${DIR_PLATFORM}/${DIR_COMPILER}/${DIR_COMPILEMODE})
set(IDE_BIN_PATH ${APP_PREFIX})
set(IDE_LIBRARY_PATH ${APP_PREFIX})
set(IDE_PLUGIN_PATH ${APP_PREFIX}/plugins)
set(IDE_DOC_PATH ${APP_PREFIX}/share/doc)
set(IDE_DATA_PATH ${APP_PREFIX}/share/${IDE_APP_NAME})
set(CMAKE_INSTALL_PREFIX ${IDE_SOURCE_PATH}/install/${IDE_APP_NAME})

#set(CMAKE_ARCHIVE_OUTPUT_DIRECTORY ${IDE_BIN_PATH})
#set(CMAKE_LIBRARY_OUTPUT_DIRECTORY ${IDE_LIBRARY_PATH})
#set(CMAKE_RUNTIME_OUTPUT_DIRECTORY ${IDE_BIN_PATH})
#set(CMAKE_PDB_OUTPUT_DIRECTORY ${IDE_BIN_PATH})

string(CONCAT IDE_SOURCE_PATH_DEF "IDE_SOURCE_PATH=\"" ${IDE_SOURCE_PATH} "\"")
add_compile_definitions(${IDE_SOURCE_PATH_DEF})

message(STATUS "Your target os : ${DIR_PLATFORM}")
message(STATUS "Your target arch : ${YOUR_TARGET_ARCH}")
message(STATUS "Build type: " ${CMAKE_BUILD_TYPE})
message(STATUS "Build file postfix :${FILE_POSTFIX}")
message(STATUS "IDE_LIBRARY_PATH:       ${IDE_LIBRARY_PATH}")
message(STATUS "IDE_PLUGIN_PATH:        ${IDE_PLUGIN_PATH}")
message(STATUS "IDE_DATA_PATH:          ${IDE_DATA_PATH}")
message(STATUS "IDE_DOC_PATH:           ${IDE_DOC_PATH}")
message(STATUS "IDE_BIN_PATH:           ${IDE_BIN_PATH}")
message(INFO "--------------------------------")
message(STATUS "Build KChatApp: ${KCHAT_APP_VERSION}")
message(STATUS "Build with tests: ${BUILD_TESTS}")

#--------------------------------------------
# Build 3rdparty
#--------------------------------------------
message(INFO "--------------------------------")


set(CUTELOGGER_BUILD_STATIC_LIB OFF)
add_subdirectory(./3rdparty/CuteLogger)
add_subdirectory(./3rdparty/qsyncable)

# Build application
#--------------------------------------------
message(INFO "--------------------------------")
add_subdirectory(src)

if(BUILD_TESTS)
    message(INFO "--------------------------------")
    add_subdirectory(tests)
endif()


