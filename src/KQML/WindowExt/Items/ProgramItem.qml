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
import "./../../Component"

Item {
    id: control
    property string icon: ""
    property string name: ""
    property string des: ""
    property string url: ""

    Rectangle {
        color: "#e1e1e1"
        radius: 4
        anchors.fill: parent
        visible: m.containsMouse
    }
    MouseArea {
        id: m
        anchors.fill: parent
        hoverEnabled: true
    }
    ColumnLayout {
        anchors.fill: parent
        spacing: 2

        KClipImage {
            Layout.preferredHeight: d.itemSize
            Layout.preferredWidth: d.itemSize
            Layout.topMargin: 10
            Layout.alignment: Qt.AlignHCenter
            radius: [width/2, width/2, width/2, width/2]
            source: icon
        }
        KText {
            text: control.name
            //color: g_theme.skinComColor.lightTextcolor
            Layout.preferredHeight: 22
            Layout.preferredWidth: parent.width
            Layout.alignment: Qt.AlignHCenter
            Layout.topMargin: 2
            horizontalAlignment: Text.AlignHCenter
        }
    }

    QtObject {
        id: d
        property int itemSize: 38
    }
}
