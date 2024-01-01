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
import "./../Component"
import "./ItemModelData.js" as ModelFun

KBaseTabPage {
    id: searchPageRoot
    Component.onCompleted: {
        _btnModel.append(ModelFun.getSearchTypeModel())
        changeSearchType(0)
    }

    KFlickable {
        anchors.fill: parent
        contentWidth: parent.width
        contentHeight: childrenRect.height
        ColumnLayout{
            width: parent.width*0.9
            anchors.horizontalCenter: parent.horizontalCenter
            Item {
                id: _titleItem
                Layout.preferredHeight: 50
                Layout.fillWidth: true
                Layout.topMargin: searchPageRoot.height*0.1
                Row {
                    anchors.centerIn: parent
                    spacing: 10
                    KImage {
                        width: 32; height: 32
                        source: "../Config/Theme/images/tabSearchTitle.svg"
                    }
                    KText {
                        text: g_language.tabSearch
                        font.pixelSize: 22
                    }
                }
            }
            Row {
                Layout.preferredHeight: 38
                Layout.alignment: Qt.AlignHCenter
                Layout.preferredWidth: 550
                spacing: 0
                KTextBox {
                    id: _searchText
                    height: 36
                    width: 400
                    placeholderText: g_language.searchText
                }
                KTextButton {
                    width: 90
                    height: 36
                    text: g_language.searchText
                    normalColor: g_theme.skinComColor.okTextColor
                    backgroundHoverColor: g_theme.skinComColor.backgroundHoverColor
                    backgroundNormalColor: g_theme.skinComColor.backgroundNormalColor
                    backgroundPressedColor: g_theme.skinComColor.backgroundPressedColor
                }
            }
            Row {
                spacing: 10
                Layout.alignment: Qt.AlignHCenter
                Layout.preferredWidth: 550
                ListModel {
                    id: _btnModel
                }
                Repeater {
                    model: _btnModel
                    Column{
                        spacing: 2
                        KTextButton {
                            text: model.itemText
                            normalColor: g_theme.skinComColor.normalLabelTextColor
                            pressedColor: g_theme.skinComColor.normalLabelTextColor
                            backgroundNormalColor: "transparent"
                            backgroundHoverColor: backgroundNormalColor
                            backgroundPressedColor: backgroundNormalColor
                            font.pixelSize: 14
                            onClicked: {
                                changeSearchType(index)
                            }
                        }
                        Rectangle {
                            width: parent.width
                            height: 1
                            color: "#07c160"
                            visible: d.searchTypeIndex === index
                        }
                    }
                }
            }
            Item {
                Layout.alignment: Qt.AlignHCenter
                Layout.preferredHeight: 26
                Layout.preferredWidth: 550
                Layout.topMargin: 40
                Row {
                    anchors.centerIn: parent
                    spacing: 8
                    Rectangle{
                        width: 120
                        height: 2
                        color: "#e5e5e5"
                        anchors.verticalCenter: parent.verticalCenter
                    }
                    KText {
                        text: g_language.tabItemSearchFind
                        width: 70
                        anchors.verticalCenter: parent.verticalCenter
                        color: g_theme.skinComColor.normalLabelTextColor
                        font.pixelSize: 14
                    }
                    Rectangle{
                        width: 120
                        height: 2
                        color: "#e5e5e5"
                        anchors.verticalCenter: parent.verticalCenter
                    }
                }
            }
            Flow {
                spacing: 20
                layoutDirection: Qt.LeftToRight
                Layout.alignment: Qt.AlignHCenter
                Layout.preferredWidth: 550
                padding: 10
                Repeater {
                    model: ListModel {
                        id: _hotInfoModel
                    }
                    KTextButton {
                        text: model.itemText
                        width: Math.max(200, implicitContentWidth)
                        backgroundNormalColor: "transparent"
                        normalColor: g_theme.skinComColor.tabItemTextColor
                        pressedColor: g_theme.skinComColor.tabItemTextColor
                        font.pixelSize: 14
                        onClicked: {
                        }
                    }
                }
            }
        }
    }

    QtObject {
        id: d
        property int searchTypeIndex: 0
    }

    function changeSearchType(itemIndex){
        d.searchTypeIndex = itemIndex
        var holderText = g_language.searchText
        var modelData = _btnModel.get(itemIndex)
        if(0 !== itemIndex) {
            holderText += modelData.itemText
        }
        _searchText.placeholderText = holderText
        _hotInfoModel.clear()
        _hotInfoModel.append(ModelFun.getHotInfoModel(modelData.itemValue))
    }
}
