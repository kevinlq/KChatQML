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
pragma Singleton

import QtQuick 2.11
import "./KTest"

QtObject {

    property string loginUserName : ""
    property string loginNickName : ""
    property string userUID : ""
    property string userCachePath : ""
    property string useAvatar: ""

    // follow is test data
    property KTestData tst: KTestData{}

    function getContactList(beginIndex, endIndex) {
        return tst.getContactList(beginIndex, endIndex)
    }
    function getChatContent(arg) {
        return tst.getChatContent(arg)
    }
    function getUserImage(userName){
        return tst.getUserImage(userName)
    }
    // end

    function debugUserInfo() {
        console.log("userName:", loginUserName)
        console.log("nickName:", loginNickName)
        console.log("uid:", userUID)
        console.log("cachePath:", userCachePath)

        tst.initTestData(loginUserName, loginNickName)
    }
}
