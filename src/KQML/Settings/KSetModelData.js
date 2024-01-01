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

.pragma library

var lan = null
var curLanguage = "ZH_CN"
var curTheme = "White"

function getMsgNotifyData() {
    var itemModel = [
                {"id": "not_msgNotify",     "itemType": "title", "itemText": lan.setNotify, "checked": false},
                {"id": "not_newMsgAlert",   "itemType": "switchButton", "itemText": lan.setNewMsgAlert, "iconSource": "undefined" ,"checked": true, "fun": "newMsgNotify"},
                {"id": "not_voiceVideoAlert","itemType": "switchButton", "itemText": lan.setVoiceVideoAlert, "iconSource": "undefined" ,"checked": true, "fun": "voiceVideoNotify"},
                {"id": "not_notifyFlag",    "itemType": "title", "itemText": lan.setNotiftFlag, "checked": false},
                {"id": "not_momentsNotify", "itemType": "switchButton", "itemText": lan.setMomentsNotify, "iconSource": "NetworkOffline" ,"checked": true, "fun": "momentsNotify"},
                {"id": "not_channelsNotify","itemType": "switchButton", "itemText": lan.setChannelsNotify, "iconSource": "VideoChat" ,"checked": true, "fun": "channelsNotify"},
                {"id": "not_topSNotify",    "itemType": "switchButton", "itemText": lan.setTopStoriesNotify, "iconSource": "EmojiSwatch" ,"checked": true, "fun": "topStoriesNotify"},
                {"id": "not_miniProNotift", "itemType": "switchButton", "itemText": lan.setMiniProgramsNotify, "iconSource": "SearchAndApps" ,"checked": true, "fun": "appletsNotify"},
                {"id": "not_notifyFlag",    "itemType": "title", "itemText": lan.setNotiftFlagTip, "checked": false},
            ]
    return itemModel
}

function getCommonSetData() {
    var itemModel = [
                {"id": "com_lan","itemType": "textCombox", "itemText": lan.setLanguage, "itemValues": [
                        {"role": "ZH_CN", "roleValue": "ZH_CN"},{"role": "EN", "roleValue": "EN"}
                    ], "checkValue": curLanguage ,"fun": "changeLanguage"
                },
                {"id": "com_theme","itemType": "textCombox", "itemText": lan.setTheme, "itemValues": [
                        {"role": "White", "roleValue": "White"},{"role": "Dark", "roleValue": "Dark"},{"role": "Auto", "roleValue": "Auto"}
                    ], "checkValue": curTheme ,"fun": "changeTheme"
                },
                {"id": "com_general",       "itemType": "textCheckbox", "itemText": lan.setGeneral, "itemValue": lan.setAutoUpdateChat,"checked": true, "fun": "autoUpdate"},
                {"id": "com_autoStart",     "itemType": "textCheckbox", "itemText": "",     "itemValue": lan.setAutoStartAtBoot,"checked": false, "fun": "autoStartAtBoot"},
                {"id": "com_saveCHistory",  "itemType": "textCheckbox", "itemText": "",     "itemValue": lan.setSaveChatHistory,"checked": true, "fun": "saveChatHistory"},
                {"id": "com_showWSHistory", "itemType": "textCheckbox", "itemText": "",     "itemValue": lan.setShowWebSearchHistory,"checked": true, "fun": "showNetSearchHistory"},
                {"id": "com_adaptSysScale", "itemType": "textCheckbox", "itemText": "",     "itemValue": lan.setAdaptSysScaling,"checked": true, "fun": "adaptSysScaling"},
                {"id": "com_defaultBrowser","itemType": "textCheckbox", "itemText": "",     "itemValue": lan.setUseDefaultBrowser,"checked": true, "fun": "useDefaultBrowser"},
                {"id": "com_voice2Text",    "itemType": "textCheckbox", "itemText": "",     "itemValue": lan.setVoiceAuto2Text,"checked": true, "fun": "voiceAuto2Text"},
                {"id": "com_clearHistory",  "itemType": "textButton", "itemText": "",       "itemValue": lan.setChearChatHistory, "fun": "chearChatHistory"},
                {"id": "com_mgrStorage",    "itemType": "textButton", "itemText": "",       "itemValue": lan.setManagerStorage, "fun": "storageSpaceMgr"},
            ]
    return itemModel
}
function getFileManagerData() {
    var itemModel = [
                {"id": "fmr_fileSet",       "itemType": "textCheckbox", "itemText": lan.setFileSet, "itemValue": lan.setEnableautoDownloadFile,"checked": false, "fun": "enableautoDownloadFile"},
                {"id": "fmr_readonlyOCF",   "itemType": "textCheckbox", "itemText": "",    "itemValue": lan.setReadonlyOpenChatFile, "checked": true, "fun": "readonlyOpenChatFile"},
                {"id": "fmr_filemgr",       "itemType": "textEdit", "itemText": lan.setFileMgr,"itemValue": "C:/Users/user/Document/KChatFiles/","tipText": lan.setChatFileDefaultDirect, "height": 70},
                {"id": "fmr_empty",         "itemType": "textButtons", "itemText": "",  "itemValues": [
                        {"itemText": lan.setChangeFolder,"fun": "changeFolder"}, {"itemText": lan.setOpenFolder, "fun": "openFolder"}]
                },
            ]
    return itemModel
}
function getShortcutData() {
    var itemModel = [
                {"id": "sct_sendMsg",   "itemType": "textCombox", "itemText": lan.setSendMessage, "itemValues": [
                        {"role": "Enter", "roleValue": "true"},{"role": "Ctrl + Enter", "roleValue": "false"}
                    ], "fun": "sendMsgShortcut"
                },
                {"id": "sct_takeScreen",    "itemType": "textButton", "itemText": lan.setTakeScreenshot,  "itemValue": "Alt + A", "fun": "screenshot"},
                {"id": "sct_openChat",      "itemType": "textButton", "itemText": lan.setOpenChat,  "itemValue": "Ctrl + Alt + W", "fun": "openChatShortcut"},
                {"id": "sct_lockChat",      "itemType": "textButton", "itemText": lan.setLockChat,  "itemValue": "Ctrl + L", "fun": "lockChatShortcut"},
                {"id": "sct_ckShortcuts",   "itemType": "textCheckbox", "itemText": lan.setCheckShortcuts,    "itemValue": lan.setShortcutAlreadySet,"checked": true, "fun": "checkShortcutConflicts"},
                {"id": "sct_restoreDeft",   "itemType": "textButton", "itemText": "",  "itemValue": lan.setRestoreDefault, "fun": "resetDefaultSet"},
            ]
    return itemModel
}
function getAboutData() {
    var itemModel = [
                {"itemType": "text", "itemText": lan.setUpdateInfo, "itemValue": "微信 1.0.0.0", "tipText": "","height": 30},
                {"itemType": "textButton", "itemText": "",  "itemValue": lan.setCheckUpdate, "fun": "checkUpdate"},
                {"itemType": "textButton", "itemText": lan.setChatHelp,  "itemValue": lan.setViewHelp, "fun": "viewHelp"},
            ]
    return itemModel
}

function getModelData(page) {
    switch(page) {
    case "msgNofify":       return getMsgNotifyData()
    case "common":          return getCommonSetData()
    case "fileManager":     return getFileManagerData()
    case "shortcut":        return getShortcutData()
    case "about":           return getAboutData()
    default:                return []
    }
}
