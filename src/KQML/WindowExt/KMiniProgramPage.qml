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
import Qt.labs.qmlmodels 1.0
import QtQuick.Layouts 1.3
import FluentUI 1.0
import "./ItemModelData.js" as ModelFun
import "./../Component"
import "./Items"


KBaseTabPage {

    id: controlRoot
    property int leftMargin: width*0.16
    property int contentWidth: width*0.78

    Component.onCompleted: {
        // test data
        var itemData = []
        itemData.push({"itemType": "programTitle", "itemText": ""})
        itemData.push(ModelFun.getTopProgramData())

        itemData.push({"itemType": "title", "itemText": "电脑端常用"})
        itemData.push(ModelFun.getComUserPCData())

        itemData.push({"itemType": "title", "itemText": "为电脑端优化 >"})
        itemData.push(ModelFun.getOptimizedPCData())

        itemData.push({"itemType": "title", "itemText": "小游戏专区 >"})
        itemData.push(ModelFun.getGamesData())

        _listView.listModel.append(itemData)
    }

    KListView {
        id: _listView
        width: controlRoot.contentWidth
        anchors {
            left: parent.left
            right: parent.right
            top: parent.top
            topMargin: 34
            bottom: parent.bottom
            bottomMargin: 50
        }
        spacing: 20
        delegate: _chooser
    }

    DelegateChooser {
        id: _chooser
        role: "itemType"
        DelegateChoice { roleValue: "programTitle";                delegate: _programTitleDelegate}
        DelegateChoice { roleValue: "cardBriefProgram";     delegate: _cardBriefProgramDelegate}
        DelegateChoice { roleValue: "title";                delegate: titleDelegate}
        DelegateChoice { roleValue: "singlePrograms";       delegate: singleProgramDelegate }
        DelegateChoice { roleValue: "blocktemProgram";      delegate: blockItemDelegate }
    }

    Component {
        id: _programTitleDelegate
        Item {
            width: _listView.width
            height: 30
            KTextButton {
                text: "小程序"
                font.pixelSize: 14
                backgroundNormalColor: "transparent"
                backgroundHoverColor: backgroundNormalColor
                backgroundPressedColor: backgroundNormalColor
                anchors {
                    left: parent.left
                    leftMargin: controlRoot.leftMargin
                    verticalCenter: parent.verticalCenter
                }
            }
            KPopTextBox {
                id: _searchEdit
                height: parent.height
                visible: false
                focus: false
                placeholderText: "搜索小程序"
                x: (_searchBtn.x + _searchBtn.width) - 200
            }
            PropertyAnimation {
                id: _widthAnimation
                target: _searchEdit
                property: "width"
                from: 100
                to: 200
                duration: 400
                running: false
            }
            KIconButton {
                id: _searchBtn
                width: 24; height: 24
                iconSource: FluentIcons.Search
                cursorShape: Qt.PointingHandCursor
                anchors{
                    right: parent.right
                    rightMargin: controlRoot.leftMargin
                    verticalCenter: parent.verticalCenter
                }
                visible: !_searchEdit.visible
                onClicked: {
                    _searchEdit.open()
                    _widthAnimation.running = true
                }
            }
        }
    }

    Component {
        id: _cardBriefProgramDelegate
        Item {
            id: _briefItemRoot
            height: 130
            width: _listView.width
            property var childValues: []
            Component.onCompleted: {
                childValues = controlRoot.parseModel(model.itemValues)
                _briefRepeat.model = childValues
            }
            Row {
                spacing: 16
                anchors {
                    left: parent.left
                    leftMargin: controlRoot.leftMargin
                    right: parent.right
                    rightMargin: controlRoot.leftMargin
                    top: parent.top
                    bottom: parent.bottom
                }
                Repeater {
                    id: _briefRepeat
                    model: _briefItemRoot.childValues
                    ProgramCard {
                        title: _briefItemRoot.childValues[index].itemText
                        width: (parent.width - 16) / _briefRepeat.count
                        height: parent.height
                        cardModel: _briefItemRoot.childValues[index].itemValues
                    }
                }
            }
        }
    }

    Component {
        id: titleDelegate
        Item {
            height: 30
            width: _listView.width
            KTextButton {
                text: model.itemText
                font.pixelSize: 14
                backgroundNormalColor: "transparent"
                anchors {
                    left: parent.left
                    leftMargin: controlRoot.leftMargin
                    verticalCenter: parent.verticalCenter
                }
                onClicked: {
                    console.log("click...")
                }
            }
        }
    }

    Component {
        id: singleProgramDelegate
        Item {
            width: _listView.width
            height: 80* (model.itemValues.count / 10)
            ProgramItems {
                anchors {
                    left: parent.left
                    leftMargin: controlRoot.leftMargin
                    right: parent.right
                    rightMargin: controlRoot.leftMargin
                    top: parent.top
                    bottom: parent.bottom
                }
                _modelData: controlRoot.parseModel(model.itemValues)
            }
        }
    }
    // 227x127
    Component {
        id: blockItemDelegate
        Item {
            width: _listView.width
            height: 130* (model.itemValues.count / 5)
            ProgramItems {
                itemType: "blockItem"
                anchors {
                    left: parent.left
                    leftMargin: controlRoot.leftMargin
                    right: parent.right
                    rightMargin: controlRoot.leftMargin
                    top: parent.top
                    bottom: parent.bottom
                }
                _modelData: controlRoot.parseModel(model.itemValues)
            }
        }
    }
}
