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
import "./../Component"

Item {
    id: cardRoot
    property string title: ""
    property int mode: 0

    Rectangle {
        color: "#ededed"
        anchors.fill: parent
        radius: 6
    }
    KShadow {
        anchors.fill: parent
        radius: 6
    }

    KText {
        text: cardRoot.title
        anchors {
            left: parent.left
            leftMargin: 6
            top: parent.top
            topMargin: 18
        }
    }
    KTextButton {
        anchors {
            right: parent.right
            rightMargin: 6
            top: parent.top
            topMargin: 18
        }
        text: "更多 >"
        backgroundNormalColor: "transparent"
    }

    KListView {
        orientation: ListView.Horizontal
    }

    Flow {
        width: parent.width
        Item {
            width: 40
            height: 40
            Image {
            }
            KText {
            }
        }
    }
}
