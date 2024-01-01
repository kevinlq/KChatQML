#include "KJsonHelp.h"
#include "KHelper_p.h"
#include "../KGlobal/KGlobal.h"

#include <QFile>
#include <QDir>
#include <QtDebug>
#include <QJsonParseError>

QJsonObject KJsonHelp::getJsonObjFromFile(const QString &filePath)
{
    QFile file(filePath);
    if (!file.open(QIODevice::ReadOnly | QIODevice::Text))
    {
        qCWarning(lcKWeChartUtil) << "open file fail." << file.errorString()
                   << "file:" << filePath;
        return QJsonObject();
    }

    QByteArray baContent = file.readAll();
    file.close();

    return getJsonObj(baContent);
}

bool KJsonHelp::saveJsonObjToFile(const QJsonObject &jsObj, const QString &filePath)
{
    QFile file(filePath);
    QString path = QFileInfo(filePath).absolutePath();
    QDir dir(path);
    if(!dir.exists())
    {
        dir.mkpath(path);
    }

    if (!file.open(QIODevice::WriteOnly | QIODevice::Text))
    {
        qCWarning(lcKWeChartUtil) << "open file fail." << file.errorString()
                   << "file:" << filePath;
        return false;
    }

    QTextStream out(&file);
#if (QT_VERSION >= QT_VERSION_CHECK(6,0,0))
    out.setEncoding(QStringConverter::Utf8);
#else
    out.setCodec("UTF-8");
#endif
    out << KJsonHelp::jsValue2String(jsObj);

    file.close();

    return true;
}

QJsonObject KJsonHelp::getJsonObj(const QByteArray &jsonData)
{
    QJsonObject jsObj;

    QJsonParseError error;
    QJsonDocument jsDoc = QJsonDocument::fromJson(jsonData, &error);
    if (error.error != QJsonParseError::NoError)
    {
        qCWarning(lcKWeChartUtil) << "json parse error." << error.errorString()
                   << " strJson:" << QString(jsonData);
        return jsObj;
    }
    return jsDoc.object();
}

bool KJsonHelp::json2Object(const QJsonObject &jsObj, QObject *object)
{
    if (jsObj.isEmpty() || nullptr == object)
    {
        return false;
    }

    QStringList list;
    const QMetaObject *pMetaObj = object->metaObject();
    for(int i = 0; i < pMetaObj->propertyCount(); i++)
    {
        list << pMetaObj->property(i).name();
    }
    QStringList jsonKeys = jsObj.keys();
    foreach(const QString &proName ,list)
    {
        if(!jsonKeys.contains(proName) || jsObj.value(proName).isNull())
        {
            continue;
        }
        auto v = jsObj.value(proName);
        auto objV = object->property(proName.toLocal8Bit());
        object->setProperty(proName.toLocal8Bit().data(), toVariant(objV.userType(), v));
    }

    return true;
}

QJsonObject KJsonHelp::object2Json(const QObject *object) const
{
    QJsonObject jsObj;
    if(nullptr == object)
    {
        return jsObj;
    }

    const QMetaObject *pMetaObj = object->metaObject();
    for(int i = 0; i < pMetaObj->propertyCount(); i++)
    {
        auto proName = pMetaObj->property(i).name();

        QVariant v = object->property(proName);
        QJsonValue value = fromVariant(v).toJsonValue();
        jsObj.insert(proName, value);
    }

    if(jsObj.contains("objectName"))
    {
        jsObj.remove("objectName");
    }

    return jsObj;
}

QByteArray KJsonHelp::jsValue2String(const QJsonValue &jsValue)
{
    QJsonDocument jsDoc;
    if (jsValue.isObject())
    {
        jsDoc.setObject(jsValue.toObject());
    }
    else if (jsValue.isArray())
    {
        jsDoc.setArray(jsValue.toArray());
    }

    return jsDoc.toJson();
}

QVariant KJsonHelp::fromVariant(const QVariant &v) const
{
    switch (v.userType())
    {
    case QMetaType::QRect:      return KHelpUtils::serializeRect(v.toRect()).toJsonValue();
    case QMetaType::QRectF:     return KHelpUtils::serializeRect(v.toRectF()).toJsonValue();
    case QMetaType::QPoint:     return KHelpUtils::serializePoint(v.toPoint());
    case QMetaType::QPointF:    return KHelpUtils::serializePoint(v.toPointF());
    case QMetaType::QSize:      return KHelpUtils::serializeSize(v.toSize());
    case QMetaType::QSizeF:     return KHelpUtils::serializeSize(v.toSizeF());
    case QMetaType::QLine:      return KHelpUtils::serializeLine(v.toLine());
    case QMetaType::QLineF:     return KHelpUtils::serializeLine(v.toLineF());
    case QMetaType::QPolygon:   return KHelpUtils::serializePolygon(v.value<QPolygon>());
    case QMetaType::QPolygonF:  return KHelpUtils::serializePolygon(v.value<QPolygonF>());
    default:                    return v;
    }
}

QVariant KJsonHelp::toVariant(int typeId, const QJsonValue &value)
{
    switch (typeId)
    {
    case QMetaType::QRect:      return KHelpUtils::deserializeRect<QRect>(value.toArray());
    case QMetaType::QRectF:     return KHelpUtils::deserializeRect<QRectF>(value.toArray());
    case QMetaType::QPoint:     return KHelpUtils::deserializePoint<QPoint>(value.toArray());
    case QMetaType::QPointF:    return KHelpUtils::deserializePoint<QPointF>(value.toArray());
    case QMetaType::QSize:      return KHelpUtils::deserializeSize<QSize>(value.toArray());
    case QMetaType::QSizeF:     return KHelpUtils::deserializeSize<QSizeF>(value.toArray());
    case QMetaType::QLine:      return KHelpUtils::deserializeLine<QLine>(value.toArray());
    case QMetaType::QLineF:     return KHelpUtils::deserializeLine<QLineF>(value.toArray());
    case QMetaType::QPolygon:   return KHelpUtils::deserializePolygon<QPolygon,QPoint>(value.toArray());
    case QMetaType::QPolygonF:  return KHelpUtils::deserializePolygon<QPolygonF, QPointF>(value.toArray());
    case QMetaType::QUuid:      return QUuid::fromString(value.toString());
    default:                    return value;
    }
}
