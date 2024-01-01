#include "SettingsHelper.h"

#include <QDataStream>
#include <QStandardPaths>
#include <QScopedPointer>
#include <QFileInfo>
#include <QCoreApplication>
#include <QDir>
#include <QMetaEnum>

#include "KChatHelp.h"

QString appConfigPath()
{
    return QStandardPaths::writableLocation(QStandardPaths::DocumentsLocation);
}

SettingsHelper::SettingsHelper(QObject *parent) : QObject(parent)
{
}

SettingsHelper* SettingsHelper::getInstance()
{
    static SettingsHelper _instance;
    return &_instance;
}

SettingsHelper::~SettingsHelper() = default;

void SettingsHelper::save(const QString& key,QVariant val)
{
    QByteArray data = {};
    QDataStream stream(&data, QIODevice::WriteOnly);
    stream.setVersion(QDataStream::Qt_5_6);
    stream << val;
    m_settings->setValue(key, data);
}

QVariant SettingsHelper::get(const QString& key,QVariant def){
    const QByteArray data = m_settings->value(key).toByteArray();
    if (data.isEmpty()) {
        return def;
    }
    QDataStream stream(data);
    stream.setVersion(QDataStream::Qt_5_6);
    QVariant val;
    stream >> val;
    return val;
}

void SettingsHelper::init(char *argv[]){
    auto applicationPath = QString::fromStdString(argv[0]);
    const QFileInfo fileInfo(applicationPath);
    const QString iniFileName = fileInfo.completeBaseName() + ".ini";
    const QString iniFilePath = QStandardPaths::writableLocation(QStandardPaths::AppLocalDataLocation) + "/" + iniFileName;
    m_settings.reset(new QSettings(iniFilePath, QSettings::IniFormat));
}

QString SettingsHelper::qtVersion()
{
        return QT_VERSION_STR;
}

bool SettingsHelper::isQt6()
{
    return QT_VERSION >= QT_VERSION_CHECK(6, 0, 0);
}

bool SettingsHelper::checkQtVersion(int major, int minor, int patch)
{
    return QT_VERSION >= QT_VERSION_CHECK(major, minor, patch);
}

QVariant SettingsHelper::logInfo() const
{
    QVariantMap levelInfo = {};
    const QMetaObject &mo = KChat::staticMetaObject;
    int index = mo.indexOfEnumerator("KLogLevel");
    QMetaEnum metaEnum = mo.enumerator(index);
    auto count = metaEnum.keyCount();
    for(auto i = 0; i < count; i++) {
        levelInfo.insert(metaEnum.key(i), metaEnum.value(i));
    }

    return levelInfo;
}

void SettingsHelper::logOut(int levle, const QString &msg)
{
    switch (levle) {
    case KChat::Trace:      LOG_TRACE(msg);      break;
    case KChat::Debug:      LOG_DEBUG(msg);     break;
    case KChat::Info:       LOG_INFO(msg);      break;
    case KChat::Warning:    LOG_WARNING(msg);   break;
    case KChat::Error:      LOG_ERROR(msg);     break;
    case KChat::Fatal:      LOG_FATAL(msg);     break;
    default:
        break;
    }
}

QString SettingsHelper::userCachePath()
{
    return appConfigPath() + "/";
}

void SettingsHelper::setResPrefix(const QString &prefix)
{
    m_resPrefix = prefix;
}

QString SettingsHelper::resPrefix() const
{
    return m_resPrefix;
}
