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

FluRadioButton {
    id: control
    normalColor: g_theme.skinRadioButton.normalColor
    hoverColor: checked ? g_theme.skinRadioButton.checkHoverColor: g_theme.skinRadioButton.unCheckHoverColor
    disableColor: checked ? g_theme.skinRadioButton.checkDisableColor : g_theme.skinRadioButton.unCheckDisableColor
    textColor: g_theme.skinRadioButton.textColor
    borderNormalColor: checked ? g_theme.skinRadioButton.checkBorderNormalColor : g_theme.skinRadioButton.unCheckBorderNormalColor
    borderDisableColor: g_theme.skinRadioButton.borderDisableColor
    size: 12
    textSpacing: 8

    property bool exclusive: false
    property int cursorShape: Qt.PointingHandCursor

    clickListener : function(){
        if (control.checked && control.exclusive) {
            return
        }
        control.checked = !control.checked
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
