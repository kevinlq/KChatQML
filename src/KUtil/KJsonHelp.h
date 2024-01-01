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
#include "KUtil_global.h"

#include <QObject>
#include <QJsonObject>
#include <QJsonValue>
#include <QVariant>

// JSON 辅助类
class KUTIL_EXPORT KJsonHelp
{
public:
    QJsonObject getJsonObjFromFile(const QString &filePath);
    bool        saveJsonObjToFile(const QJsonObject &jsObj, const QString &filePath);

    QJsonObject getJsonObj(const QByteArray &jsonData);

    bool json2Object(const QJsonObject &jsObj, QObject *object);
    QJsonObject object2Json(const QObject *object) const;

    QByteArray jsValue2String(const QJsonValue &jsValue);

    QVariant fromVariant(const QVariant &variant) const;
    QVariant   toVariant(int typeId, const QJsonValue &value);
};

