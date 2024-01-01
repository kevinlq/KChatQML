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
#include <QObject>
#include <QtQml>

class QQmlApplicationEngine;
class KStartManager : public QObject
{
    Q_OBJECT
public:
    explicit KStartManager(QObject *parent = nullptr);
    ~KStartManager();

    //! start app
    int start(int &argc, char *argv[]);

private Q_SLOTS:
    void onQmlWarning(const QList<QQmlError> &warnings);
    void onExitManager();

private:
    void registerType();
    bool logInit();
private:
    QQmlApplicationEngine *m_pQmlEngine = nullptr;
};

