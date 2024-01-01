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
import QtQuick.Controls 2.4
import Qt.labs.qmlmodels 1.0

import "./../Component"

BaseSetPage {

    id: control
    pageNamge: "common"
    apiMap: {
        "changeLanguage": changeLanguage,
        "changeTheme": changeTheme,
        "autoUpdate": autoUpdate,
        "autoStartAtBoot": autoStartAtBoot,
        "saveChatHistory": saveChatHistory,
        "showNetSearchHistory": showNetSearchHistory,
        "channelsNotify": channelsNotify,
        "adaptSysScaling": adaptSysScaling,
        "voiceAuto2Text": voiceAuto2Text,
        "chearChatHistory": chearChatHistory,
        "storageSpaceMgr": storageSpaceMgr
    }

    Component.onCompleted: {
    }

    function transComboxText(role) {
        switch (role) {
        case "ZH_CN":   return g_language.setSimplifiedChinese
        case "ZH_TW":   return g_language.setTraditionalChinese
        case "EN":      return g_language.setEnglish
        case "Dark":    return g_language.setThemeDark
        case "White":   return g_language.setThemeWhite
        case "Auto":    return g_language.setThemeAuto
        }
    }

    function initialize(arg) {
        initModel()

    }
    function changeLanguage(index,obj, modelData, param) {
        var name = param[obj.currentIndex]["roleValue"]
        return app.changeLanguage(name)
    }
    function changeTheme(index,obj, modelData, param) {
        var themeName = param[obj.currentIndex]["roleValue"]
        app.changeTheme(themeName)
    }
    function autoUpdate(index,obj, modelData, param) {
        console.log("msg :", index)
    }
    function autoStartAtBoot(index,obj, modelData, param) {
        console.log("msg :", index)
    }
    function saveChatHistory(index,obj, modelData, param) {
        console.log("msg :", index)
    }
    function showNetSearchHistory(index,obj, modelData, param) {
        console.log("msg :", index)
    }
    function channelsNotify(index,obj, modelData, param) {
        console.log("msg :", index)
    }
    function adaptSysScaling(index,obj, modelData, param) {
        console.log("msg :", index)
    }
    function voiceAuto2Text(index,obj, modelData, param) {
        console.log("msg :", index)
    }
    function chearChatHistory(index,obj, modelData, param) {
        console.log("msg :", index)
    }
    function storageSpaceMgr(index,obj, modelData, param) {
        console.log("msg :", index)
    }
}
