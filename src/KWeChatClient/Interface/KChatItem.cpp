#include "KChatItem.h"
#include "private/KChartItem_p.h"
#include "../Client/SettingsHelper.h"

#include <QApplication>
#include <QStyle>

/*!
    \internal
*/
const KChatItemPrivate *KChatItemPrivate::get(const KChatItem *item)
{
    return item->d_func();
}
KChatItemPrivate *KChatItemPrivate::get(KChatItem *item)
{
    return item->d_func();
}
KChatItemPrivate::KChatItemPrivate()
    : QQuickPaintedItemPrivate()
    , m_drawBackColor(Qt::white), m_drawBorderColor(Qt::black)
{
}

KChatItemPrivate::~KChatItemPrivate()
{
}

void KChatItemPrivate::init(QQuickItem *parent)
{
    Q_Q(KChatItem);
    if(parent)
    {
        q->setParentItem(parent);
    }
}

/*!
    Render a text msg given,realy draw rectangle background style.
 */
bool KChatItemPrivate::renderTextMsg(QPainter *painter)
{
    Q_Q(KChatItem);
    if(!q->isValid())
    {
        return false;
    }
    Q_UNUSED(painter);
    // QML render Text.

    return true;
}

bool KChatItemPrivate::renderPictureMsg(QPainter *painter)
{
    Q_Q(KChatItem);
    if(!q->isValid())
    {
        return false;
    }
    Q_UNUSED(painter);

    // QML render picture.

    return true;
}

/*!
    Constructs a KChatItem with the given \a parent item.
 */
KChatItem::KChatItem(QQuickItem *parent)
    : QQuickPaintedItem(*(new KChatItemPrivate), parent)
{
    Q_D(KChatItem);
    d->init(parent);

    initiate();
}

/*!
    \internal
*/
KChatItem::KChatItem(KChatItemPrivate &dd, QQuickItem *parent)
    : QQuickPaintedItem(dd, parent)
{
    Q_D(KChatItem);
    d->init(parent);

    initiate();
}

void KChatItem::initiate()
{
    Q_D(KChatItem);
    setAcceptHoverEvents(true);
    setCursor(Qt::ArrowCursor);
    setAcceptHoverEvents(true);
    setAcceptedMouseButtons(Qt::LeftButton | Qt::RightButton);

#ifdef Q_OS_ANDROID
    setAcceptTouchEvents(true);
    setAcceptHoverEvents(false);
#endif

    _radius         = 6;
    _color          = Qt::white;
    _itemColor      = Qt::white;
    _nickNameColor  = Qt::black;
    _paddings       = {0, 0, 0, 0};
    _borderWidth    = 0;
    _borderColor    = Qt::white;
    _chartItemType  = ChatItemType::NullMsg;
    _nickName       = "";
    _msgValue       = QVariant();

    connect(this, &KChatItem::borderColorChanged,this, [=]{
        d->m_drawBorderColor = borderColor();
            });
    connect(this, &KChatItem::itemColorChanged, this, [=]{
                d->m_drawBackColor = itemColor();
    });
    connect(this, &KChatItem::nickNameColorChanged, this, [=]{ this->update();});
}

bool KChatItem::isValid()
{
    return true;
}

void KChatItem::enterArea(const QPointF &pos, const QMargins &margins)
{
    Q_D(KChatItem);
    auto roundRect = getRenderRect();
    auto titleRect = getAvatarRect();
    setCursor(Qt::ArrowCursor);

    roundRect.adjust(margins.left(), margins.top(), margins.right(), margins.bottom());
    if(roundRect.contains(pos.toPoint()))
    {
        if(ChatItemType::PictureMsg == chartItemType() || ChatItemType::VoiceMsg == chartItemType()) {
            setCursor(Qt::PointingHandCursor);
        }

        d->m_drawBackColor      = hoverColor();
        d->m_drawBorderColor    = hoverColor();
        this->update();
    }
    else if (titleRect.contains(pos.toPoint()))
    {
        setCursor(Qt::PointingHandCursor);
    }
}

QRect KChatItem::getRenderRect()
{
    auto thisRect = QRect(0, 0, this->contentMsgWidth(), this->height());
    if(Qt::AlignRight & alignment())
    {
        const auto contWidth = this->contentMsgWidth();
        thisRect = QRect(this->width() - contWidth, 0, contWidth, this->height());
    }
    return thisRect.adjusted(_paddings[0], _paddings[1], _paddings[2], _paddings[3]);
}

QRect KChatItem::getAvatarRect()
{
    auto thisRect = QRect(0, 0, this->width(), this->height());

    if(Qt::AlignLeft & alignment())
    {
        return QRect(1, 4, 36, 36);
    }
    return QRect(thisRect.width() - 2 - 36, 2, 36, 36);
}

QRect KChatItem::getNickNameRect()
{
    const auto thisRect = QRect(0, 0, this->width(), this->height());
    const auto titleRect = getAvatarRect();
    const auto realWidth = thisRect.width() - _paddings[0];
    const auto realHeight = _paddings[1];
    const auto spacing = 8;

    if(Qt::AlignLeft & alignment())
    {
        return QRect(titleRect.right()+spacing, 0, realWidth, realHeight);
    }
    return QRect(titleRect.left() - spacing, 0, realWidth, realHeight);
}
/*!
    Destroys the KChatItem.
*/
KChatItem::~KChatItem()
{
}

void KChatItem::paint(QPainter *painter)
{
    Q_D(KChatItem);

    painter->setRenderHint(QPainter::Antialiasing);

    const auto thisRect = boundingRect();
    painter->fillRect(thisRect, color());

    //! background
    auto roundRect = getRenderRect();
    if(ChatItemType::TextMsg == chartItemType() || ChatItemType::VoiceMsg == chartItemType()) {
        QPainterPath roundPath;
        roundPath.setFillRule(Qt::WindingFill);
        roundPath.addRoundedRect(roundRect, radius(), radius());

        painter->fillPath(roundPath, d->m_drawBackColor);

        painter->setPen(d->m_drawBorderColor);
        painter->drawPath(roundPath);
    }

    //! title image
    const auto titleRect = getAvatarRect();
    auto resPrefix = SettingsHelper::getInstance()->resPrefix();
    auto imagPath = resPrefix + avatarPath();
    QPixmap titleImage(imagPath);
    if(!titleImage.isNull() ) {
        const auto newImage = titleImage.scaled(titleRect.size(), Qt::IgnoreAspectRatio, Qt::SmoothTransformation);
        painter->drawPixmap(titleRect, newImage);
    }

    //! nick name
    const auto nickRect = getNickNameRect();
    const auto drawText = nickName();
    if(Qt::AlignLeft & alignment() && !drawText.isEmpty())
    {
        auto pen = painter->pen();
        auto nickFont = painter->font();
        nickFont.setPixelSize(11);
        nickFont.setFamily(this->font().family());
        pen.setColor(nickNameColor());
        painter->setPen(pen);
        painter->setFont(nickFont);
        painter->drawText(nickRect, drawText, QTextOption(Qt::AlignLeft | Qt::AlignVCenter));
    }

    if(ChatItemType::TextMsg == chartItemType() || ChatItemType::VoiceMsg == chartItemType()) {
        //! arrow
        QPainterPath trianglePath;
        trianglePath.setFillRule(Qt::WindingFill);
        auto basePos = roundRect.top();
        const auto perHeight = 8;
        const auto topPos = basePos + perHeight;
        const auto mindPos = basePos + perHeight*1.2;
        const auto bottomPos = basePos + perHeight*2;
        /*
        _________________
        |_______________|_
        |_______________|   .
        |_______________|-
        */

        QPolygonF polygon;
        if(Qt::AlignLeft & alignment())
        {
            polygon << QPointF(roundRect.left(), topPos)
                    << QPointF(roundRect.left() - 8, mindPos)
                    << QPointF(roundRect.left(), bottomPos);
        }
        else
        {
            polygon << QPointF(roundRect.right(), topPos)
                    << QPointF(roundRect.right() + 8, mindPos)
                    << QPointF(roundRect.right(), bottomPos);
        }
        trianglePath.addPolygon(polygon);
        painter->fillPath(trianglePath, d->m_drawBackColor);
    }

    auto renderResult = false;
    switch (chartItemType())
    {
    case ChatItemType::TextMsg:        renderResult = d->renderTextMsg(painter) ;break;
    case ChatItemType::PictureMsg:     renderResult = d->renderPictureMsg(painter) ;break;
    default:break;
    }

    if(!renderResult)
    {
        return;
    }
}

void KChatItem::hoverEnterEvent(QHoverEvent *event)
{
#if (QT_VERSION < QT_VERSION_CHECK(6, 0, 0))
    enterArea(event->pos(),QMargins(1, 0, 1, 0));
#else
    enterArea(event->position(),QMargins(1, 0, 1, 0));
#endif
}

void KChatItem::hoverMoveEvent(QHoverEvent *event)
{
#if (QT_VERSION < QT_VERSION_CHECK(6, 0, 0))
    enterArea(event->pos(),QMargins(1, 0, 1, 0));
#else
    enterArea(event->position(), QMargins(1, -4, 1, 0));
#endif
}

void KChatItem::hoverLeaveEvent(QHoverEvent *event)
{
    Q_UNUSED(event);
    Q_D(KChatItem);
    d->m_drawBackColor      = itemColor();
    d->m_drawBorderColor    = borderColor();
    this->update();
}

void KChatItem::mousePressEvent(QMouseEvent *event)
{
    Q_UNUSED(event);
}

void KChatItem::mouseReleaseEvent(QMouseEvent *event)
{
    QQuickPaintedItem::mouseReleaseEvent(event);
    auto titleRect = getAvatarRect();
    auto renderRect = getRenderRect();
    const auto hitTitle = titleRect.contains(event->pos());
    const auto hitContent = renderRect.contains(event->pos());
    QVariantMap param;
    param.insert("pos", event->pos());
    param.insert("button", event->button());
    param.insert("hitTitle", hitTitle);
    param.insert("hitContent", hitContent);

    Q_EMIT contentClicked(param);
}
