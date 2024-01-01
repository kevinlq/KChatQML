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

// 3rdparty
#include <Logger.h>
#include <ConsoleAppender.h>
#include <FileAppender.h>

namespace KChat {
Q_NAMESPACE
enum KLogLevel {
    Trace   = Logger::Trace,
    Debug   = Logger::Debug,
    Info    = Logger::Info,
    Warning = Logger::Warning,
    Error   = Logger::Error,
    Fatal   = Logger::Fatal
};
Q_ENUMS(KLogLevel);
}

class KChatHelp: public QObject
{
    Q_OBJECT
    KChatHelp(QObject *parent = nullptr);
public:
    static KChatHelp* getInstance();
    void registerType(const char *url, int versionMajor, int versionMinor);
};




