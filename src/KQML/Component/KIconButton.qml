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
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15
import FluentUI 1.0

FluIconButton {
    id: control

    iconDelegate: com_icon
    font.pixelSize: 12
    font.family: "Microsoft YaHei"

    property int iconLeftMargin: 10
    property int iconTextSpacing: 6
    property int cursorShape: Qt.ArrowCursor

    background: Rectangle{
        implicitWidth: 24
        implicitHeight: 24
        radius: control.radius
        color:control.color
        FluFocusRectangle{
            visible: control.activeFocus
        }
    }
    contentItem:FluLoader{
        sourceComponent: {
            if(display === Button.TextUnderIcon){
                return com_column
            }
            else if (display === Button.IconOnly) {
                return com_icon
            }
            return com_row
        }
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


    Component {
        id:com_icon
        FluIcon {
            id:text_icon
            font.pixelSize: iconSize
            iconSize: control.iconSize
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
            iconColor: control.iconColor
            iconSource: control.iconSource
        }
    }
    Component{
        id:com_row
        Row{
            spacing: control.iconTextSpacing
            leftPadding: control.iconLeftMargin
            rightPadding: 0
            FluLoader{
                id: iconLoad
                sourceComponent: iconDelegate
                visible: display !== Button.TextOnly
                anchors.verticalCenter: parent.verticalCenter
            }
            KText{
                text: control.text
                anchors.verticalCenter: parent.verticalCenter
                visible: display !== Button.IconOnly
            }
        }
    }
    Component{
        id:com_column
        ColumnLayout{
            FluLoader{
                sourceComponent: iconDelegate
                Layout.alignment: Qt.AlignVCenter | Qt.AlignHCenter
                visible: display !== Button.TextOnly
            }
            FluText{
                text:control.text
                Layout.alignment: Qt.AlignVCenter | Qt.AlignHCenter
                visible: display !== Button.IconOnly
                color: control.textColor
                font: control.font
            }
        }
    }
}
