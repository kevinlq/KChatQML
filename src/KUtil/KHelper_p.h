
#pragma once

#include <QString>
#include <QMetaType>
#include <QJsonArray>
#include <QVariant>
#include <QMetaProperty>
#include <QJsonDocument>
#include <QFile>
#include <QTemporaryFile>
#include <QDir>
#include <QRect>
#include <QRect>
#include <QPoint>
#include <QPointF>
#include <QPolygon>
#include <QLine>
#include <QUuid>
#include <QTextStream>
#include <QDebug>
#include <QVarLengthArray>
#include <QReadWriteLock>
#include <QException>


namespace KHelpUtils {
template <class Rect>
static inline QVariant serializeRect(const Rect &r)
{
    return QVariant(QJsonArray{r.x(), r.y(), r.width(), r.height()});
}
template <class Rect>
static inline Rect deserializeRect(const QJsonArray &array)
{
    Rect r(-1, -1, -1, -1);
    if(4 == array.size())
    {
        auto x      = (array[0].type() == QJsonValue::Double) ? array[0].toDouble(-1) : array[0].toInt(-1);
        auto y      = (array[1].type() == QJsonValue::Double) ? array[1].toDouble(-1) : array[1].toInt(-1);
        auto width  = (array[2].type() == QJsonValue::Double) ? array[2].toDouble(-1) : array[2].toInt(-1);
        auto height = (array[3].type() == QJsonValue::Double) ? array[3].toDouble(-1) : array[3].toInt(-1);
        r = Rect(x, y, width, height);
    }
    return r;
}

template <class Size>
static inline QVariant serializeSize(const Size &size)
{
    return QVariant(QJsonArray{size.width(), size.height()});
}
template <class Size>
static inline Size deserializeSize(const QJsonArray &array)
{
    Size s(-1, -1);
    if(2 == array.size())
    {
        auto width  = (array[0].type() == QJsonValue::Double) ? array[0].toDouble(-1) : array[0].toInt(-1);
        auto height = (array[1].type() == QJsonValue::Double) ? array[1].toDouble(-1) : array[1].toInt(-1);
        s.setWidth(width);
        s.setHeight(height);
    }
    return s;
}

template <class Point>
static inline QVariant serializePoint(const Point &point)
{
    return QVariant(QJsonArray{point.x(), point.y()});
}
template <class Point>
static inline Point deserializePoint(const QJsonArray &array)
{
    Point p(-1, -1);
    if(2 == array.size())
    {
        auto x = (array[0].type() == QJsonValue::Double) ? array[0].toDouble(-1) : array[0].toInt(-1);
        auto y = (array[1].type() == QJsonValue::Double) ? array[1].toDouble(-1) : array[1].toInt(-1);
        p.setX(x);
        p.setY(y);
    }
    return p;
}

template <class Polygon>
static inline QVariant serializePolygon(const Polygon &p)
{
    QVariantList array;
    for (int i = 0; i < p.count(); ++i)
    {
        array << serializePoint(p.at(i));
    }
    return array;
}
template <class Polygon, class Point>
static inline QVariant deserializePolygon(const QJsonArray &array)
{
    Polygon polygon;
    for (int i = 0; i < array.size(); ++i)
    {
        polygon << deserializePoint<Point>(array.at(i).toArray());
    }
    return polygon;
}
template <class BitArray>
static inline QVariant serializeBitArray(const BitArray &b)
{
    QVariantList array;
    for (int i = 0; i < b.count(); ++i)
    {
        array << b.at(i);
    }
    return array;
}

template <class Line>
static inline QVariant serializeLine(const Line &p)
{
    return QVariant(QJsonArray{p.x1(), p.y1(), p.x2(), p.y2()});
}
template <class Line>
static inline Line deserializeLine(const QJsonArray &array)
{
    Line l(-1, -1, -1, -1);
    if(4 == array.size())
    {
        auto x1 = (array[0].type() == QJsonValue::Double) ? array[0].toDouble(-1) : array[0].toInt(-1);
        auto y1 = (array[1].type() == QJsonValue::Double) ? array[1].toDouble(-1) : array[1].toInt(-1);
        auto x2 = (array[2].type() == QJsonValue::Double) ? array[2].toDouble(-1) : array[2].toInt(-1);
        auto y2 = (array[3].type() == QJsonValue::Double) ? array[3].toDouble(-1) : array[3].toInt(-1);
        l = Line(x1, y1, x2, y2);
    }
    return l;
}

}// namespace KHelpUtils

class KException : public QException
{
public:
    KException(const QByteArray &what) : m_what(what) {}
    const char *what() const noexcept final {return m_what.constData();}

    virtual void raise() const override {throw *this;}
    virtual KException *clone() const override {return new(std::nothrow) KException(QByteArray());}
protected:
    QByteArray m_what;
};

