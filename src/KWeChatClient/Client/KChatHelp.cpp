#include "KChatHelp.h"

#include <QtQml>

#include "../3rdparty/qsyncable/QSListModel"

KChatHelp::KChatHelp(QObject *parent)
    : QObject(parent)
{
}

KChatHelp *KChatHelp::getInstance()
{
    static KChatHelp _instance;
    return &_instance;
}

void KChatHelp::registerType(const char *url, int versionMajor, int versionMinor)
{
    qmlRegisterUncreatableMetaObject(KChat::staticMetaObject, url, versionMajor, versionMinor, "KChat", "Access to enum & flags only");

    // 3rdparty
    QSyncable::registerQSyncableTypes();
}
