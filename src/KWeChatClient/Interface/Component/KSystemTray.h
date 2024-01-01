/**
 ** This file is part of the KChatApp project.
 ** Copyright kevinlq kevinlq0912@gmail.com.
 ** Contact: http://kevinlq.com
 **
 ** This program is free software: you can redistribute it and/or modify
 ** it under the terms of the GNU Lesser General Public License as
 ** published by the Free Software Foundation, either version 3 of the
 ** License, or (at your option) any later version.
 **
 ** This program is distributed in the hope that it will be useful,
 ** but WITHOUT ANY WARRANTY; without even the implied warranty of
 ** MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 ** GNU Lesser General Public License for more details.
 **
 ** You should have received a copy of the GNU Lesser General Public License
 ** along with this program.  If not, see <http://www.gnu.org/licenses/>.
 **/

#pragma once

#include <QWindow>
#include <QObject>
#include <QAbstractNativeEventFilter>
#include <QSystemTrayIcon>

#include "KUtil/PropertyHelper.h"

class TrayPos;
class KSystemTray : public  QObject , public QAbstractNativeEventFilter
{
    Q_OBJECT
    Q_PROPERTY_AUTO(QString, icon)
    Q_PROPERTY_AUTO(QString, tooltip)
public:
    explicit KSystemTray(QObject *parent = nullptr);
    ~KSystemTray();

    Q_INVOKABLE bool init(QWindow *window);

    //QAbstractNativeEventFilter
    bool nativeEventFilter(const QByteArray &eventType, void *message, qintptr *result) override;

Q_SIGNALS:
    void activated(int reason);

private:
    TrayPos *pTrayPos = nullptr;
};
