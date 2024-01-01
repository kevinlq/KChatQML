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
import QtQuick.Controls 2.0
import QtQuick.Layouts 1.3
import QtQuick.Window 2.2
import Qt.labs.platform 1.1
import FluentUI 1.0
import com.kevinlq.kchat 1.0

import "../Chat"
import "../Component"

KWindow
{
    id: window
    visible: true

    width: 910
    height: 660
    minimumWidth: 620
    minimumHeight: 500
    launchMode: FluWindowType.SingleInstance
    appBar: null
    titleHeight: 30
    color: g_theme.windowBackgroundColor

    Component.onCompleted: {
        //systemTray.show()

        //customeTray.init(window)
    }
    onClosing: function(event) {
        app.closeClient()
    }

    // KSystemTray {
    //     id: customeTray
    //     icon: "/Config/Theme/logo.jpg"
    //     tooltip: g_language.loginTitle
    //     onActivated:
    //         (reason)=>{
    //             console.log("reason:::", reason)
    //             if(reason === SystemTrayIcon.Trigger){
    //                 //updateIcon()
    //                 window.show()
    //                 window.raise()
    //                 window.requestActivate()
    //             }
    //         }
    // }

    // SystemTrayIcon {
    //     id: systemTray
    //     visible: false
    //     icon.mask: true
    //     icon.source: "qrc:/KQML/Config/Theme/logo.jpg"
    //     tooltip: g_language.loginTitle
    //     menu: Menu {
    //         MenuItem {
    //             text: "退出"
    //             onTriggered: {
    //             }
    //         }
    //     }
    // }

    Item {
        anchors.fill: parent
        KAppBar {
            id: _app_bar
            anchors {
                top: parent.top
                left: parent.left
                right: parent.right
            }
            iconSize: 10
            textColor: window.titleTextColor
            height: window.titleHeight
            buttonSize: Qt.size(28, 28)
            Rectangle {
                width: _navView.cellWidth
                height: parent.height
                color: g_theme.skinComColor.navBackgroundColor
                anchors {
                    top: parent.top
                    left: parent.left
                }
            }
        }

        KChartNavigationView {
            id: _navView
            anchors.fill: parent
            iconSize: 18
            footerPadding: 6
            logo: "qrc:/KQML/Config/Theme/logo.jpg"
            z: 999
            pageMode: FluNavigationViewType.Stack
            items: KNavigationItems {
                navigationView: _navView
                //paneItemMenu: nav_item_right_menu
            }
            footerItems: KNavigationFooterItem {
                navigationView: _navView
                //paneItemMenu: nav_item_right_menu
            }
            topPadding: window.titleHeight
            displayMode: FluNavigationViewType.Compact
            onLogoClicked: function (arg){
                window.showUserInfoPop(arg)
            }
            Component.onCompleted: {
                setCurrentIndex(0)
            }
        }
    }
    KLoader {
        id: _userInfoLoader
        source: "./../Chat/KUserInfo.qml"
        visible: false
        active: false
        width: 280
        height: 188
    }

    function showUserInfoPop(arg) {
        _userInfoLoader.active = true
        _userInfoLoader.visible = true
        var pos = arg.pos
        var newPosX = pos.x + 10
        var newPosY = pos.y + 10
        if (newPosX + _userInfoLoader.width+2 > window.width) {
            newPosX = window.width - _userInfoLoader.width - 4
        }
        if (newPosY + _userInfoLoader.height+2 > window.height) {
            newPosY = window.height - _userInfoLoader.height - 4
        }
        _userInfoLoader.x = newPosX
        _userInfoLoader.y = newPosY
        return _userInfoLoader.item.initialize(arg)
    }
}
