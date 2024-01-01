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

QtObject {
    id: testRoot
    // the follow is test table data.
    property TMessage tMsg : TMessage{}
    property TContact tContact: TContact{}
    property TImage tImg: TImage{}

    property var wTables: []
    property var tMessages : []
    property var tImage: []
    property var contactList: []

    property var nickNames: ["李白", "杜甫", "李商隐", "杜牧", "贺知章","白居易", "王昌龄", "高适", "李頎", "張籍",
        "元稹", "苏轼", "张九龄", "欧阳旭", "刘禹锡", "祖咏", "温庭筠", "李清照", "晏殊", "张若虛"
    ]

    Component.onCompleted: {
    }

    function initTestData(loginUserName,loginNickName){

        tImg.userName = loginUserName
        tImg.imgFlag = 0
        tImg.lastUpdateTime = tContact.lastUpdateTime
        tImg.location = "/Config/Theme/images/contact/" + loginUserName + ".png"
        tImage.push(tImg.toObj())

        for(var i = 1; i < 20; i++) {
            var userName = "wxid_" + i
            var nickName = nickNames[i]
            var chatRoomId = 1024 + i

            var tmpMsgs = [
                        {"content": "你好 " + loginNickName, "type": 1, "isSend": 0},
                        {"content": "你好" + nickName, "type": 1, "isSend": 1},
                        {"content": "吾乃时光旅者，今日特来与君共饮，畅谈诗词之韵。", "type": 1, "isSend": 1},
                        {"content": "汝自何方来，欲与吾共饮？", "type": 1, "isSend": 0},
                        {"content": "吾来自遥远的未来，但对君之诗才深感敬佩。每读君之诗，心旷神怡，有如仙境。", "type": 1, "isSend": 1},
                        {"content": "吾诗乃情感所至，无拘无束。汝言如仙境，吾心甚慰。", "type": 1, "isSend": 0},
                        {"content": "君之诗才横溢，是否有诗篇遗失？", "type": 1, "isSend": 1},
                        {"content": "人生如梦，诗篇如云。虽有遗失，然留名者亦不少。吾不甚在意。", "type": 1, "isSend": 0},
                        {"content": "君之诗中常有仙境之感，是否曾遇仙人", "type": 1, "isSend": 1},
                        {"content": "仙人未曾遇，然心中有仙境。人生如梦，何需真。", "type": 1, "isSend": 0},
                        {"content": "./../../Config/Theme/images/contact/wxid_1024.png", "type": 2, "isSend": 1},
                    ]

            for(var m = 0; m < tmpMsgs.length; m++) {
                var msg = tmpMsgs[m]
                tMsg.id = chatRoomId
                tMsg.msgSvrId = Math.random() *(i + m)
                tMsg.type = msg.type
                tMsg.isSend = msg.isSend
                tMsg.talker = (1 === msg.isSend)? loginUserName: userName
                tMsg.content = msg.content
                tMessages.push(tMsg.toObj())
            }

            tContact.userName = userName
            tContact.nickName = nickName
            tContact.alias = ""
            tContact.type = 0
            tContact.lastUpdateTime = 1698757560000 + i*10
            tContact.chatRoomId = chatRoomId
            contactList.push(tContact.toObj())

            tImg.userName = userName
            tImg.imgFlag = 0
            tImg.lastUpdateTime = tContact.lastUpdateTime
            tImg.location = "/Config/Theme/images/contact/" + userName + ".png"
            tImage.push(tImg.toObj())
        }
    }

    function getContactList(beginIndex, endIndex) {
        // test  data
        var contactData = {
            "baseResponse": {
                "ret": 0,
                "errMsg": ""
            },
            "count": contactList.length,
            "contactList": contactList
        }
        return JSON.stringify(contactData)
    }
    function getChatContent(arg) {
        var contentResults = []
        var userName = arg.userName
        var chatRoomId = arg.chatRoomId

        for(var i = 0; i < tMessages.length; i++) {
            var msgObj = tMessages[i]
            if(chatRoomId === msgObj.id) {
                var tmpCont = msgObj
                tmpCont.nickName = findNickName(msgObj.talker)
                tmpCont.avatarImg = getUserImage(msgObj.talker)
                contentResults.push(msgObj)
            }
        }
        var resultObj = {
            "baseResponse": {
                "ret": 0,
                "errMsg": ""
            },
            "contactCount": contentResults.length,
            "contactList": contentResults,
            "chatName": findNickName(userName)
        }
        return JSON.stringify(resultObj)
    }
    function getUserImage(userName){
        for(var i = 0; i < tImage.length; i++) {
            if(userName === tImage[i].userName) {
                return tImage[i].location
            }
        }
        console.log("no find:", userName)
        return ""
    }

    function findNickName(userName){
        for(var i in contactList) {
            if(userName === contactList[i].userName) {
                return contactList[i].nickName
            }
        }
        return ""
    }
}
