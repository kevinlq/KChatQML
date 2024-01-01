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
   auto login page
*/
import QtQuick 2.11
import QtQuick.Layouts 1.13
import "./../Component"
import "./../Config"

BasePage {

    Component.onCompleted: {
        _buttonModel.append(getButtonModel())
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
        id: _nickNameText
        text: KGlHelp.loginNickName
        font.pixelSize: 18
        anchors {
            top: _titleLabel.bottom
            topMargin: 26
            horizontalCenter: parent.horizontalCenter
        }
    }

    KTextButton {
        id: _enterButton
        text: g_language.enterChat
        width: 180 ;height: 36
        font.pixelSize: 14
        normalColor: g_theme.skinLogin.normalColor
        backgroundHoverColor: g_theme.skinLogin.backgroundHoverColor
        backgroundNormalColor: g_theme.skinLogin.backgroundNormalColor
        backgroundPressedColor: g_theme.skinLogin.backgroundPressedColor
        anchors {
            top: _nickNameText.bottom
            topMargin: 62
            horizontalCenter: parent.horizontalCenter
        }
        onClicked: {
            //loginWindow.visible = false
            var arg = {}
            arg.properties = {"closeDestory": true}
            arg.param = {}
            //app.changePage("/main", arg)

            loginWindow.runFunction("login", 0, _enterButton, arg)
        }
    }

    Item {
        width: parent.width
        height: 30
        anchors {
            top: _enterButton.bottom
            topMargin: 26
            left: parent.left
            right: parent.right
        }
        RowLayout {
            width: parent.width - 26*2
            height: parent.height
            anchors {
                top: parent.top
                horizontalCenter: parent.horizontalCenter
            }
            spacing: 30
            ListModel {
                id: _buttonModel
            }
            Repeater {
                model: _buttonModel
                KTextButton {
                    id: _buttonItem
                    text: itemText
                    font.pixelSize: 12
                    normalColor: g_theme.skinLogin.textColor
                    backgroundNormalColor: "transparent"
                    backgroundHoverColor: backgroundNormalColor
                    backgroundPressedColor: backgroundNormalColor
                    Layout.fillWidth: true
                    onClicked: {
                        loginWindow.runFunction(fun, index, _buttonItem, null)
                    }
                }
            }
        }
    }

    function getButtonModel (){
        var buttonData = [
                    {"itemText": g_language.switAccount, "fun": "changeAccount"},
                    {"itemText": g_language.transFiles, "fun": "transFile"},
                ]
        return buttonData
    }

    function languageChanged(arg) {
        var buttonData = getButtonModel()
        for(var i = 0; i < buttonData.length; i++) {
            _buttonModel.setProperty(i, "itemText", buttonData[i]["itemText"])
        }
    }
}
