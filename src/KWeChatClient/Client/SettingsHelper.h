#ifndef SETTINGSHELPER_H
#define SETTINGSHELPER_H

#include <QObject>
#include <QSettings>

class SettingsHelper : public QObject
{
    Q_OBJECT
private:
    explicit SettingsHelper(QObject* parent = nullptr);
public:
    static SettingsHelper *getInstance();
    ~SettingsHelper() override;

    void init(char *argv[]);

    Q_INVOKABLE void saveRender(const QVariant& render){save("render",render);}
    Q_INVOKABLE QVariant getRender(){return get("render");}
    Q_INVOKABLE void saveDarkMode(int darkModel){save("darkMode",darkModel);}
    Q_INVOKABLE QVariant getDarkMode(){return get("darkMode",QVariant(0));}
    Q_INVOKABLE void saveVsync(bool vsync){save("vsync",vsync);}
    Q_INVOKABLE QVariant getVsync(){return get("vsync",QVariant(true));}

    Q_INVOKABLE QString qtVersion();
    Q_INVOKABLE bool isQt6();
    Q_INVOKABLE bool checkQtVersion(int major, int minor, int patch);

    Q_INVOKABLE void setThemeType(const QString &name){ save("theme", name);}
    Q_INVOKABLE QString themeType(const QVariant &def = {}) {return get("theme", def).toString();}

    Q_INVOKABLE void setLanguage(const QString &name){ save("language", name);}
    Q_INVOKABLE QString language(const QVariant &def = {}) {return get("language", def).toString();}

    Q_INVOKABLE QVariant logInfo() const;
    Q_INVOKABLE void logOut(int levle, const QString &msg);

    Q_INVOKABLE QString userCachePath();

    void setResPrefix(const QString &prefix);
    QString resPrefix() const;

private:
    void save(const QString& key,QVariant val);
    QVariant get(const QString& key,QVariant def={});
private:
    QScopedPointer<QSettings> m_settings;
    QString m_resPrefix = "";
};

#endif // SETTINGSHELPER_H
