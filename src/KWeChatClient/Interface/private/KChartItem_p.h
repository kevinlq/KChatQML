#pragma once

#include <private/qquickpainteditem_p.h>

class KChatItemPrivate : public QQuickPaintedItemPrivate
{
    Q_DECLARE_PUBLIC(KChatItem)
public:
    static const KChatItemPrivate* get(const KChatItem *item);
    static KChatItemPrivate* get(KChatItem *item);

    explicit KChatItemPrivate();
    ~KChatItemPrivate() override;
    void init(QQuickItem *parent);

    bool renderTextMsg(QPainter *painter);
    bool renderPictureMsg(QPainter *painter);

public:
    QColor  m_drawBackColor;
    QColor  m_drawBorderColor;
};
