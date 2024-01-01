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

KBaseDelegate {
    id: control

    property bool __itemHovered: false
    property int rowItemHeight: 62

    Rectangle {
        anchors.fill: parent
        color: {
            if(control.__itemHovered && index !== listView.currentIndex) {
                return FluTheme.dark ? Qt.rgba(50/255,50/255,50/255,1) :"#d8d7d7"
            }
            if(FluTheme.dark ) {
                return (index === listView.currentIndex) ? Qt.rgba(55/255,55/255,55/255,1) : Qt.rgba(39/255,39/255,39/255,1)
            }
            return (index === listView.currentIndex) ? "#c7c5c4" : "#e5e5e5"
        }
        radius: 2
    }

    MouseArea {
        anchors.fill: parent
        acceptedButtons: Qt.RightButton | Qt.LeftButton
        hoverEnabled: true
        Timer {
            id: dummyTimer
            interval: 240
            running: false
        }
        onEntered: {
            control.__itemHovered = true
        }
        onExited: {
            control.__itemHovered = false
        }
        onClicked: (mouse)=> onItemClicked(mouse)
    }
    function onItemClicked(mouse) {
        if (dummyTimer.running) {
            dummyTimer.stop()
            return control.itemDoubleClicked(mouse)
        }
        else {
            dummyTimer.restart()
            return control.itemClicked(mouse)
        }
    }
}
