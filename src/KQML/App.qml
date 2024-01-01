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
import com.kevinlq.kchat 1.0
import "./Component"
import "./Config/KLog.js" as LogApi

Item{
    id: app

    property alias g_theme: _themeLoader.item
    property alias g_language: _languagesLoader.item
    property var log: LogApi

    Component.onCompleted: {
        log.initLevel(app, SettingsHelper.logInfo())
        var theme = SettingsHelper.themeType(d.defaultTheme)
        var language = SettingsHelper.language(d.defaultLanguage)

        changeLanguage(language)
        changeTheme(theme)


        FluApp.init(app)
        FluApp.useSystemAppBar = false
        FluTheme.darkMode = false
        FluTheme.enableAnimation = false

        d.registerRoute("/main", "./Window/MainWindow.qml", null)
        d.registerRoute("/login", "./Login/LoginWindow.qml", null)
        d.registerRoute("/lockWindow", "./Window/KLockWindow.qml", null)
        d.registerRoute("/settings", "./Settings/KSettingDialog.qml", null)
        d.registerRoute("/tabWindow", "./WindowExt/KTabWindow.qml", null)
        d.registerRoute("/imgPreview", "./Window/KImagePreviewWindow.qml", null)
        d.registerRoute("/test", "./Window/TestWindow.qml", null)

        var testWindow = "/login"
        //testWindow = "/settings"
        //testWindow = "/test"
        //testWindow = "/main"

        var arg = {}
        arg.properties = {"closeDestory": true}
        arg.param = {}
        var bResult = changePage(testWindow, arg)
        if(!bResult){
            log.error("init app window fail..")
            Qt.quit()
        }
    }
    Component.onDestruction: {
        d.destroyWindow()
    }

    QtObject {
        id: d
        property var routesInfo: []
        property string defaultTheme: "White"
        property string defaultLanguage: "ZH_CN"
        property int errorCount : 0

        function registerRoute(route, url, param){
            for(var i in d.routesInfo){
                if(route === d.routesInfo[i].route){
                    return false
                }
            }
            d.routesInfo.push({"route": route, "url": url, "param": param, "window": null})
            return true
        }
        function unRegisterRoute(route) {
            for(var i = d.routesInfo.length -1; i >=0; i--) {
                if(d.routesInfo[i] && route === d.routesInfo[i].route){
                    d.routesInfo.splice(i, 1)
                    return true
                }
            }
            return false
        }
        function hideAllItem() {
            for(var i in d.routesInfo) {
                var window = d.routesInfo[i].window
                if(!window) {
                    console.error("window invalid.", i, window)
                    continue
                }
                window.visible = false
            }
        }
        function createWindow(route, arg){
            console.log("change window begin :", route /*, JSON.stringify(arg)*/)
            var windowObj = null
            var properties = {}
            var param = arg.param
            if (arg.hasOwnProperty("properties")) {
                properties = arg.properties
            }

            for(var i in d.routesInfo) {
                var routeItem = d.routesInfo[i]
                if(route !== routeItem.route) {
                    continue
                }
                windowObj = routeItem.window
                if(null !== windowObj) {
                    break
                }
                windowObj = createComponent(routeItem.url, app, properties)
                if(null !== windowObj) {
                    windowObj._route = route
                    d.routesInfo[i].window = windowObj
                    windowObj.closing.connect(function onWindowClose(event){
                        if(event.accepted) {
                            for(var i in d.routesInfo){
                                if(windowObj._route === d.routesInfo[i].route){
                                    d.routesInfo[i].window = null
                                    break
                                }
                            }
                        }
                    })
                }
                break
            }
            if(null === windowObj) {
                log.error("Error create window:", route)
                return false
            }
            windowObj.show()
            windowObj.raise()
            windowObj.requestActivate()
            windowObj.initialize(param)
            console.log("change window end :", windowObj)

            return true
        }
        function destroyWindow (){
            for(var i = d.routesInfo.length-1; i >=0; i--) {
                var window = d.routesInfo[i].window
                if(window) {
                    window.destroy()
                    window = null
                }
            }
            d.routesInfo = []
        }
        function createComponent(url, parent,properties) {
            var component = Qt.createComponent(url, Component.PreferSynchronous, parent)
            if (component.status !== Component.Ready) {
                log.error("Error loading component:", component.errorString(), url);
                return null
            }
            return component.createObject(parent,properties)
        }
        function updateSubWindow(types, arg){
            for(var i in d.routesInfo) {
                var window = d.routesInfo[i].window
                if(!window) {
                    continue
                }
                if(-1 !== types.indexOf("themeChange")){
                    window.themeChanged(arg)
                }
                else if(-1 !== types.indexOf("languageChange")){
                    window.languageChanged(arg)
                }
            }
        }
    }

    KLoader {
        id: _themeLoader
    }
    KLoader {
        id: _languagesLoader
    }
    function changeTheme(themeName) {
        if(g_theme && themeName === g_theme.themeName) {
            return true
        }
        var sourceUrl = Qt.resolvedUrl("./Config/Theme/"+themeName + "Theme.qml")
        _themeLoader.source = sourceUrl
        if(_themeLoader.status !== Loader.Ready) {
            log.error("theme url invalid....", sourceUrl)
            if(d.errorCount > 2) {
                return false
            }
            d.errorCount++
            return changeTheme(d.defaultTheme)
        }

        SettingsHelper.setThemeType(themeName)
        var darkType = FluTheme.System
        if("Dark" === themeName) {
            darkType = FluTheme.darkMode
            FluTheme.darkMode = FluThemeType.Dark
        }
        else if ("White" === themeName) {
            darkType = FluTheme.Light
            FluTheme.darkMode = FluThemeType.Light
        }
        SettingsHelper.saveDarkMode(darkType)

        d.errorCount = 0
        log.info("change theme success.",themeName)
        d.updateSubWindow(["themeChange"], themeName)
        return true
    }
    function changeLanguage(lName) {
        if(g_language && lName === g_language.name) {
            return true
        }
        _languagesLoader.source = Qt.resolvedUrl("./Config/Languages/" + lName + ".qml")
        if(_languagesLoader.status !== Loader.Ready) {
            log.error("language url invalid....", lName)
            if(d.errorCount > 2) {
                return false
            }
            d.errorCount++
            return changeLanguage(d.defaultLanguage)
        }
        SettingsHelper.setLanguage(lName)
        d.errorCount = 0
        log.info("change theme success.", lName)

        d.updateSubWindow(["languageChange"], lName)
        return true
    }

    function changePage(route, arg) {
        return d.createWindow(route, arg)
    }
    function write2Log(level, msg) {
        return SettingsHelper.logOut(level, msg)
    }

    // 登出
    function logOut(arg){
        d.hideAllItem()
        return changePage("/login", arg)
    }

    // lock
    function lockClient(arg) {
        d.hideAllItem()
        return changePage("/lockWindow", arg)
    }
    function closeClient(){
        d.destroyWindow()

        // TODO Custome destroy for C++

        Qt.quit()
    }
}
