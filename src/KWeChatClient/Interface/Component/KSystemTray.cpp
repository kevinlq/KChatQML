#include "KSystemTray.h"
#include <QApplication>

#include "../Client/SettingsHelper.h"


#ifdef Q_OS_WIN
#include <windows.h>
#define WM_TRAYNOTIFY (WM_USER+123)

class TrayPos
{
private:
    POINT				m_ptMouse;
    HANDLE				m_hThread;
    HANDLE				m_hExitEvent;
    bool				m_bTrackMouse;
    CRITICAL_SECTION	m_cs;
public:
    TrayPos();
    virtual ~TrayPos();
    static UINT CALLBACK TrackMousePt(PVOID pvClass);
    void OnMouseMove();
    bool IsMouseHover();

protected:
    virtual void OnMouseHover() = 0;
    virtual void OnMouseLeave() = 0;
public:
    virtual void SetNotifyIconInfo(HWND hwnd, UINT uID, UINT uCallbackMsg) = 0;
};

TrayPos::TrayPos()
{
    UINT	uThreadId;
    m_bTrackMouse = FALSE;
    m_hExitEvent = CreateEvent(NULL, FALSE, FALSE, NULL);
    m_hThread = (HANDLE) _beginthreadex(nullptr, 0, TrayPos::TrackMousePt, this, 0, &uThreadId);
    InitializeCriticalSection(&m_cs);
}

TrayPos::~TrayPos()
{
    if(m_hThread != nullptr)
    {
        SetEvent(m_hExitEvent);
        if(WaitForSingleObject(m_hThread, 5000) == WAIT_TIMEOUT)
        {
            TerminateThread(m_hThread, 0);
        }
        CloseHandle(m_hThread);
        m_hThread = nullptr;
    }

    if(m_hExitEvent != nullptr)
    {
        CloseHandle(m_hExitEvent);
        m_hExitEvent = nullptr;
    }

    DeleteCriticalSection(&m_cs);
}

UINT TrayPos::TrackMousePt(PVOID pvClass)
{
    POINT		ptMouse;
    TrayPos	*pTrayPos = (TrayPos *) pvClass;
    while(WaitForSingleObject(pTrayPos->m_hExitEvent, 100) == WAIT_TIMEOUT)
    {
        if(pTrayPos->m_bTrackMouse == TRUE)
        {
            GetCursorPos(&ptMouse);
            if(ptMouse.x != pTrayPos->m_ptMouse.x || ptMouse.y != pTrayPos->m_ptMouse.y)
            {
                pTrayPos->m_bTrackMouse = FALSE;
                pTrayPos->OnMouseLeave();
            }
        }
    }
    return 0;
}

void TrayPos::OnMouseMove()
{
    EnterCriticalSection(&m_cs);
    GetCursorPos(&m_ptMouse);
    if(m_bTrackMouse == FALSE)
    {
        OnMouseHover();
        m_bTrackMouse = TRUE;
    }
    LeaveCriticalSection(&m_cs);
}

bool TrayPos::IsMouseHover()
{
    return m_bTrackMouse;
}

class MsgTrayPos : public TrayPos
{
private:
    HWND	m_hNotifyWnd;
    UINT	m_uID;
    UINT	m_uCallbackMsg;

public:
    MsgTrayPos(HWND hwnd=NULL, UINT uID=0, UINT uCallbackMsg=0);
    ~MsgTrayPos();
    void SetNotifyIconInfo(HWND hwnd, UINT uID, UINT uCallbackMsg) override;

protected:
    void OnMouseHover() override;
    void OnMouseLeave() override;
};


MsgTrayPos::MsgTrayPos(HWND hwnd, UINT uID, UINT uCallbackMsg)
    : TrayPos()
{
    SetNotifyIconInfo(hwnd, uID, uCallbackMsg);
}

MsgTrayPos::~MsgTrayPos()
{
}

void MsgTrayPos::SetNotifyIconInfo(HWND hwnd, UINT uID, UINT uCallbackMsg)
{
    m_hNotifyWnd = hwnd;
    m_uID = uID;
    m_uCallbackMsg = uCallbackMsg;
}

void MsgTrayPos::OnMouseHover()
{
    if(m_hNotifyWnd != NULL && IsWindow(m_hNotifyWnd))
    {
        PostMessage(m_hNotifyWnd, m_uCallbackMsg, m_uID, WM_MOUSEHOVER);
    }
}

void MsgTrayPos::OnMouseLeave()
{
    if(m_hNotifyWnd != NULL && IsWindow(m_hNotifyWnd))
    {
        PostMessage(m_hNotifyWnd, m_uCallbackMsg, m_uID, WM_MOUSELEAVE);
    }
}
Q_GUI_EXPORT HICON qt_pixmapToWinHICON(const QPixmap &);
#endif

KSystemTray::KSystemTray(QObject *parent)
    : QObject(parent)
{
    qApp->installNativeEventFilter(this);

#ifdef Q_OS_WIN
    pTrayPos = new MsgTrayPos;
#endif
}

KSystemTray::~KSystemTray()
{
    if(nullptr != pTrayPos)
    {
        delete pTrayPos;
        pTrayPos = nullptr;
    }
}

bool KSystemTray::init(QWindow *window)
{
    if(nullptr == window)
    {
        return false;
    }

    auto resPrefix = SettingsHelper::getInstance()->resPrefix();
    auto imagPath = resPrefix + icon();
#ifdef Q_OS_WIN
    NOTIFYICONDATA	nid;
    nid.cbSize = sizeof(nid);
    nid.hIcon = qt_pixmapToWinHICON(imagPath);
    nid.hWnd = HWND(window->winId());
    nid.uCallbackMessage = WM_TRAYNOTIFY;
    nid.uID = 1;
    nid.uFlags |= NIF_MESSAGE | NIF_ICON | NIF_TIP;

    int maxTipLength = 128;
    QString tip = tooltip();
    if (!tip.isNull()) {
        tip = tip.left(maxTipLength - 1) + QChar();
        memcpy(nid.szTip, tip.utf16(), qMin(tip.length() + 1, maxTipLength) * sizeof(wchar_t));
    }

    Shell_NotifyIcon(NIM_ADD, &nid);
    pTrayPos->SetNotifyIconInfo((HWND)window->winId(), 1, WM_TRAYNOTIFY);
#endif

    return true;
}

bool KSystemTray::nativeEventFilter(const QByteArray &eventType, void *message, qintptr *result)
{
#ifdef Q_OS_WIN
    if (eventType == "windows_generic_MSG" || eventType == "windows_dispatcher_MSG")
    {
        MSG * pMsg = reinterpret_cast<MSG *>(message);
        if (pMsg->message == WM_TRAYNOTIFY)
        {
            switch (pMsg->lParam)
            {
            case WM_MOUSEMOVE:
                pTrayPos->OnMouseMove();
                break;
            case WM_MOUSEHOVER:
                qDebug() << "show";
                //m_Menu->show();
                break;
            case WM_MOUSELEAVE:
                qDebug() << "hide";
                //m_Menu->hide();
                break;
            case WM_LBUTTONDBLCLK:
                qDebug() << "l click";
                break;
            case WM_LBUTTONDOWN:
                activated(QSystemTrayIcon::Trigger);
                break;
            case WM_MBUTTONUP:
                activated(QSystemTrayIcon::MiddleClick);
                break;
            case WM_RBUTTONDOWN:
                break;
            case WM_LBUTTONUP:
                break;
            case NIN_BALLOONUSERCLICK:  // 用户单击气泡处理
                break;
            case WM_RBUTTONUP:
            {
                qDebug() << "pos:"  << QCursor::pos();
                *result = 0;
            }
                break;
            }
        }
    }
#endif
    return false;
}

