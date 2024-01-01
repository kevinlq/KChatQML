#include "KRectangle.h"

#include <QPainter>
#include <QPainterPath>

KRectangle::KRectangle(QQuickItem *parent)
    : QQuickPaintedItem(parent)
    , _color(Qt::white)
    , _borderColor(Qt::black)
    , _borderWidth(0)
    , _radius({0,0,0,0})
{
    connect(this,&KRectangle::colorChanged,this,[=]{update();});
    connect(this,&KRectangle::radiusChanged,this,[=]{update();});
    connect(this,&KRectangle::borderColorChanged,this,[=]{update();});
    connect(this,&KRectangle::borderWidthChanged,this,[=]{update();});
}

void KRectangle::paint(QPainter *painter)
{
    painter->save();
    painter->setRenderHint(QPainter::Antialiasing);

    QPainterPath path;
    QRectF rect = boundingRect();
    path.moveTo(rect.bottomRight() - QPointF(0, _radius[2]));
    path.lineTo(rect.topRight() + QPointF(0, _radius[1]));
    path.arcTo(QRectF(QPointF(rect.topRight() - QPointF(_radius[1] * 2, 0)), QSize(_radius[1] * 2, _radius[1] * 2)), 0, 90);
    path.lineTo(rect.topLeft() + QPointF(_radius[0], 0));
    path.arcTo(QRectF(QPointF(rect.topLeft()), QSize(_radius[0] * 2, _radius[0] * 2)), 90, 90);
    path.lineTo(rect.bottomLeft() - QPointF(0, _radius[3]));
    path.arcTo(QRectF(QPointF(rect.bottomLeft() - QPointF(0, _radius[3] * 2)), QSize(_radius[3] * 2, _radius[3] * 2)), 180, 90);
    path.lineTo(rect.bottomRight() - QPointF(_radius[2], 0));
    path.arcTo(QRectF(QPointF(rect.bottomRight() - QPointF(_radius[2] * 2, _radius[2] * 2)), QSize(_radius[2] * 2, _radius[2] * 2)), 270, 90);

    painter->fillPath(path, color());
    if(borderWidth() > 0)
    {
        auto borderPen = painter->pen();
        borderPen.setColor(borderColor());
        borderPen.setWidth(borderWidth());
        painter->drawPath(path);
    }

    painter->restore();
}
