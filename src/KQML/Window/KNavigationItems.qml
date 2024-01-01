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
import FluentUI 1.0
import "./../Config/Languages"

FluObject {

    property var navigationView: null
    property var paneItemMenu: null

    // 聊天页面
    FluPaneItem{
        id: _chats
        title: g_language.navItemChat
        icon:FluentIcons.ChatBubbles
        url:"./../Chat/KChatPanel.qml"
        onTap: {
            navigationView.push(url)
        }
    }

    // 通讯录
    FluPaneItem {
        id: _contastItem
        title: g_language.navContast
        icon: FluentIcons.ContactPresence
        url:"./../Contast/KContastPanel.qml"
        onTap: {
            navigationView.push(url)
        }
    }

    // 收藏
    FluPaneItem {
        id: _favoritesItem
        title: g_language.navFavorites
        icon: FluentIcons.DialShape3
        url:"./..//Favorites/KFavoritesPanel.qml"
        onTap: {
            navigationView.push(url)
        }
    }

    // 聊天文件
    FluPaneItem {
        id: _chatFilesItem
        title: g_language.navChatFiles
        icon: FluentIcons.FolderOpen
        onTapListener:function(){
            //FluApp.navigate("/about")
        }
    }

    // 朋友圈
    FluPaneItem {
        id: _momentsItem
        title: g_language.navMoments
        icon: FluentIcons.NetworkOffline
        onTapListener:function(){
            //FluApp.navigate("/about")
        }
    }

    // 视频号
    FluPaneItem {
        id: _channelsItem
        title: g_language.navChannels
        icon: FluentIcons.VideoChat
        onTapListener:function(){
            //FluApp.navigate("/about")
        }
    }

    // 看一看
    FluPaneItem {
        id: _topStoriesItem
        title: g_language.navTopStories
        icon: FluentIcons.EmojiSwatch
        onTapListener:function(){
            openTableWindow("stories")
        }
    }

    // 搜一搜
    FluPaneItem {
        id: _searchItem
        title: g_language.navSearch
        icon: FluentIcons.SearchAndApps
        menuDelegate: paneItemMenu
        onTapListener:function(){
            openTableWindow("search")
        }
    }

    function openTableWindow(type){
        var arg = {}
        arg.properties = {"closeDestory": true}
        arg.param = {"type": type}
        return app.changePage("/tabWindow", arg)
    }

}
