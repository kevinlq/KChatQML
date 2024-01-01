include($$PWD/../../qmake/KWeChatQml.pri)

TEMPLATE    = lib
TARGET      = KUtil$${FILE_POSTFIX}
DESTDIR     = $${IDE_LIBRARY_PATH}
CONFIG      += sharedlib
DEFINES     += KUTIL_LIBRARY

#include($$PWD/../../3rdparty/3rdparty.pri)

HEADERS += \
    KHelper_p.h \
    KJsonHelp.h \
    SettingsHelper.h

SOURCES += \
    KJsonHelp.cpp \
    SettingsHelper.cpp
