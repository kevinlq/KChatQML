cmake_minimum_required(VERSION 3.20)

set(TARGET_NAME KChatApp${FILE_POSTFIX})

set(CMAKE_AUTOMOC ON)
set(CMAKE_AUTORCC ON)
set(CMAKE_AUTOUIC ON)

set(EXECUTABLE_OUTPUT_PATH  ${IDE_BIN_PATH})

set(QML_IMPORT_PATH ${EXECUTABLE_OUTPUT_PATH}/ CACHE STRING "Qt Creator extra QML import paths" FORCE)

message(STATUS "QML_IMPORT_PATH: ${QML_IMPORT_PATH}")

find_package(QT NAMES Qt6 Qt5 REQUIRED COMPONENTS Core Gui Quick Qml Svg Network)
find_package(Qt${QT_VERSION_MAJOR} REQUIRED COMPONENTS Core Gui Quick Qml Svg Network)
include_directories(
    ${Qt${QT_VERSION_MAJOR}Core_INCLUDE_DIRS}
    ${Qt${QT_VERSION_MAJOR}Gui_INCLUDE_DIRS}
    ${Qt${QT_VERSION_MAJOR}Quick_INCLUDE_DIRS}
    ${Qt${QT_VERSION_MAJOR}Qml_INCLUDE_DIRS}
)

file(GLOB CLIENT_HEADERS "./Client/*.h")
file(GLOB CLIENT_SOURCES "./Client/*.cpp")
file(GLOB INTERFACE_SOURCES "./Interface/*.cpp")
file(GLOB INTERFACE_HEADERS "./Interface/*.h")
file(GLOB COMPONENT_SOURCES "./Interface/Component/*.cpp")
file(GLOB COMPONENT_HEADERS "./Interface/Component/*.h")
file(GLOB PRIVATE_SOURCES "./Interface/private/*.cpp")

if(WIN32)
    enable_language("RC")
    set(WIN32_RESOURCES ${CMAKE_CURRENT_SOURCE_DIR}/kchatIcon.rc)
endif()

add_executable(${TARGET_NAME} WIN32
    ${CLIENT_SOURCES}
    ${CLIENT_HEADERS}
    ${INTERFACE_SOURCES}
    ${INTERFACE_HEADERS}
    ${COMPONENT_SOURCES}
    ${COMPONENT_HEADERS}
    ${PRIVATE_SOURCES}
    Interface/Component/KSystemTray.h Interface/Component/KSystemTray.cpp
    ${WIN32_RESOURCES}
)

# target_sources(${TARGET_NAME} PRIVATE
#     ${PROJECT_SOURCE_DIR}/src/KChatApp.qrc
# )
add_custom_target(KAppRes
    SOURCES ${PROJECT_SOURCE_DIR}/src/KChatApp.qrc)

target_include_directories(${TARGET_NAME} PUBLIC
    ${PROJECT_SOURCE_DIR}/src
    ${PROJECT_SOURCE_DIR}/src/KUtil
    ${PROJECT_SOURCE_DIR}/src/KWeChatClient
    ${PROJECT_SOURCE_DIR}/src/KWeChatClient/Interface
)

target_link_libraries(${TARGET_NAME} PRIVATE
    Qt${QT_VERSION_MAJOR}::Quick
    Qt${QT_VERSION_MAJOR}::QuickPrivate
)
target_link_libraries(${TARGET_NAME} PUBLIC
    Qt${QT_VERSION_MAJOR}::Core
    Qt${QT_VERSION_MAJOR}::Gui
    Qt${QT_VERSION_MAJOR}::Svg
    Qt${QT_VERSION_MAJOR}::Network
    KUtil${FILE_POSTFIX}
    CuteLogger
    QSyncable
)
