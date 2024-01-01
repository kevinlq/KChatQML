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
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15
import "./../Component"
import "./../Config"

KWindow
{
    id: loginWindow
    title: g_language.loginTitle
    titleTextColor: g_theme.skinLogin.normalLabelTextColor
    width: 280
    height: 380
    fixSize: true
    showClose: true
    showDark: false
    showMinimize: false
    showMaximize: false
    showStayTop: false
    appBar: LoginAppBar {
        iconSize: 16
        height: loginWindow.titleHeight
        width: loginWindow.width
        textColor: loginWindow.titleTextColor
        buttonSize: Qt.size(34, loginWindow.titleHeight)
        title: loginWindow.title
        showDark: loginWindow.showDark
        showClose: loginWindow.showClose
        showMinimize: loginWindow.showMinimize
        showMaximize: loginWindow.showMaximize
        showStayTop: loginWindow.showStayTop
        showSetting: true
    }

    property var apiMap: {
        "changeAccount": changeAccount, "transFile": onlyTransFile,
        "setting": settingClicked,
        "login":loginProcess,
        "autoLogin": autoLogin
    }

    Component.onCompleted: {
        // init test data
        KGlHelp.loginUserName = "wxid_1024"
        KGlHelp.loginNickName = "kevinlq"
        KGlHelp.userCachePath = SettingsHelper.userCachePath()
        KGlHelp.useAvatar = "Config/Theme/images/contact/" + KGlHelp.loginUserName + ".png"

        KGlHelp.debugUserInfo()
    }

    QtObject {
        id: d
        property string lastPageName: ""
        readonly property string autoLoginPage: "autoLogin"
        readonly property string qrCodePage: "qrCodeLogin"
        readonly property string settingPage: "settingPage"
        readonly property string logining: "logining"

        property var pageModel: {
            "autoLogin": {"url": "./../Login/AutoLoginPage.qml"},
            "qrCodeLogin": {"url": "./../Login/ScanQRCodePage.qml"},
            "settingPage": {"url": "./../Login/SettingPage.qml"},
            "logining": {"url": "./../Login/LoginIngPage.qml"}
        }
    }

    KStackLayout {
        id: _pageLayout
        currentIndex: 0
        clip: true
        anchors.fill: parent
    }

    function initialize(arg){
        var type = "autoLogin"
        if(arg.hasOwnProperty(type)) {
            type = arg.type
        }
        if( !d.pageModel.hasOwnProperty(type)) {
            type = d.autoLoginPage
        }
        changePage(type)

        return true
    }

    function languageChanged(arg) {
        for(var i = 0; i < _pageLayout.count; i++) {
            var page = _pageLayout.itemAt(i)
            page.languageChanged(arg)
        }
    }
    function changePage(name) {
        var url = d.pageModel[name].url
        var pageItem = _pageLayout.activeItem(url)
        if(null === pageItem) {
            console.error("not find page for:", name, url)
            return false
        }
        pageItem.initialize(null)
        pageItem.name = name
        return true
    }
    function getCurrentPage() {
        return _pageLayout.itemAt(_pageLayout.currentIndex)
    }

    function changeAccount(index, obj, param) {
        changePage(d.qrCodePage)
    }

    function onlyTransFile(index, obj, param) {
        return Qt.openUrlExternally("http://kevinlq.com/")
    }
    function settingClicked(index, obj, param) {
        var bSetting = Boolean(param)
        if(!bSetting) {
            d.lastPageName = getCurrentPage().name
            return changePage(d.settingPage)
        }
        else {
            return changePage(d.lastPageName)
        }
    }
    function loginProcess(index, obj, param) {
        changePage(d.logining)
    }
    function autoLogin(index, obj, param) {
        changePage(d.autoLoginPage)
    }

    function runFunction(sFun,index,obj, param){
        if(!loginWindow.apiMap.hasOwnProperty(sFun)) {
            console.error("not register api: ", sFun)
            return false
        }
        var fun = loginWindow.apiMap[sFun]
        return fun(index, obj, param)
    }
}
