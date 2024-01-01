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
import QtQuick.Layouts 1.3
import FluentUI 1.0
import "./.../../../Component"

KPopup {
    id: control

    closePolicy: Popup.CloseOnEscape | Popup.CloseOnPressOutside
    property string type: "groupChat"
    width: 250
    height: 600

    onActiveFocusChanged: {
        if(!activeFocus) {
            control.close()
        }
    }

    Component.onCompleted: {
        _switchModel.clear()
        _switchModel.append(getSwitchModel())
    }

    ListModel {
        id: _chatModel
    }
    ListModel {
        id: _switchModel
    }

    Flickable {
        clip: true
        boundsBehavior:Flickable.StopAtBounds
        ScrollBar.vertical: ScrollBar {}
        anchors.fill: parent
        contentHeight: _layout.implicitHeight
        contentWidth: parent.width

        ColumnLayout {
            id: _layout
            //Layout.preferredHeight: childrenRect.height
            //Layout.fillWidth: true
            //Layout.fillHeight: true
            width: parent.width

            KTextBox {
                id: _searchText
                text: ""
                placeholderText: g_language.groupSearchMember
                Layout.preferredHeight: 30
                Layout.fillWidth: true
                Layout.topMargin: 24
                Layout.leftMargin: 24
                Layout.rightMargin: 24
            }

            Flow {
                id: _chatList
                layoutDirection: Qt.LeftToRight
                spacing: 20
                Layout.fillWidth: true
                Layout.topMargin: 24
                Layout.leftMargin: 18
                Layout.maximumHeight: 270
                Repeater {
                    model: _chatModel
                    KImageButton {
                        icon {
                            source: model.icon
                            height: 38
                            width: 40
                            color: "transparent"
                        }
                        width: 46
                        height: 56
                        display: AbstractButton.TextUnderIcon
                        text: model.name
                    }
                }
            }
            //查看更多
            KTextButton {
                id: _scanMoreBtn
                text: g_language.groupShowMore
                cursorShape: Qt.PointingHandCursor
                Layout.topMargin: 12
                Layout.leftMargin: 18
                Layout.alignment: Qt.AlignHCenter
                backgroundNormalColor: "transparent"
                backgroundPressedColor: backgroundNormalColor
                backgroundHoverColor: backgroundNormalColor
                onClicked: {
                }
            }

            // 分割线
            Rectangle {
                Layout.preferredHeight: 1
                Layout.fillWidth: true
                Layout.topMargin: 10
                Layout.leftMargin: 18
                Layout.rightMargin: 18
                color: g_theme.skinComColor.divColor
            }

            ColumnLayout {
                Layout.topMargin: 24
                Layout.leftMargin: 18
                //Layout.preferredWidth: parent.width - 16 - 24
                width: parent.width
                KText {
                    text: g_language.groupName
                }
                KTextBox {
                    cleanEnabled: false
                    text: "相亲相爱一家人"
                    background: Rectangle {
                        color: "transparent"
                    }
                    leftPadding: 0
                    enabled: false
                }
                KText {
                    text: g_language.groupNotice
                }
                KTextBox {
                    cleanEnabled: false
                    text: "发布后会通知全体群成员"
                    background: Rectangle {
                        color: "transparent"
                    }
                    leftPadding: 0
                    enabled: false
                }
                KText {
                    text: g_language.remark
                }
                KTextBox {
                    cleanEnabled: false
                    text: ""
                    placeholderText: g_language.remarkPlaceText
                    background: Rectangle {
                        color: "transparent"
                    }
                    leftPadding: 0
                    enabled: false
                }
                KText {
                    text: g_language.aliasInGroup
                }
                KTextBox {
                    cleanEnabled: false
                    text: "帅气小伙"
                    placeholderText: ""
                    background: Rectangle {
                        color: "transparent"
                    }
                    leftPadding: 0
                    enabled: false
                }
                Rectangle {
                    Layout.fillWidth: true
                    Layout.topMargin: 18
                    Layout.preferredHeight: 1
                    color: g_theme.skinComColor.divColor
                }
                Item {
                    Layout.fillWidth: true
                    Layout.topMargin: 18
                    Layout.minimumHeight: 14
                    KText {
                        text: g_language.chatHistory
                        anchors.verticalCenter: parent.verticalCenter
                    }
                    KIcon {
                        iconSource: FluentIcons.ChevronRight
                        iconSize: 14
                        anchors {
                            right: parent.right
                            rightMargin: 18
                            verticalCenter: parent.verticalCenter
                        }
                    }
                    MouseArea {
                        anchors.fill: parent
                        cursorShape: Qt.PointingHandCursor
                        acceptedButtons: Qt.LeftButton
                        onClicked: {
                            console.log("click..")
                        }
                    }
                }

                Rectangle {
                    Layout.fillWidth: true
                    Layout.topMargin: 18
                    Layout.bottomMargin: 10
                    Layout.preferredHeight: 1
                    color: g_theme.skinComColor.divColor
                }

                Repeater {
                    model: _switchModel
                    Item {
                        Layout.fillWidth: true
                        Layout.preferredHeight: 30
                        visible: itemVisible
                        KText {
                            text: itemText
                            anchors {
                                verticalCenter: parent.verticalCenter
                                left: parent.left
                            }
                        }
                        KToggleSwitch {
                            text: ""
                            checked: itemChecked
                            anchors {
                                verticalCenter: parent.verticalCenter
                                right: parent.right
                                rightMargin: 18
                            }
                        }
                    }
                }
                Rectangle {
                    Layout.preferredHeight: 1
                    Layout.fillWidth: true
                    Layout.topMargin: 10
                    //Layout.leftMargin: 18
                    Layout.rightMargin: 18
                    color: g_theme.skinComColor.divColor
                }

                KTextButton {
                    Layout.topMargin: 18
                    Layout.alignment: Qt.AlignHCenter
                    text: g_language.clearChatHistory
                    backgroundNormalColor: "transparent"
                    backgroundPressedColor: backgroundNormalColor
                    backgroundHoverColor: backgroundNormalColor
                    normalColor: g_theme.skinComColor.confimeTextColor
                }
                Rectangle {
                    Layout.preferredHeight: 1
                    Layout.fillWidth: true
                    Layout.topMargin: 18
                    //Layout.leftMargin: 18
                    Layout.rightMargin: 18
                    color: g_theme.skinComColor.divColor
                }
                KTextButton {
                    text: g_language.exitGroupChat
                    Layout.topMargin: 18
                    Layout.bottomMargin: 18
                    Layout.alignment: Qt.AlignHCenter
                    backgroundNormalColor: "transparent"
                    backgroundPressedColor: backgroundNormalColor
                    backgroundHoverColor: backgroundNormalColor
                    normalColor: g_theme.skinComColor.confimeTextColor
                }
            }
        }
    }

    Component {
        id: _divLine
        Rectangle{
            color: "#ececec"
            height: 1
            width: parent.width
        }
    }

    function getSwitchModel(){
        var itemModel = [
                    {"itemId": "showGroupName","itemText": g_language.showGrpupNickNames, "itemChecked": true, "itemVisible": true},
                    {"itemId": "muteNotification","itemText": g_language.disturbMessage, "itemChecked": false, "itemVisible": true},
                    {"itemId": "collapseChat","itemText": g_language.collapseGroupChat, "itemChecked": false, "itemVisible": false},
                    {"itemId": "pinnedChat","itemText": g_language.pinnedChat, "itemChecked": false, "itemVisible": true},
                    {"itemId": "saveToContacts","itemText": g_language.save2AddressBook, "itemChecked": true, "itemVisible": true},
                ]
        return itemModel
    }

    function initialize(arg) {
        _chatModel.clear()

        var groupInfo = arg.groupInfo

        _searchText.visible = groupInfo.length >= 2

        groupInfo.push({"name": "添加", "uid": "abcdssdsd", "icon": "./../Config/Theme/images/contact/add.svg"})
        if(arg.administrator) {
            groupInfo.push({"name": "移除", "uid": "abcdssdsd", "icon": "./../Config/Theme/images/contact/remove.svg"})
        }

        _chatModel.append(groupInfo)

        for(var i = 0; i < _switchModel.count; i++) {
            var modelObj = _switchModel.get(i)

            var itemId = modelObj.itemId
            var itemChecked = false, itemVisible = true
            switch(itemId)
            {
            case "showGroupName":       itemChecked = arg.showGroupName;  break
            case "muteNotification":    itemChecked = arg.muteNotification;  break
            case "collapseChat": {
                itemChecked = arg.collapseChat
                itemVisible = groupInfo.length > 30
                break
            }
            case "pinnedChat":          itemChecked = arg.pinnedChat;  break
            case "saveToContacts":      itemChecked = arg.saveToContacts;  break
            }
            modelObj.itemChecked = itemChecked
            modelObj.itemVisible = itemVisible
            _switchModel.set(i, modelObj)
        }

        control.forceActiveFocus()
        control.open()
    }
}
