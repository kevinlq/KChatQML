#include "KStartManager.h"

#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQuickWindow>
#include <QFile>

#include "../KGlobal/KGlobal.h"
#include "KUtil/KFileUtil.h"
#include "../Interface/KInterface.h"

#include "SettingsHelper.h"
#include "KChatHelp.h"

KStartManager::KStartManager(QObject *parent)
    : QObject(parent)
{
}

KStartManager::~KStartManager()
{
}

int KStartManager::start(int &argc, char *argv[])
{
#if (QT_VERSION < QT_VERSION_CHECK(6, 0, 0))
    QGuiApplication::setAttribute(Qt::AA_EnableHighDpiScaling);
    QGuiApplication::setAttribute(Qt::AA_UseHighDpiPixmaps);
#if (QT_VERSION >= QT_VERSION_CHECK(5, 14, 0))
    QGuiApplication::setHighDpiScaleFactorRoundingPolicy(Qt::HighDpiScaleFactorRoundingPolicy::PassThrough);
#endif
#endif
    qputenv("QT_QUICK_CONTROLS_STYLE","Basic");
    QGuiApplication::setOrganizationName("devstone");
    QGuiApplication::setOrganizationDomain("https://kevinlq.github.io");
    QGuiApplication::setApplicationName("KChart");

    auto settingHelp = SettingsHelper::getInstance();
    settingHelp->init(argv);

    bool software = settingHelp->getRender()=="software";
    if(software)
    {
#if (QT_VERSION >= QT_VERSION_CHECK(6, 0, 0))
        QQuickWindow::setGraphicsApi(QSGRendererInterface::Software);
#elif (QT_VERSION >= QT_VERSION_CHECK(5, 14, 0))
        QQuickWindow::setSceneGraphBackend(QSGRendererInterface::Software);
#endif
    }

    QGuiApplication app(argc, argv);
    QCoreApplication::setApplicationName("KChart");
    QCoreApplication::setOrganizationName("KChart");

    registerType();

    if(!logInit()) {
        qCritical() << "log init fail.";
        return 1;
    }

    //! init client setting
    LOG_INFO() << "client init begin.";

    QString qmlRes = "qrc:/KQML/App.qml";
    QString resPrefix = ":/KQML";
    //! TODO local debug use
    if(false)
    {
        qmlRes = QString("file:///%1/src/KQML/App.qml").arg(IDE_SOURCE_PATH);
        QFileInfo fInfo(QUrl(qmlRes).toLocalFile());
        resPrefix = fInfo.absolutePath() + "/";
    }
    else {
        QString strFullResPath = QCoreApplication::applicationDirPath() + "/config/KSkinRes.rcc";
        if (!QResource::registerResource(strFullResPath))
        {
            LOG_ERROR() << "QResource registerResource qml failed! " << strFullResPath;
            return 1;
        }
    }
    settingHelp->setResPrefix(resPrefix);

    const QUrl url(qmlRes);
    if(nullptr == m_pQmlEngine)
    {
        m_pQmlEngine = new(std::nothrow) QQmlApplicationEngine;

        connect(m_pQmlEngine, &QQmlApplicationEngine::quit,
                this, &KStartManager::onExitManager);
        connect(m_pQmlEngine, &QQmlApplicationEngine::warnings,
                this, &KStartManager::onQmlWarning);
        connect(m_pQmlEngine, &QQmlApplicationEngine::objectCreated,
            this, [url, this](QObject *obj, const QUrl &objUrl){
                if (!obj && url == objUrl)
                {
                    onExitManager();
                }
            }, Qt::QueuedConnection);
    }

    m_pQmlEngine->rootContext()->setContextProperty("SettingsHelper", settingHelp);

    m_pQmlEngine->load(qmlRes);

    auto rootObjtcts = m_pQmlEngine->rootObjects();
    if(rootObjtcts.isEmpty())
    {
        LOG_ERROR() << "rootObjects is empty.." << qmlRes;
        onExitManager();
        return -1;
    }

#ifdef Q_OS_LINUX
    auto pMainWindow = qobject_cast<QQuickWindow*>(rootObjtcts.first());
    if(nullptr != pMainWindow)
    {
        pMainWindow->setIcon(":/Resource/logo.ico");
    }
#endif

    LOG_INFO() << "client init end." << qmlRes;

    return app.exec();
}

void KStartManager::onQmlWarning(const QList<QQmlError> &warnings)
{
    for(const auto &w : warnings)
    {
        LOG_WARNING(w.toString());
    }
}

void KStartManager::onExitManager()
{
}

void KStartManager::registerType()
{
    const char *sUrl = "com.kevinlq.kchat";
    int versionMajor = 1;
    int versionMinor = 0;
    KInterface::registerType(sUrl, versionMajor, versionMinor);
    KChatHelp::getInstance()->registerType(sUrl, versionMajor, versionMinor);
}

bool KStartManager::logInit()
{
    const QString format = "[%{time}{yyyy-MM-dd HH:mm:ss.zzz} | %{type:-5}] | thread:%{threadid}| <%{Function}> line:%{line} %{message}\n";

    QString logPath = QString("%1/log").arg(QCoreApplication::applicationDirPath());
    QString logFile = QString("%1/chat.log").arg(logPath);
    if(!KFileUtil::createPath(logPath))
    {
        return false;
    }

    QList<AbstractStringAppender*> appenders;
    appenders << new FileAppender(logFile)
              << new ConsoleAppender();

    for(auto appender : appenders) {
        appender->setFormat(format);
        cuteLogger->registerAppender(appender);
        cuteLogger->registerCategoryAppender("qml", appender);
    }
    return true;
}

