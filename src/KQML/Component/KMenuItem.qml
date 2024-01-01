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

FluMenuItem {
    id: control

    objectName: "menuItem"
    font.pixelSize: 12
    iconSize: 10
    rightInset: 6

    property int contentWidth: content_text.contentWidth
    signal menuTriggered(string menuName, var menuItem)

    contentItem: Item {
        Row{
            spacing: control.iconSpacing
            readonly property real arrowPadding: control.subMenu && control.arrow ? control.arrow.width + control.spacing : 0
            readonly property real indicatorPadding: control.checkable && control.indicator ? control.indicator.width + control.spacing : 0
            anchors{
                verticalCenter: parent.verticalCenter
                left: parent.left
                leftMargin: (!control.mirrored ? indicatorPadding : arrowPadding)+5
                right: parent.right
                rightMargin: (control.mirrored ? indicatorPadding : arrowPadding)+5
            }
            KLoader{
                id:loader_icon
                sourceComponent: iconDelegate
                anchors.verticalCenter: parent.verticalCenter
                visible: status === Loader.Ready
            }
            KText {
                id:content_text
                text: control.text
                color: control.textColor
                anchors.verticalCenter: parent.verticalCenter
                font: control.font
                width: 200
            }
        }
    }
    background: Item {
        implicitWidth: 150
        implicitHeight: 24
        x: 1
        y: 1
        width: control.width - 2
        height: control.height - 2
        Rectangle{
            anchors.fill: parent
            anchors.margins: 2
            radius: 4
            color:{
                if(control.highlighted){
                    return FluTheme.itemCheckColor
                }
                return FluTheme.itemNormalColor
            }
        }
    }

    onTriggered: {
        control.menuTriggered(control.text, control)
    }
}
