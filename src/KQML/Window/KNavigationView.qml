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

import QtQuick 2.11
import QtQuick.Layouts 1.15
import Qt.labs.qmlmodels 1.0

import "./../Component"

Item {

    id: control

    signal logoClicked()

    property int cellWidth: 58
    property int iconSize: 18

    Rectangle {
        id: _navBar
        width: control.cellWidth
        height: parent.height
        anchors {
            top: parent.top
            left: parent.left
            topMargin: 0
            leftMargin: 0
        }
        color: "#2e2e2e"
        border.width: 1
        border.color: Qt.rgba(45/255,45/255,45/255,1)
        KShadow {
            radius: 0
        }

        KClipImage {
            id: _titleImage
            source: "/Config/Theme/logo.jpg"
            width: 36
            height: 36
            radius: [2, 2, 2, 2]
            anchors {
                top: parent.top
                topMargin: 40
                horizontalCenter: parent.horizontalCenter
            }
            MouseArea{
                anchors.fill: parent
                cursorShape: Qt.PointingHandCursor
                onClicked: {
                    logoClicked()
                }
            }
        }
        KListView {
            id: _navTopList
            spacing: 2
            interactive: false
            width: parent.width
            height: contentHeight
            anchors {
                top: _titleImage.bottom
                topMargin: 20
                left: parent.left
            }
            delegate: chooser
            DelegateChooser {
                id: chooser
                role: "itemType"
                DelegateChoice { roleValue: "item"; delegate: comItem }
                DelegateChoice { roleValue: "separator"; delegate: comItem }
                DelegateChoice { roleValue: "expander"; delegate: comItem }
            }
        }
        KListView {
            id: _navFooterList
            anchors {
                left: parent.left
                bottom: parent.bottom
                bottomMargin: 8
            }
            width: parent.width
            //height: childrenRect.height
        }
    }

    StackLayout {
        id: _contentLayout
        clip: true
        anchors {
            left: parent.left
            top: parent.top
            topMargin: 0
            right: parent.right
            leftMargin: control.cellWidth
        }
    }

    Component {
        id: comItem
        Item {
            width: _navBar.width
            height: 40
            property var modelData: model
            KIconButton {
                iconSource: model.icon
                iconSize: control.iconSize
                iconColor: g_theme.skinComColor.textColor
                width: control.iconSize*2
                height: control.iconSize*2
                cursorShape: Qt.PointingHandCursor
                checked: true
                anchors{
                    top: parent.top
                    topMargin: 1
                    horizontalCenter: parent.horizontalCenter
                }
                onClicked: {
                    console.log("click....")
                }
            }
            KLoader {
                anchors {
                    right: parent.right
                    verticalCenter: parent.verticalCenter
                    rightMargin: 8
                    verticalCenterOffset: -10
                }
                sourceComponent: {
                    if(model.infoBadge) {
                        return _comInfoBadge
                    }
                    return undefined
                }
                onStatusChanged: {
                    if (status == Loader.Ready) {
                        item.infoBadge = model.infoBadge
                    }
                }
            }
        }
    }
    Component {
        id: _comInfoBadge
        Rectangle {
            property int infoBadge: 0
            width: 14; height: 14
            radius: 7
            color: "#fa5151"
            KText {
                text: infoBadge
                anchors.centerIn: parent
                color: "#FFFFFF"
            }
            visible: infoBadge > 0
        }
    }

    function initialize(navItems, footerItems) {
        _navTopList.listModel.clear()
        _navTopList.listModel.append(navItems)

        _navFooterList.listModel.clear()
        _navFooterList.listModel.append(footerItems)
    }
}
