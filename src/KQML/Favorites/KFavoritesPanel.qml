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
  Bookmark tab page
*/
import QtQuick 2.15
import QtQuick.Controls 2.4
import Qt.labs.qmlmodels 1.0
import FluentUI 1.0
import "./../Component"
import "./../ChatBase"

KBaseChatPanel {

    id: control

    listViewSpacing: 0
    searchBtnSouce: -1
    color0: FluTheme.dark ? Qt.rgba(55/255,55/255,55/255,1) : "#f7f7f7"
    color1: FluTheme.dark ? Qt.rgba(59/255,59/255,59/255,1) : "#f7f7f7"

    Component.onCompleted: {
        listView.delegate = chooser
        listView.listModel.clear()

        var testData = []
        testData.push({"type": "title","title": "新的朋友"})
        testData.push({"type": "item","title": "全部收藏", "icon": FluentIcons.GridView})
        testData.push({"type": "item","title": "最近使用" , "icon": FluentIcons.Recent})
        testData.push({"type": "item","title": "链接" , "icon": FluentIcons.Link})
        testData.push({"type": "item","title": "图片与视频" , "icon": FluentIcons.Picture})
        testData.push({"type": "item","title": "笔记" , "icon": FluentIcons.TreeFolderFolder})
        testData.push({"type": "item","title": "文件" , "icon": FluentIcons.OpenFolderHorizontal})
        testData.push({"type": "item","title": "音乐与音频" , "icon": FluentIcons.MusicNote})
        testData.push({"type": "item","title": "聊天记录" , "icon": FluentIcons.Message})
        testData.push({"type": "item","title": "定位" , "icon": FluentIcons.EndPoint})
        //testData.push({"type": "separator"})
        testData.push({"type": "tag","title": "标签" , "icon": FluentIcons.Tag})

        listView.listModel.append(testData)
    }

    QtObject {
        id: d
        property int rowItemHeight: 36
        property int iconSize: 14
        property int iconLeftPading: 10
    }

    DelegateChooser {
        id: chooser
        role: "type"
        DelegateChoice { roleValue: "title";        delegate : titleDelegate; }
        DelegateChoice { roleValue: "item";         delegate : noteDelegate; }
        DelegateChoice { roleValue: "tag";         delegate : tagDelegate; }
        DelegateChoice { roleValue: "tagChild";         delegate : tagChildDelegate; }
    }

    function addTagChild(bExpand){
        if(!bExpand)
        {
            for(var i = listView.listModel.count-1; i >= 0; i--) {
                if("tagChild" === listView.listModel.get(i).type) {
                    listView.listModel.remove(i)
                }
            }
            return
        }
        var tmpData = []
        for(var t = 0; t < 20; t++) {
            tmpData.push({"type": "tagChild","title": "编程" + t})
        }
        listView.listModel.append(tmpData)
    }

    Component {
        id: titleDelegate
        Item {
            width: listView.width
            height: d.rowItemHeight + 4
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
                            iconSource: FluentIcons.ExploreContentSingle
                            iconSize: 12
                            anchors.verticalCenter: parent.verticalCenter
                        }
                        KText {
                            text: "新建笔记"
                        }
                    }
                }
                onClicked:{
                    listView.forceActiveFocus()
                }
            }
        }
    }

    Component {
        id: noteDelegate
        Item {
            width: listView.width
            height: d.rowItemHeight
            KIconButton {
                iconSource: model.icon
                text: model.title
                iconSize: 14
                display: Button.TextBesideIcon
                width: parent.width
                onClicked: {
                    listView.forceActiveFocus()
                    console.log("click...", model.title)
                }
            }
        }
    }
    Component {
        id: tagDelegate
        Item {
            id: _tagControl
            width: listView.width
            height: d.rowItemHeight
            property bool expandItem: false

            KIconButton {
                iconSource: model.icon
                text: model.title
                iconSize: d.iconSize
                display: Button.TextBesideIcon
                width: parent.width
                KIconButton {
                    iconLeftMargin: 1
                    iconTextSpacing: 1
                    anchors {
                        right: parent.right
                        rightMargin: 12
                        verticalCenter: parent.verticalCenter
                    }
                    iconSize: 9
                    iconSource: _tagControl.expandItem ? FluentIcons.ChevronUpMed: FluentIcons.ChevronDownMed
                    onClicked: {
                        _tagControl.onTagItemClicked()
                    }
                }

                onClicked: {
                    _tagControl.onTagItemClicked()
                }
            }

            function onTagItemClicked() {
                listView.forceActiveFocus()
                _tagControl.expandItem = !_tagControl.expandItem
                addTagChild(_tagControl.expandItem)
            }
        }
    }

    Component {
        id: tagChildDelegate
        Item {
            id: _tagControl
            width: listView.width
            height: d.rowItemHeight
            KIconButton {
                text: model.title
                display: Button.TextOnly
                anchors.centerIn: parent
                anchors.fill: parent
                iconLeftMargin: iconTextSpacing + d.iconSize + d.iconLeftPading
                onClicked: {
                    listView.forceActiveFocus()
                }
            }
        }
    }

}
