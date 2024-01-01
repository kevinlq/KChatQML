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
    pageNamge: "shortcut"
    textWidth: 108
    leftMargion: 20
    listView.spacing: 20

    apiMap: {
        "sendMsgShortcut": changeSendMsgShortcut,
        "screenshot": changeScreenshot,
        "openChatShortcut": changeOpenChatShortcut,
        "lockChatShortcut": changeLockChatShortcut,
        "checkShortcutConflicts": checkShortcutConflicts,
        "resetDefaultSet": resetDefaultSet
    }

    Component.onCompleted: {
    }

    function initialize(arg) {
        initModel()
    }
    function changeSendMsgShortcut(index,obj, modelData, param) {
        console.log("msg :", index)
    }
    function changeScreenshot(index,obj, modelData, param) {
        console.log("msg :", index)
    }
    function changeOpenChatShortcut(index,obj, modelData, param) {
        console.log("msg :", index)
    }
    function changeLockChatShortcut(index,obj, modelData, param) {
        console.log("msg :", index)
    }
    function checkShortcutConflicts(index,obj, modelData, param) {
        console.log("msg :", index)
    }
    function resetDefaultSet(index,obj, modelData, param) {
        console.log("msg :", index)
    }

}
