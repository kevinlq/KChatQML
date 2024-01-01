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

#include <QQuickPaintedItem>
#include "KUtil/PropertyHelper.h"

QT_BEGIN_NAMESPACE

class KChatItemPrivate;
class KChatItem : public QQuickPaintedItem
{
    Q_OBJECT
    Q_PROPERTY_AUTO(qreal, radius)
    Q_PROPERTY_AUTO(QColor, hoverColor)
    Q_PROPERTY_AUTO(QColor, color)
    Q_PROPERTY_AUTO(QColor, itemColor)
    Q_PROPERTY_AUTO(QColor, nickNameColor)
    Q_PROPERTY_AUTO(QList<int>,paddings)
    Q_PROPERTY_AUTO(qreal, borderWidth)
    Q_PROPERTY_AUTO(QColor, borderColor)
    Q_PROPERTY_AUTO(int, alignment)
    Q_PROPERTY_AUTO(QFont, font)
    Q_PROPERTY_AUTO(int, contentMsgWidth)
    Q_PROPERTY_AUTO(int, chartItemType)
    Q_PROPERTY_AUTO(QString, avatarPath)
    Q_PROPERTY_AUTO(QString, nickName)
    Q_PROPERTY_AUTO(QVariant, msgValue)
public:
    explicit KChatItem(QQuickItem *parent = nullptr);
    ~KChatItem() override;

    enum ChatItemType
    {
        NullMsg             = -1,
        TextMsg             = 0x01,       // 文本
        PictureMsg          = 0x02,       // 图片
        EmoticonsMsg        = 0x04,       // 表情包
        VoiceMsg            = 0x08,       // 语音
        VideoMsg            = 0x10,       // 视频
        QuoteMsg            = 0x20,       // 引用类型消息
        WithdrawMsg         = 0x40,       // 撤回消息
    };
    Q_ENUMS(ChatItemType)
    Q_DECLARE_FLAGS(ChartItemTypes, ChatItemType)

protected:
    void paint(QPainter *painter) override;

    void hoverEnterEvent(QHoverEvent *event) override;
    void hoverMoveEvent(QHoverEvent *event) override;
    void hoverLeaveEvent(QHoverEvent *event) override;
    void mousePressEvent(QMouseEvent *event) override;
    void mouseReleaseEvent(QMouseEvent *event) override;

Q_SIGNALS:
    void contentClicked(const QVariant &info);

protected:
    KChatItem(KChatItemPrivate &dd, QQuickItem *parent = nullptr);

    void initiate();

    bool isValid();

    void enterArea(const QPointF &pos, const QMargins &margins = QMargins(0, 0, 0, 0));

    QRect getRenderRect();
    QRect getAvatarRect();
    QRect getNickNameRect();

private:
    Q_DISABLE_COPY(KChatItem)
    Q_DECLARE_PRIVATE(KChatItem)
};

QT_END_NAMESPACE
