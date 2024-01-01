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

BaseSetPage {

    id: control
    pageNamge: "about"
    listView.spacing: 14
    textWidth: 68
    spacing: 24
    apiMap: {
        "checkUpdate": checkUpdate,
        "viewHelp": viewHelp
    }

    Item {
        width: parent.width*0.8
        height: 50
        anchors {
            bottom: parent.bottom
            bottomMargin: 12
            horizontalCenter: parent.horizontalCenter
        }
        Column {
            anchors.centerIn: parent
            spacing: 6
            Row {
                spacing: 16
                anchors.horizontalCenter: parent.horizontalCenter
                KTextButton {
                    text: g_language.setTermService
                    normalColor: g_theme.skinSetting.autoLoginTextColor
                    backgroundNormalColor: "transparent"
                    backgroundHoverColor: "transparent"
                    backgroundPressedColor: "transparent"
                    font.pixelSize: 14
                }
                KTextButton {
                    text: g_language.setPrivacyPolicy
                    normalColor: g_theme.skinSetting.autoLoginTextColor
                    backgroundNormalColor: "transparent"
                    backgroundHoverColor: "transparent"
                    backgroundPressedColor: "transparent"
                    font.pixelSize: 14
                }
            }
            KText {
                text: g_language.setCopyright
                color: g_theme.skinSetting.accountTextColor
            }
        }
    }

    function initialize(arg) {
        initModel()
    }
    function checkUpdate(index,obj, modelData, param) {
        var arg = {}
        arg.cancelText = ""
        setWindow.showMsgDialog("", "已是最新版本", null, arg)
    }
    function viewHelp(index,obj, modelData, param) {
        Qt.openUrlExternally("http://kevinlq.com/")
    }
}
