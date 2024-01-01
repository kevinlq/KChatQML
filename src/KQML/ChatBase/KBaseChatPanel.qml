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
  Chat tab base class component. Chat, address book, and collection pages inherit this component to achieve personalization.
*/
import QtQuick 2.15
import QtQuick.Controls 2.4
import QtQuick.Layouts
import FluentUI 1.0
import com.kevinlq.kchat 1.0
import "./../Component"

KPage
{
    id: control
    property int listViewSpacing: 0
    property int listViewWidth: 250

    property color color0: FluTheme.dark ? Qt.rgba(55/255,55/255,55/255,1) : "#f3f3f3"
    property color color1: FluTheme.dark ? Qt.rgba(59/255,59/255,59/255,1) : "#f3f3f3"

    property int searchBtnSouce: FluentIcons.SpeechSolidBold
    property Component topDelegate: _topCom
    property Component contentDelegate: _contentCom
    property alias listView: _userListView
    property url url: ""

    Component.onCompleted: {
    }

    Item {
        id: _leftItem
        width: control.listViewWidth
        height: parent.height
        Rectangle {
            //border.width: 1
            //border.color: FluTheme.dark ? FluTheme.primaryColor :"#d6d6d6"
            anchors.fill: parent
            gradient: Gradient {
                GradientStop {  position: 0.0;    color: control.color0 }
                GradientStop {  position: 1.0;    color: control.color1 }
            }
        }
        Rectangle {
            width: 1
            height: parent.height
            //color: FluTheme.dark ? FluColors.Grey120 :"#d6d6d6"
            color: FluTheme.dark ? Qt.rgba(39/255,39/255,39/255,1) : "#e5e5e5"
            anchors {
                right: parent.right
                rightMargin: 0
                top: parent.top
                topMargin: 0
            }
        }

        ColumnLayout {
            spacing: 0
            width: parent.width
            height: parent.height
            anchors {
                left: parent.left
                leftMargin: 0
                top: parent.top
                topMargin: 24
            }
            FluLoader {
                id: _topItem
                sourceComponent: topDelegate
                Layout.preferredWidth: parent.width-1
                Layout.preferredHeight: 40
            }
            KListView {
                id: _userListView
                Layout.fillHeight: true
                Layout.fillWidth: true
                spacing: control.listViewSpacing
                width: parent.width
            }
        }
    }
    FluLoader {
        id: _contentLoader
        sourceComponent: contentDelegate
        height: parent.height
        width: parent.width - control.listViewWidth
        anchors {
            left: _leftItem.right
            leftMargin: 0
            top: parent.top
            topMargin: 0
        }
    }

    Component {
        id: _topCom
        Item {
            width: control.listViewWidth
            height: 40
            KRectangle {
                color: FluTheme.dark ? Qt.rgba(61/255,61/255,61/255,1) : Qt.rgba(243/255,243/255,243/255,1)
                width: parent.width-1
                height: parent.height-1
                anchors {
                    left: parent.left
                    leftMargin: 1
                    top: parent.top
                    topMargin: 1
                }
            }
            KTextBox {
                id: _searchBox
                placeholderText: g_language.searchText
                width: 190
                height: 26
                font.pixelSize: 12
                anchors {
                    left: parent.left
                    leftMargin: 10
                    verticalCenter: parent.verticalCenter
                }
            }
            KIconButton {
                id: _addButton
                width: 26
                height: 26
                iconSize: 14
                iconSource: control.searchBtnSouce
                normalColor: FluTheme.dark ?FluColors.Grey120 : "#e2e2e2"
                hoverColor: FluTheme.dark ? FluColors.Grey130 :"#d1d1d1"
                text: g_language.addFriendsText
                visible: control.searchBtnSouce != -1
                iconLeftMargin: 0
                iconTextSpacing: 0
                cursorShape: Qt.PointingHandCursor
                anchors {
                    right: parent.right
                    rightMargin: 10
                    verticalCenter: parent.verticalCenter
                }
                onClicked: {
                    console.log("click....", pressX, pressY)
                }
            }
        }
    }
    Component {
        id: _contentCom
        Item {
        }
    }

    Component{
        id: _listDelegate
        KBaseListDelegate {
            width: parent.width
            height: rowItemHeight

            FluImage {
                id: _chatThumb
                source: "qrc:/KQML/Config/Theme/logo.jpg"
                width: 40
                height: 40
                anchors {
                    left: parent.left
                    leftMargin: 10
                    topMargin: 10
                    verticalCenter: parent.verticalCenter
                }
            }

            FluText {
                id: _chartName
                text: model.chatName
                elide: Text.ElideRight
                verticalAlignment: Qt.AlignVCenter
                font.pixelSize: 12
                font.family: "Microsoft YaHei"
                anchors {
                    left: _chatThumb.right
                    leftMargin: 8
                    top: _chatThumb.top
                    topMargin: 1
                }
            }
            FluText {
                id : _lastMsgTime
                text: model.msgTime
                font.pixelSize: 9
                color: FluColors.Grey120
                anchors {
                    right: parent.right
                    rightMargin: 24
                    top: _chatThumb.top
                    topMargin: 1
                }
            }
            FluText {
                id: _lastMsg
                text: model.lastMsg
                font.pixelSize: 9
                color: FluColors.Grey120
                anchors {
                    left: _chartName.left
                    bottom: _chatThumb.bottom
                    bottomMargin: 1
                }
            }
        }
    }

    function switchChatContent(args) {
        _contentLoader.active = true
        _contentLoader.visible = true
        if(_contentLoader.item) {
            return _contentLoader.item.switchChatContent(args)
        }
        return -1
    }
}
