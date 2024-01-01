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

/*!
  Address book tab page
*/
import QtQuick 2.15
import Qt.labs.qmlmodels 1.0
import QtQuick.Layouts 1.1
import FluentUI 1.0

import "./../Component"
import "./../ChatBase"

KBaseChatPanel {

    Component.onCompleted: {
        listView.delegate = chooser
        listView.listModel.clear()

        var testData = [
                    {"itemType": "manager","itemText": g_language.ctManageContacts},
                    {"itemType": "title","itemText": g_language.ctNewFriends},
                    {"itemType": "item","itemText": g_language.ctNewFriends},
                    {"itemType": "separator"},
                    {"itemType": "title","itemText": g_language.ctStared},
                    {"itemType": "item","itemText": "张三"},
                    {"itemType": "item","itemText": "李四"},
                    {"itemType": "separator"},

                    {"itemType": "title","itemText": g_language.ctOfficalAccounts},
                    {"itemType": "item","itemText": g_language.ctOfficalAccounts},
                    {"itemType": "separator"},

                    {"itemType": "title","itemText": g_language.ctEnterpriseAccount},
                    {"itemType": "item","itemText": g_language.ctEnterpriseAccount},
                    {"itemType": "separator"},

                    {"itemType": "title","itemText": g_language.ctSavedGroups},
                    {"itemType": "item","itemText": "相亲相爱一家人"},
                    {"itemType": "separator"},
                ]

        testData.push({"itemType": "title","itemText": "A"})
        for(var i = 0; i < 10; i++) {
            testData.push({"itemType": "item","chatName": "A(" + i + ")", "lastMsg": "好的", "msgTime": "16:20"},)
        }
        testData.push({"itemType": "separator"})

        listView.listModel.append(testData)
    }

    QtObject {
        id: d
        property int iconSize: 14
        property int iconLeftPading: 10
    }

    DelegateChooser {
        id: chooser
        role: "itemType"
        DelegateChoice { roleValue: "manager";        delegate : managerDelegate; }
        DelegateChoice { roleValue: "title";        delegate : titleDelegate; }
        DelegateChoice { roleValue: "separator";    delegate : _separatorDelegate; }
        DelegateChoice { roleValue: "item";         delegate : _listDelegate; }
    }

    // 通讯录管理
    Component {
        id: managerDelegate
        Item {
            width: listView.width
            height: 45
            KIconButton {
                normalColor: FluTheme.dark ? FluTheme.itemNormalColor :"#ffffff"
                width: parent.width - 20
                height: parent.height - 12
                anchors.centerIn: parent
                contentItem: Item {
                    Row {
                        spacing: 6
                        anchors.centerIn: parent
                        FluIcon {
                            iconSource: FluentIcons.SpeechSolidBold
                            iconSize: 12
                            anchors.verticalCenter: parent.verticalCenter
                        }
                        KText {
                            text: model.itemText
                        }
                    }
                }
                onClicked:{
                }
            }
        }
    }

    // title
    Component {
        id: titleDelegate
        Item {
            width: listView.width
            height: 18
            Rectangle {
                anchors.fill: parent
                color: {
                    if(control.__itemHovered && index !== listView.currentIndex) {
                        return FluTheme.dark ? Qt.rgba(50/255,50/255,50/255,1) :"#dedbda"
                    }
                    if(FluTheme.dark ) {
                       return (index === listView.currentIndex) ? Qt.rgba(55/255,55/255,55/255,1) : Qt.rgba(39/255,39/255,39/255,1)
                    }
                    return (index === listView.currentIndex) ? "#c7c5c4" : "#e5e5e5"
                }
            }
            FluText {
                text: model.itemText
                font.pixelSize: 11
                color: FluTheme.dark ? FluColors.Grey10 :FluColors.Grey100
                anchors {
                    left: parent.left
                    leftMargin: 12
                    top: parent.top
                    topMargin: 4
                }
            }
        }
    }

    // 分割
    Component {
        id: _separatorDelegate
        Rectangle {
            width: listView.width
            height: 1
            color: FluTheme.dark ? FluColors.Grey140 :"#dbdad9"
        }
    }

    Component {
        id: _listDelegate
        KBaseListDelegate {
            width: listView.width
            height: rowItemHeight

            FluImage {
                id: _chatThumb
                source: "qrc:/KQML/Config/Theme/logo.jpg"
                width: 40
                height: 40
                anchors {
                    left: parent.left
                    leftMargin: 12
                    topMargin: 10
                    verticalCenter: parent.verticalCenter
                }
            }
            KText {
                id: _chartName
                text: model.itemText
                verticalAlignment: Qt.AlignVCenter
                font.pixelSize: 13
                anchors {
                    left: _chatThumb.right
                    leftMargin: 8
                    verticalCenter: _chatThumb.verticalCenter
                }
            }
        }
    }

}
