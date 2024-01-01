/**
 ** This file is part of the KChatApp project.
 ** Copyright (C) 2023 kevinlq kevinlq0912@gmail.com.
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

import QtQuick 2.15
import FluentUI 1.0

FluTextButton {

    id: control
    font.pixelSize: 12
    font.family: "Microsoft YaHei"

    normalColor: g_theme.skinButton.normalColor
    backgroundHoverColor: g_theme.skinButton.backgroundHoverColor
    backgroundNormalColor: g_theme.skinButton.backgroundNormalColor
    backgroundPressedColor: g_theme.skinButton.backgroundPressedColor

    property int cursorShape: Qt.PointingHandCursor
    property int textHAlignment: Text.AlignHCenter

    contentItem: KText {
        id:btn_text
        text: control.text
        font: control.font
        horizontalAlignment: control.textHAlignment
        verticalAlignment: Text.AlignVCenter
        color: control.textColor
    }
    MouseArea {
        anchors.fill: parent
        enabled: control.enabled
        cursorShape: control.cursorShape
        acceptedButtons: Qt.LeftButton | Qt.RightButton
        propagateComposedEvents: true
        onClicked: (mouse)=> { mouse.accepted = false}
        onPressed: (mouse)=> {mouse.accepted = false}
        onDoubleClicked: (mouse)=> {mouse.accepted = false}
    }
}
