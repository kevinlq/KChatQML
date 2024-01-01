include($$PWD/../../qmake/KWeChatQml.pri)

TEMPLATE = app
QT += core gui widgets qml quick quick-private

TARGET      = KWeChat
DESTDIR     = $${IDE_BIN_PATH}

include($$PWD/Interface/Interface.pri)
INCLUDEPATH += $$PWD/Interface
INCLUDEPATH += $$PWD/../

SOURCES += \
    Client/main.cpp \
    Client/KStartManager.cpp

HEADERS += \
    Client/KStartManager.h

RESOURCES += \
    ../KChatApp.qrc

LIBS += -L$${IDE_LIBRARY_PATH} -lKUtil$${FILE_POSTFIX}

