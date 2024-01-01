/**
 ** This file is part of the KChatApp project.
 ** Copyright (C) 2024 kevinlq kevinlq0912@gmail.com.
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
import QtQuick.Controls 2.4

Button {
    id: control

    property int cursorShape: Qt.PointingHandCursor
    property int radius: 4
    property color hoverColor: g_theme.skinComColor.hoverColor
    property color pressedColor: g_theme.skinComColor.pressColor
    property color normalColor: g_theme.skinComColor.normalColor
    property color disableColor: g_theme.skinComColor.normalColor
    property color color: {
        if(!enabled){
            return disableColor
        }
        if(pressed){
            return pressedColor
        }
        return hovered ? hoverColor : normalColor
    }
    font.pixelSize: 10
    font.family: "Microsoft YaHei"
    verticalPadding: 0

    background: Rectangle{
        implicitWidth: 24
        implicitHeight: 24
        radius: control.radius
        color:control.color
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
