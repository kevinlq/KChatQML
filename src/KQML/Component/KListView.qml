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
import QtQuick.Controls 2.4

ListView {
    id: control

    property alias listModel : _listModel
    property alias vScroll: vbar
    property alias hScroll: hbar
    property real scrollPolicy: ScrollBar.AsNeeded
    property real scrollRightMargin: 2

    orientation: ListView.Vertical
    ScrollBar.vertical: ScrollBar {
        id: vbar
        policy: control.scrollPolicy
        active: control.scrollPolicy
        //size: listView.height / listView.contentHeight
        anchors {
            top: parent.top
            right: parent.right
            rightMargin: control.scrollRightMargin
        }
//        contentItem: Rectangle {
//            implicitWidth: 6
//            implicitHeight: 10
//            radius: width / 2
//            color: vbar.pressed ? "#81e889" : "#c2f4c6"
//        }
    }
    ScrollBar.horizontal: ScrollBar{
        id: hbar
        policy: ScrollBar.AlwaysOff
    }
    highlightMoveDuration: 150
    currentIndex: -1
    interactive: true
    boundsBehavior: ListView.StopAtBounds
    clip: true
    scale: 1
    model: _listModel

    ListModel {
        id: _listModel
    }
}
