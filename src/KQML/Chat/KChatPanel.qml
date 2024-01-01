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

/*
  Chat tab page: Contains user list and chat listView window
*/
import QtQuick 2.15
import QtQuick.Controls 2.4
import QtQuick.Layouts 1.1
import FluentUI 1.0
import "./../Component"
import "./../ChatBase"
import "./../Config"

KBaseChatPanel
{
    id: chatPanel
    searchBtnSouce: FluentIcons.CalculatorAddition
    contentDelegate: _chartContentCom
    Component.onCompleted: {
        var sResult =  KGlHelp.getContactList(0, 20)
        var resultObj = JSON.parse(sResult)
        var ret = resultObj["baseResponse"]["ret"]
        var contactList = resultObj["contactList"]
        if(0 !== ret) {
            console.error("get contact fail.", ret, sResult)
            // TODO Pop tip
            return
        }

        listView.delegate = _userListDelegate
        listView.listModel.clear()
        listView.listModel.append(contactList)
    }

    Component{
        id: _userListDelegate
        KBaseListDelegate {
            id: control
            width: listView.width
            height: rowItemHeight

            KClipImage {
                id: _chatThumb
                source: getNickImage(model.userName)
                width: 40
                height: 40
                anchors {
                    left: parent.left
                    leftMargin: 10
                    topMargin: 10
                    verticalCenter: parent.verticalCenter
                }
            }

            // 聊天名称
            KText {
                id: _chartName
                text: model.nickName
                verticalAlignment: Qt.AlignVCenter
                font.pixelSize: 14
                anchors {
                    left: _chatThumb.right
                    leftMargin: 8
                    top: _chatThumb.top
                    topMargin: 1
                }
            }

            // 最后时间
            KText {
                id : _lastMsgTime
                text: convertTime(model.lastUpdateTime)
                font.pixelSize: 9
                color: FluTheme.dark ? FluColors.Grey50:FluColors.Grey140
                anchors {
                    right: parent.right
                    rightMargin: 24
                    top: _chatThumb.top
                    topMargin: 1
                }
            }

            // 最后一次消息发送者+消息
            RowLayout {
                id: lastMsgRow
                width: _disturbItem.visible ? parent.width*0.6 : parent.width*0.66
                anchors {
                    left: _chartName.left
                    bottom: _chatThumb.bottom
                    bottomMargin: 1
                }
                KText {
                    text: model.lastUser + "："
                    font.pixelSize: 10
                    color: FluTheme.dark ? FluColors.Grey50:FluColors.Grey140
                }
                KText {
                    id: _lastMsg
                    text: model.lastMsg
                    font.pixelSize: 10
                    color: FluTheme.dark ? FluColors.Grey50:FluColors.Grey140
                    Layout.fillWidth: true
                }
            }
            // 免打扰
            FluIcon {
                id: _disturbItem
                iconSource: FluentIcons.Mute
                iconSize: 10
                iconColor: FluTheme.dark ? FluColors.Grey50 : FluColors.Grey140
                visible:  1024 === model.type
                anchors {
                    right: _lastMsgTime.right
                    rightMargin: 0
                    bottom: lastMsgRow.bottom
                }
            }

            function itemClicked(mouse) {
                if(mouse.button === Qt.LeftButton) {
                    listView.currentIndex = index
                    listView.forceActiveFocus()
                    var arguments = {"userName": model.userName, "chatRoomId": model.chatRoomId, "nickName": nickName}
                    chatPanel.switchChatContent(arguments)
                }
                else if(mouse.button === Qt.RightButton) {
                    console.log("menu:")
                }
            }
            function itemDoubleClicked(mouse) {
                if(mouse.button === Qt.LeftButton) {
                    var arguments = {"userName": model.userName}
                    FluApp.navigate("/chatWindow", arguments)
                }
            }
        }
    }

    // 聊天页面: 根据不同用户动态加载
    Component{
        id: _chartContentCom
        ChatView {
            id: _chatView
            anchors.fill: parent
        }
    }

    function convertTime(timestamp, format){
        var ptDate = new Date(timestamp)
        return Qt.formatDateTime(ptDate, "yy/MM/dd")
    }
    function getNickImage(userName){
        return KGlHelp.getUserImage(userName)
    }
}
