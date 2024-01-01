#include "KInterface.h"
#include "KChatItem.h"
#include "Component/KRectangle.h"
#include "Component/KRoundedImage.h"
#include "Component/KSystemTray.h"
#include "KUtil/KJsonHelp.h"

KInterface::KInterface(QObject *parent)
    : QObject{parent}
{

}

void KInterface::registerType(const char *url, int versionMajor, int versionMinor)
{
    qmlRegisterType<KChatItem>(url, versionMajor, versionMinor, "KChatItem");
    qmlRegisterType<KRectangle>(url, versionMajor, versionMinor, "KRectangle");
    qmlRegisterType<KRoundedImage>(url, versionMajor, versionMinor, "KRoundedImage");
    qmlRegisterType<KSystemTray>(url, versionMajor, versionMinor, "KSystemTray");
}

QString KInterface::getContactList(const QString &param)
{
    Q_UNUSED(param);
    return "";
}

