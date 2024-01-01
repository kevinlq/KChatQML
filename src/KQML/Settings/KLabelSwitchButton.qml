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
import QtQuick.Layouts 1.3
import "./../Component"

Item {
    id: control

    property string text: ""
    property bool checked: true
    property int iconSource: -1

    implicitWidth: 300
    implicitHeight: 30

    signal clicked(var checked)

    RowLayout {
        spacing: 8
        anchors {
            left: parent.left
            top: parent.top
        }
        KIcon {
            iconSize: 16
            iconSource: control.iconSource
            visible: -1 !== control.iconSource
        }
        KText {
            text: control.text
            color: g_theme.skinSetting.normalColor
        }
    }
    KToggleSwitch {
        height: 24
        width: 38
        anchors {
            right: parent.right
            top: parent.top
        }
        text: ""
        checked: control.checked
        onClicked: control.clicked(checked)
    }
}
