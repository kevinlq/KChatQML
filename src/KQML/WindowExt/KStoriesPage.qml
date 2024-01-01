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
import FluentUI 1.0
import "./../Component"

KBaseTabPage {

    id: storiesRoot
    property int leftMargin: width*0.16
    property int contentWidth: width*0.78

    Item {
        id: _title
        height: 80
        width: parent.width
        anchors {
            left: parent.left
            top: parent.top
        }

        RowLayout {
            spacing: 0
            anchors {
                left: parent.left
                leftMargin: storiesRoot.leftMargin
                top: parent.top
                topMargin: 22
                right: parent.right
                rightMargin: storiesRoot.leftMargin
            }

            Row {
                spacing: 8
                Layout.preferredWidth: 120
                Layout.alignment: Qt.AlignVCenter
                KImage {
                    source: "../Config/Theme/images/tabStoreesTitle.svg"
                    width: 24
                    height: 24
                }
                KText {
                    text: "看一看"
                    font.pixelSize: 18
                    anchors.verticalCenter: parent.verticalCenter
                }
            }
            Item {
                Layout.fillWidth: true
            }
            Row {
                Layout.preferredWidth: 80
                Layout.alignment: Qt.AlignVCenter
                spacing: 30
                KIconButton {
                    iconSize: 14
                    width: 24; height: 24
                    iconSource: FluentIcons.Ringer
                    anchors.verticalCenter: parent.verticalCenter
                    onClicked: {
                        // pop notify info
                    }
                }
                KClipImage {
                    width: 26; height: 26
                    source: "Config/Theme/logo.jpg"
                    onClicked: {
                        // skip other page
                    }
                }
            }
        }
    }

    Rectangle {
        color: "#ededed"
        anchors{
            left: parent.left
            top: _title.bottom
            right: parent.right
            bottom: parent.bottom
        }
    }
}
