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
import Qt.labs.qmlmodels 1.0
import QtQuick.Layouts 1.3
import FluentUI 1.0
import com.kevinlq.kchat 1.0

import "./../ChatBase/Items"
import "./../Component"
import "./../Config"

Item
{
    id: chatView
    Component.onCompleted:
    {
    }

    property size avatarSize: Qt.size(36, 36)
    property string chatTitleName: ""
    property var chatInfos: ({})

    QtObject {
        id: d
        // 空消息
        property bool emptyMessage: true
        property bool showEmptyTip: false
    }

    Rectangle {
        id: _background
        color: FluTheme.dark ? Qt.rgba(46/255, 46/255, 46/255, 1) : Qt.rgba(243/255,243/255,243/255,1)
        anchors.fill: parent
        FluIcon {
            anchors.centerIn: parent
            iconSize: 54
            iconSource: FluentIcons.LockFeedback
            iconColor: FluTheme.dark ? FluColors.Grey110 : FluColors.Grey40
            visible: d.emptyMessage
        }
    }

    // 聊天名称
    Item {
        id: _topTitleItem
        width: parent.width
        height: 34
        visible: !d.emptyMessage
        anchors {
            left: parent.left
            leftMargin: 0
            top: parent.top
            topMargin: 22
        }
        KText {
            text: chatView.chatTitleName
            font.pixelSize: 16
            anchors {
                left: parent.left
                leftMargin: 16
                verticalCenter: parent.verticalCenter
            }
        }
        KIconButton {
            anchors {
                right: parent.right
                rightMargin: 6
                verticalCenter: parent.verticalCenter
            }
            cursorShape: Qt.PointingHandCursor
            iconSize: 12
            width: 24
            height: 24
            iconSource: FluentIcons.More
            text: "聊天信息"
            onClicked: {
                showChatInfo()
            }
        }

        // 分割线
        Rectangle {
            width: parent.width
            height: 1
            anchors {
                left: parent.left
                bottom: parent.bottom
            }
            color: FluTheme.dark ? Qt.rgba(39/255,39/255,39/255,1) : "#e7e7e7"
        }
    }

    SplitView {
        anchors {
            left: parent.left
            top: _topTitleItem.bottom
            topMargin: 0
        }
        width: parent.width
        height: parent.height - _topTitleItem.height
        orientation: Qt.Vertical
        handle: Rectangle {
            width: parent.width
            implicitHeight: 2
            color: FluTheme.dark ?FluColors.Grey120 : "#d6d6d6"
        }

        Item {
            implicitHeight: 480 // important

            SplitView.minimumHeight: 200
            Layout.minimumHeight: 200
            Layout.maximumHeight: parent.height*0.5
            Layout.fillWidth: true
            KListView {
                id: _listView
                anchors {
                    left: parent.left
                    top: parent.top
                    topMargin: 2
                    right: parent.right
                    bottom: parent.bottom
                    bottomMargin: 10
                }
                interactive: true
                clip: true
                spacing: 20
                scrollRightMargin: 3
                delegate: _chooser
                DelegateChooser {
                    id: _chooser
                    role: "type"
                    DelegateChoice { roleValue: KChatItem.TextMsg;         delegate: _textDelegate}
                    DelegateChoice { roleValue: KChatItem.PictureMsg;      delegate: _pictureDelegate }
                    DelegateChoice { roleValue: KChatItem.EmoticonsMsg;    delegate: _emoticonsDelegate}
                    DelegateChoice { roleValue: KChatItem.VoiceMsg;        delegate: _voiceDelegate}
                    DelegateChoice { roleValue: KChatItem.VideoMsg;        delegate: _videoDelegate }
                    DelegateChoice { roleValue: KChatItem.QuoteMsg;        delegate: _quoteDelegate }
                    DelegateChoice { roleValue: KChatItem.WithdrawMsg;     delegate: _withdrawDelegate }
                }
                onFlickStarted: {
                    if(contentY<0)
                    {
                        //console.log("下拉刷新")
                    }
                }
                onFlickEnded: {
                    if(contentY < 1)
                    {
                        //console.log("下拉刷新")
                    }
                }
            }
        }

        // 输入框以及工具按钮
        Item {
            id: _bottomItem
            width: parent.width
            implicitHeight: 140
            visible: !d.emptyMessage

            Layout.fillWidth: true
            Layout.minimumHeight: 130
            SplitView.minimumHeight: 120

            ColumnLayout {
                id: _inputTopToolLayout
                width: parent.width
                height: parent.height
                anchors {
                    left: parent.left
                    leftMargin: 0
                    top: parent.top
                    topMargin: 4
                }
                spacing: 6

                Item {
                    id:_inputTopTools
                    Layout.preferredHeight: 24
                    Layout.fillWidth: true
                    ListModel {
                        id: _lButtonModel
                        ListElement {buttonName: "表情(Alt+E)"; iconSouce: FluentIcons.Emoji2 ;shortcut: "Alt+E"; runFun: "emoticons"}
                        ListElement {buttonName: "发送文件"; iconSouce: FluentIcons.FolderOpen ;shortcut: ""; runFun: "sendFile"}
                        ListElement {buttonName: "截图(Alt+A)"; iconSouce: FluentIcons.Touchscreen ;shortcut: "Alt+A"; runFun: "screenshot"}
                        ListElement {buttonName: "聊天记录"; iconSouce: FluentIcons.Message ;shortcut: ""; runFun: "chatRecord"}
                    }
                    ListModel {
                        id: _rButtonModel
                        ListElement {buttonName: "直播"; iconSouce: FluentIcons.Record ;shortcut: ""; runFun: "emoticons"}
                        ListElement {buttonName: "语音聊天"; iconSouce: FluentIcons.Microphone ;shortcut: ""; runFun: "voiceChat"}
                    }
                    Row {
                        anchors {
                            left: parent.left
                            leftMargin: 24
                            verticalCenter: parent.verticalCenter
                        }
                        spacing: 4
                        Repeater {
                            model: _lButtonModel
                            KIconButton {
                                text: model.buttonName
                                iconSource: model.iconSouce
                                iconSize: 16
                                cursorShape: Qt.PointingHandCursor
                                width: 28
                                height: 28
                                onClicked: {
                                    console.log("run fun:", model.runFun)
                                }
                            }
                        }
                    }
                    Row {
                        anchors {
                            right: parent.right
                            rightMargin: 24
                            verticalCenter: parent.verticalCenter
                        }
                        spacing: 4
                        Repeater {
                            model: _rButtonModel
                            KIconButton {
                                text: model.buttonName
                                iconSource: model.iconSouce
                                iconSize: 16
                                cursorShape: Qt.PointingHandCursor
                                width: 24
                                height: 24
                                onClicked: {
                                    console.log("run fun:", model.runFun)
                                }
                            }
                        }
                    }
                }

                Flickable {
                    id:scrollview
                    clip: true
                    Layout.fillHeight: true
                    Layout.fillWidth: true
                    Layout.rightMargin: 24
                    //Layout.preferredWidth: parent.width - 24
                    //Layout.preferredHeight: parent.height - _inputTopTools.height - _sendMsgItem.height - 40
                    contentHeight: _inputMsgEdit.implicitHeight
                    boundsBehavior: Flickable.StopAtBounds
                    ScrollBar.vertical: ScrollBar {
                        policy: ScrollBar.AsNeeded
                        interactive: true
                    }
                    bottomMargin: 0

                    // input
                    KTextBox {
                        id: _inputMsgEdit
                        width: scrollview.width
                        anchors.fill: parent
                        leftPadding: 24
                        rightPadding: 10
                        topPadding: 2
                        bottomPadding: 2
                        cleanEnabled: false
                        background: Rectangle {
                            color: FluTheme.dark ?FluColors.Grey120 : "#f5f5f5"
                        }
                    }
                }

                Item {
                    id: _sendMsgItem
                    Layout.fillWidth: true
                    Layout.preferredHeight: 28
                    Layout.topMargin: 10
                    Layout.bottomMargin: 10
                    KTextButton {
                        id: _sendMsgButton
                        width: 100
                        height: 26
                        normalColor: g_theme.skinListView.textColor
                        anchors {
                            right: parent.right
                            rightMargin: 24
                            bottom: parent.bottom
                            bottomMargin: 10
                        }
                        display: Button.TextOnly
                        text: g_language.chatSendText
                        cursorShape: Qt.PointingHandCursor
                        KToolTip {
                            id: _sendToolTip
                            text: g_language.chatSendEmptyTip
                        }
                        Shortcut {
                            sequences: ["return", "enter"]
                            enabled: _listView.visible
                            onActivated: {
                                _sendMsgButton.clicked()
                            }
                        }
                        onClicked: {
                            if(_inputMsgEdit.text === "") {
                                _sendToolTip.visible = true
                                return
                            }
                            sendNewMessage(_inputMsgEdit.text)
                            _inputMsgEdit.text = ""
                        }
                    }
                }
                Item {
                    Layout.preferredHeight: 10
                    Layout.fillWidth: true
                }
            }
        }
    }

    Loader {
        id: _chatInfoPop
        source: "./KChatInfoPop.qml"
        visible: false
        active: false
        width: 250
        height: chatView.height
    }
    KChatRightMenu {
        id: _chatMenu
    }

    function showChatInfo() {
        _chatInfoPop.x = chatView.width - _chatInfoPop.width
        _chatInfoPop.y = _topTitleItem.y + _topTitleItem.height
        _chatInfoPop.active = true
        _chatInfoPop.visible = true

        var userName = _chatView.chatInfos.userName
        var groupMembers = [
                    {"name": _chatView.chatInfos.nickName, "userName": userName,"icon": "./../" +KGlHelp.getUserImage(userName)}
                ]
        var param = {
            "groupInfo": groupMembers,
            "administrator": true,
            "groupName": "相亲相爱一家人",         //  群名字
            "groupNotify": "本群通知信息如下：", // 群通知
            "remark": "备注信息",               // 备注
            "AliasName": KGlHelp.loginNickName,              // 我在本群的名字
            "showGroupName": true,              // 显示群成员昵称
            "muteNotification": true,           // 消息免打扰
            "pinnedChat": true,                // 置顶聊天
            "collapseChat": true,              // 折叠聊天
            "saveToContacts": true,             // 保存到通讯录
        }
        _chatInfoPop.item.initialize(param)
    }

    function showRightMenu(arg){
        _chatMenu.initialize(arg)
    }

    Component {
        id: _textDelegate
        TextDelegate {
        }
    }
    Component {
        id: _pictureDelegate
        PictureDelegate {}
    }
    Component {
        id: _emoticonsDelegate
        EmoticonsDelegate {}
    }
    Component{
        id: _voiceDelegate
        VoiceDelegate {}
    }
    Component{
        id: _videoDelegate
        VideoDelegate {}
    }
    Component{
        id: _quoteDelegate
        QuoteDelegate {}
    }
    Component{
        id: _withdrawDelegate
         WithdrawDelegate{}
    }

    function switchChatContent(arg){
        _listView.listModel.clear()
        d.emptyMessage = false
        _chatView.chatInfos = arg
        chatView.chatTitleName = arg.userName

        var sResult = KGlHelp.getChatContent(arg)
        var resultObj = JSON.parse(sResult)
        var ret = resultObj["baseResponse"]["ret"]
        if(0 !== ret) {
            console.error("request content fail.", sResult)
            return
        }

        var contactList = resultObj["contactList"]
        chatView.chatTitleName = resultObj["chatName"]
        _listView.listModel.append(contactList)
    }

    function sendNewMessage(msg) {
        var msgItem = {"type": KChatItem.TextMsg, "isSend": 1,"content": msg, "talker": KGlHelp.loginUserName, "nickName": KGlHelp.loginNickName}

        _listView.listModel.append(msgItem)
        _listView.positionViewAtIndex(_listView.listModel.count - 1, ListView.Beginning)
    }
    function getAvatarImg(userName) {
        return KGlHelp.getUserImage(userName)
    }
}
