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
import com.kevinlq.kchat 1.0

KRoundedImage {

    id: control
    radius: [4, 4, 4, 4]
    clip: true
    implicitWidth: 60
    implicitHeight: 60

    property int cursorShape: Qt.PointingHandCursor

    signal clicked()

    MouseArea {
        anchors.fill: parent
        enabled: control.enabled
        cursorShape: control.cursorShape
        acceptedButtons: Qt.LeftButton | Qt.RightButton
        //onClicked: (mouse)=> { control.clicked()}
        onPressed: (mouse)=> {control.clicked()}
        //onDoubleClicked: (mouse)=> {mouse.accepted = false}
    }
}
