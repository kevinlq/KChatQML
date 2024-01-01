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
import com.kevinlq.kchat 1.0
import "./../Component"
import "./../Config"

Item {

    property var funApi: null
    property string url: ""

    QtObject {
        id: d
        property string nickName: "鹅卵石"
        property string accountName: "kevinlqV"
    }

    KRectangle {
        id: _titleGouup
        color: "#FFFFFF"
        radius: [4,4,4,4]
        height: 140
        width: 350
        anchors {
            top: parent.top
            topMargin: 6
            horizontalCenter: parent.horizontalCenter
        }

        KClipImage {
            id: _titleImage
            width: 53
            height: 53
            anchors {
                left: parent.left
                leftMargin: 24
                verticalCenter: parent.verticalCenter
            }
            source: KGlHelp.useAvatar
        }

        Column {
            height: _titleImage.height
            anchors {
                left: _titleImage.right
                leftMargin: 16
                top: _titleImage.top
                topMargin: 2
            }
            spacing: 6
            KText {
                text: d.nickName
                font.pixelSize: 18
                color: g_theme.skinSetting.nickNameTextColor
            }
            Row {
                spacing: 2
                width: parent.width
                KText {
                    text: g_language.setNickName
                    color: g_theme.skinSetting.accountTextColor
                }
                KText {
                    text: d.accountName
                    color: g_theme.skinSetting.accountTextColor
                }
            }
        }
    }

    // auto login
    RowLayout {
        spacing: 24
        anchors {
            left: _titleGouup.left
            leftMargin: 24
            top: _titleGouup.bottom
            topMargin: 38
        }
        KText {
            id: _autoLoginLabel
            text: g_language.setAutoLogin
            color: g_theme.skinSetting.normalColor
        }
        ColumnLayout {
            spacing: 6
            Layout.preferredWidth: 240
            Layout.preferredHeight: 30
            Row {
                id: _autoLoginControl
                spacing: 6
                KText {
                    text: g_language.setTurnedOn
                    anchors.verticalCenter: parent.verticalCenter
                    color: g_theme.skinSetting.normalColor
                }
                KTextButton {
                    text: g_language.setClosure
                    anchors.verticalCenter: parent.verticalCenter
                    normalColor: g_theme.skinSetting.autoLoginTextColor
                    backgroundNormalColor: "transparent"
                    backgroundHoverColor: "transparent"
                    backgroundPressedColor: "transparent"
                    onClicked: {
                        var arg = {}
                        setWindow.showMsgDialog("", g_language.setCloseSignTips, signOutCallback, arg)
                    }
                }
            }
            KText {
                text: g_language.setAutoSignTips
                Layout.preferredWidth: 240
                wrapMode: Text.WrapAtWordBoundaryOrAnywhere
                color: g_theme.skinSetting.accountTextColor
            }
        }
    }

    // quick login
    KTextButton {
        anchors {
            bottom: parent.bottom
            bottomMargin: 56
            horizontalCenter: parent.horizontalCenter
        }
        text: g_language.setSignout
        cursorShape: Qt.PointingHandCursor
        width: 110 ;height: 34
        normalColor: g_theme.skinSetting.normalColor
        onClicked: {
            var arg = {}
            setWindow.showMsgDialog("", g_language.setLogOutTip, signOutCallback, arg)
        }
    }

    function initialize(arg) {
        if(!arg) {
            return false
        }
        d.nickName = arg.accountData.nickName
        d.accountName = arg.accountData.accountName

        return true
    }
    function languageChanged(arg) {
    }
    function themeChanged(arg){
    }

    function signOutCallback(btnName,param){
        if("ok" === btnName) {
            var arg = {}
            arg.param = {"type": "autoLogin"}
            app.logOut(arg)
        }
    }
}
