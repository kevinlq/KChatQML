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
import FluentUI 1.0

FluObject {

    id: footer_items

    property var navigationView: null
    property var paneItemMenu: null

    FluPaneItem {
        title: g_language.navMiniProgram
        icon: FluentIcons.BrowsePhotos
        onTapListener:function(){
            var arg = {}
            arg.properties = {"closeDestory": true}
            arg.param = {"type": "miniProgram"}

            if(!app.changePage("/tabWindow", arg)) {
                return
            }
        }
    }

    FluPaneItemExpander {
        title: g_language.navPhone
        icon: FluentIcons.CellPhone

        FluPaneItem {
            title: g_language.navFloating
            icon: FluentIcons.Error
            onTapListener:function(){
                console.log("tap listener:", title)
            }
        }
        FluPaneItem {
            title: g_language.navFileTransfer
            icon: FluentIcons.Error
            onTapListener:function(){
                console.log("tap listener:", title)
            }
        }
    }

    FluPaneItemExpander {
        title: g_language.navSettingOther
        icon: FluentIcons.BulletedList

        FluPaneItem {
            title: g_language.navChannelsTool
            icon: FluentIcons.Error
            menuDelegate: paneItemMenu
            onTap: {
                console.log("tab click..")
            }
            onTapListener:function(){
                console.log("tap listener:", title)
            }
        }
        FluPaneItem {
            title: g_language.navMigrateAndBackup
            icon: FluentIcons.Error
            menuDelegate: paneItemMenu
            onTapListener:function(){
                console.log("tap listener:", title)
            }
        }
        FluPaneItem {
            title: g_language.navLock
            icon: FluentIcons.Error
            menuDelegate: paneItemMenu
            onTapListener:function(){
                app.lockClient({"closeDestory": true})
            }
        }
        FluPaneItem {
            title: g_language.navFeedback
            menuDelegate: paneItemMenu
            onTapListener:function(){
                console.log("tap listener:", title)
            }
        }
        FluPaneItem {
            title: g_language.navSettings
            menuDelegate: paneItemMenu
//            infoBadge:FluBadge{
//                count: 10
//            }
            onTapListener:function(){
                var arg = {}
                arg.properties = {"closeDestory": true}
                arg.param = {}

                app.changePage("/settings", arg)
            }
        }
    }

}
