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
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15
import QtQml.Models 2.15

import FluentUI 1.0

import "./../Component"
import "./../Config"
import "./KSetModelData.js" as ModelFunApi

KWindow {

    id: setWindow
    fixSize: true
    width: 550
    height: 470
    title: g_language.setWindowTitle
    color: g_theme.skinSetting.backgroundNormalColor
    backgroundColor: g_theme.skinSetting.backgroundNormalColor
    titleTextColor: g_theme.windowTextColor
    showMaximize: false

    Component.onCompleted: {
        d.initDefaultData()
        initModelData()
    }

    QtObject {
        id: d

        property var settingData: ({})
        property real buttonHeight: 30
        property int navPageIndex: 0
        property var sourceIconMap: {
            "NetworkOffline": FluentIcons.NetworkOffline, "VideoChat": FluentIcons.VideoChat,
            "EmojiSwatch": FluentIcons.EmojiSwatch, "SearchAndApps": FluentIcons.SearchAndApps,
            "undefined": -1
        }

        function initDefaultData() {
            var accountData = {"nickName": KGlHelp.loginNickName, "accountName": KGlHelp.loginUserName}
            d.settingData.accountData = accountData
        }
        function getNavButtonData() {
            var navButtons = [
                        {"itemTitle": g_language.setAccountSet, "name": "accountSet", "url": "./KAccountSet.qml"},
                        {"itemTitle": g_language.setMsgNotify, "name": "msgNotify", "url": "./KMessageNotifySet.qml"},
                        {"itemTitle": g_language.setCommonSet, "name": "commonSet", "url": "./KCommonSet.qml"},
                        {"itemTitle": g_language.setFileMgr, "name": "fileManager", "url": "./KFileManagerSet.qml"},
                        {"itemTitle": g_language.setShortcut, "name": "shortcut", "url": "./KShortcutSet.qml"},
                        {"itemTitle": g_language.setAboutChat, "name": "aboutChat", "url": "./KAboutSet.qml"}
                    ]
            return navButtons
        }
    }

    ListModel {
        id: _navBtnModel
    }

    Item {
        id: _navBtnPanel
        width: 95
        height: parent.height
        anchors {
            left: parent.left
            leftMargin: 4
            top: parent.top
            topMargin: 40
            bottom: parent.bottom
        }
        Rectangle {
            width: 1
            height: parent.height
            anchors {
                right: parent.right
                rightMargin: 0
                top: parent.top
                topMargin: 0
            }
            color: g_theme.skinSetting.divColor
        }
        Column {
            spacing: 0
            width: parent.width
            height: childrenRect.height
            Repeater {
                model: _navBtnModel
                Item {
                    height: d.buttonHeight
                    width: parent.width
                    KTextButton {
                        text: model.itemTitle
                        anchors.centerIn: parent
                        normalColor: checked? g_theme.skinSetting.checkColor :g_theme.skinSetting.normalColor
                        backgroundNormalColor: "transparent"
                        backgroundHoverColor: backgroundNormalColor
                        backgroundPressedColor: backgroundNormalColor
                        cursorShape: Qt.PointingHandCursor
                        height: 26
                        onClicked: {
                            setWindow.changePage(index)
                        }
                        checked: d.navPageIndex === index
                    }
                    Rectangle {
                        width: 2
                        height: parent.height
                        anchors {
                            right: parent.right
                            rightMargin: 0
                            verticalCenter: parent.verticalCenter
                        }
                        visible: index === d.navPageIndex
                        color: g_theme.skinSetting.checkColor
                    }
                }
            }
            WheelHandler {
                orientation: Qt.Vertical
                acceptedDevices: PointerDevice.Mouse | PointerDevice.TouchPad
                onWheel: function(wheel){
                    var tmpIndex = d.navPageIndex
                    if(wheel.angleDelta.y / 120 > 0) {
                        tmpIndex--
                        tmpIndex = Math.max(0, tmpIndex)
                    }
                    else {
                        tmpIndex++
                        tmpIndex = Math.min(_navBtnModel.count-1, tmpIndex)
                    }
                    setWindow.changePage(tmpIndex)
                }
            }
        }
    }

    StackLayout {
        id: _settingLayout
        height: parent.height - setWindow.height
        width: parent.width - _navBtnPanel.width
        anchors {
            left: _navBtnPanel.right
            top: _navBtnPanel.top
            leftMargin: 2
            right: parent.right
            bottom: parent.bottom
        }
        currentIndex: 0
        clip: true
        Repeater {
            model: ObjectModel {
                id: _container
            }
        }
    }
    KLoader {
        id: _msgDlgLoader
        source: "./KTipDialog.qml"
        active: false
        visible: false
        property var callback: null
        property var param: null

        function showTipDialog(title, content, callback, arg) {
            _msgDlgLoader.active = true
            _msgDlgLoader.visible = true
            _msgDlgLoader.item.title = title
            _msgDlgLoader.item.contentMsg = content
            _msgDlgLoader.callback = callback
            _msgDlgLoader.param = arg
            _msgDlgLoader.item.openDialog(arg)
        }
    }
    Connections {
        target: _msgDlgLoader.item
        function onButtonClicked(btnName) {
            var callback = _msgDlgLoader.callback
            var param = _msgDlgLoader.param
            if(callback) {
                callback(btnName, param)
            }
            callback = null
        }
    }


    function initModelData() {
        ModelFunApi.lan = g_language
        ModelFunApi.curLanguage = g_language.name
        ModelFunApi.curTheme = g_theme.themeName

        _navBtnModel.clear()
        _navBtnModel.append(d.getNavButtonData())
    }

    function initialize(arg){
        changePage(0)
    }
    function themeChanged(arg){
        ModelFunApi.curTheme = g_theme.themeName
        for(var i = 0; i < _settingLayout.count; i++) {
            var pageItem = _settingLayout.itemAt(i)
            pageItem.themeChanged(arg)
        }
    }
    function languageChanged(arg) {
        ModelFunApi.lan = g_language
        ModelFunApi.curLanguage = g_language.name

        var navButtons = d.getNavButtonData()
        for(var i = 0; i < _navBtnModel.count; i++){
            _navBtnModel.setProperty(i, "itemTitle", navButtons[i].itemTitle)
        }
        for(i = 0; i < _settingLayout.count; i++) {
            var pageItem = _settingLayout.itemAt(i)
            pageItem.languageChanged(arg)
        }
    }

    function changePage(pageIndex) {
        if (pageIndex < 0 || pageIndex >= _navBtnModel.count) {
            return false
        }
        d.navPageIndex = pageIndex
        var url = _navBtnModel.get(pageIndex).url
        var options = Object.assign({}, {url:url})

        var pageItem = findPage(url)
        if(null === pageItem ) {
            var comp = Qt.createComponent(url)
            if (comp.status !== Component.Ready) {
                console.error("Error loading component:", comp.errorString(), url);
                return false
            }
            pageItem  = comp.createObject(_settingLayout,options)
            pageItem.url = url
            pageItem.funApi = ModelFunApi
            _container.append(pageItem)
        }
        if(!pageItem) {
            return false
        }
        _settingLayout.currentIndex = pageItem.StackLayout.index
        return pageItem.initialize(d.settingData)
    }
    function findPage(url){

        for(var i = 0; i <_container.count; i++) {
            var pageItem = _container.get(i)
            if ( url === pageItem.url) {
                return pageItem
            }
        }
        return null
    }

    function convertSourceName(sName){
        if (!d.sourceIconMap.hasOwnProperty(sName)) {
            log.error("not find name:", sName)
            return -1
        }
        return d.sourceIconMap[sName]
    }

    function showMsgDialog(title, message, callback, param) {
        _msgDlgLoader.showTipDialog(title, message, callback, param)
    }
}
