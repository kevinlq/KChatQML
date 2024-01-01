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
import QtQuick.Controls 2.15
import FluentUI 1.0
import "./../Component"
import "./../Config"

KPopup {
    id: control
    width: 280
    height: 188
    closePolicy: Popup.CloseOnEscape | Popup.CloseOnPressOutside

    onActiveFocusChanged: {
        if(!activeFocus) {
            control.close()
        }
    }
    ColumnLayout {
        width: parent.width
        Layout.fillWidth: true
        Layout.fillHeight: true
        RowLayout {
            id: _row
            spacing: 8
            Layout.leftMargin: 22
            Layout.topMargin: 24
            Layout.fillWidth: true
            KClipImage {
                id: _thumba
                width: 62
                height: width
                source: "/Config/Theme/logo.jpg"
                onClicked: {
                    console.log("click:::")
                }
            }

            Column {
                spacing: 4
                width: parent.width
                Row {
                    width: parent.width
                    spacing: 4
                    KText {
                        text: KGlHelp.loginNickName
                    }
                    KIcon {
                        iconSize: 12
                        iconSource: FluentIcons.SpeechSolidBold
                        anchors.verticalCenter: parent.verticalCenter
                        iconColor: "#10aeff"
                    }
                }
                Row {
                    KText {
                        text: g_language.chatNumber
                        color: g_theme.windowTextColor
                    }
                    KText {
                        text: "kevinlqV"
                        color: g_theme.skinComColor.textColor
                    }
                }
                Row {
                    KText {
                        text: g_language.chatArea
                        color: g_theme.windowTextColor
                    }
                    KText {
                        text: "Xi'an Shanxi"
                        color: g_theme.skinComColor.textColor
                    }
                }
            }
        }
        Rectangle {
            Layout.fillWidth: true
            Layout.preferredHeight: 1
            Layout.leftMargin: 22
            Layout.rightMargin: 22
            Layout.topMargin: 14
            color: g_theme.skinComColor.textColor
        }
        KTextButton {
            text: g_language.chatSendMessage
            width: 110
            height: 30
            Layout.alignment: Qt.AlignHCenter
            Layout.topMargin: 30
            normalColor: g_theme.skinLogin.normalColor
            backgroundHoverColor: g_theme.skinLogin.backgroundHoverColor
            backgroundNormalColor: g_theme.skinLogin.backgroundNormalColor
            backgroundPressedColor: g_theme.skinLogin.backgroundPressedColor
            onClicked: {
            }
        }
    }

    function initialize(arg) {
        control.forceActiveFocus(Qt.ActiveWindowFocusReaso)
        control.open()
        console.log("show....", JSON.stringify(arg))
    }
}
