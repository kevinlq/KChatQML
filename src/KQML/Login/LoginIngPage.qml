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
import QtQuick.Layouts 1.13
import "./../Component"
import "./../Config"

BasePage {

    Component.onCompleted: {
        _loginTimer.start()
    }

    KClipImage {
        id: _titleLabel
        width: 79
        height: 79
        source: KGlHelp.useAvatar
        anchors {
            top: parent.top
            topMargin: 52
            horizontalCenter: parent.horizontalCenter
        }
    }
    KText {
        id: _logingText
        text: g_language.logingText + "..."
        font.pixelSize: 14
        color: g_theme.skinComColor.normal
        anchors {
            top: _titleLabel.bottom
            topMargin: 26
            horizontalCenter: parent.horizontalCenter
        }
    }

    KTextButton {
        id: _btnCancel
        text: g_language.loginCancel
        normalColor: g_theme.skinLogin.textColor
        backgroundNormalColor: "transparent"
        backgroundHoverColor: backgroundNormalColor
        backgroundPressedColor: backgroundNormalColor
        anchors {
            bottom: parent.bottom
            bottomMargin: 34
            horizontalCenter: parent.horizontalCenter
        }
        onClicked: {
            loginWindow.runFunction("autoLogin", 0, _btnCancel, null)
        }
    }

    // test timer
    Timer {
        id: _loginTimer
        interval: 1000
        repeat: false
        running: false
        onTriggered: {
            loginWindow.visible = false
            var arg = {}
            arg.properties = {"closeDestory": true}
            arg.param = {}
            app.changePage("/main", arg)
        }
    }
}
