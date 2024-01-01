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
    property string thumb: ""

    Rectangle {
        color: "#e9e9e9"
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
        spacing: 4
        KClipImage {
            id: _thumbImage
            Layout.fillWidth: true
            Layout.preferredHeight: parent.height*0.6
            Layout.margins: 4
            source: thumb
        }
        Row {
            Layout.fillWidth: true
            Layout.fillHeight: true
            Layout.leftMargin: 6
            Layout.rightMargin: 6
            spacing: 4
            KClipImage {
                width: 30
                height: 30
                radius: [width/2, width/2, width/2, width/2]
                source: icon
            }
            Column {
                spacing: 4
                width: parent.width
                KText {
                   text: control.name
                   width: parent.width*0.75
                }
                KText {
                   text: control.des
                   color: g_theme.skinComColor.lightTextcolor
                   font.pixelSize: 10
                   width: parent.width*0.75
                }
            }
        }
    }
}
