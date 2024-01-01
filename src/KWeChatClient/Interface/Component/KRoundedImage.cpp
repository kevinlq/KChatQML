#include "KRoundedImage.h"
#include "../Client/SettingsHelper.h"

#include <QPainterPath>
#include <QFile>

KRoundedImage::KRoundedImage(QQuickItem *parent)
    : KRectangle(parent)
    , _source("")
{
    connect(this,&KRoundedImage::sourceChanged,this,[=]{update();});
}

void KRoundedImage::paint(QPainter *painter)
{
    auto viewWidth = this->width();
    auto viewHeight = this->height();
    if(source().isEmpty()) {
        return;
    }

    if(m_pixmap.isNull()) {
        auto resPrefix = SettingsHelper::getInstance()->resPrefix();
        auto imagPath = resPrefix + source();
        m_pixmap = QPixmap(imagPath);

        if(m_pixmap.isNull()) {
            qWarning() << "source invalid.." << source() <<imagPath;
            return;
        }
    }
    auto newPixmap = m_pixmap.scaled(viewWidth, viewHeight, Qt::IgnoreAspectRatio, Qt::SmoothTransformation);

    painter->setRenderHints(QPainter::Antialiasing, true);
    painter->setRenderHints(QPainter::SmoothPixmapTransform, true);

    auto imageWidth = newPixmap.width();
    auto imageHeight = newPixmap.height();
    auto xRadius = radius()[0];
    auto yRadius = radius()[1];

    QPainterPath path;
    QRectF rect(0, 0, imageWidth, imageHeight);
    path.addRoundedRect(rect, xRadius, yRadius);
    painter->setClipPath(path);
    painter->drawPixmap(0, 0, imageWidth, imageHeight, newPixmap);
}
