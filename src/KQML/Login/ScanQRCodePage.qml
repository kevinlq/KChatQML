
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

/*!
  Scan code to log in page.
*/
import QtQuick 2.11
import "./../Component"

BasePage {

    KText {
        id: _loginTitle
        text: g_language.scanQRLogin
        font.pixelSize: 16
        color: g_theme.skinComColor.backgroundNormalColor
        anchors {
            top: parent.top
            topMargin: 30
            horizontalCenter: parent.horizontalCenter
        }
    }

    Item {
        id: _qrcodeItem
        width: parent.width
        height: 150
        anchors {
            top: _loginTitle.bottom
            topMargin: 20
            horizontalCenter: parent.horizontalCenter
        }
        KClipImage {
            width: 180
            height: 180
            anchors.centerIn: parent
            source: "/Config/Theme/qrcode.jpg"
        }
    }
    KTextButton {
        id: _transButton
        text: g_language.transFiles
        font.pixelSize: 13
        normalColor: g_theme.skinLogin.textColor
        backgroundNormalColor: "transparent"
        backgroundHoverColor: backgroundNormalColor
        backgroundPressedColor: backgroundNormalColor
        anchors {
            bottom: parent.bottom
            bottomMargin: 32
            horizontalCenter: parent.horizontalCenter
        }
        onClicked: {
            loginWindow.runFunction("transFile", 0, _transButton, null)
        }
    }

}
