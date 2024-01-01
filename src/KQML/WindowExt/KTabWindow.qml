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
import FluentUI 1.0
import "./../Component"

KWindow {
    id: tabWindow

    width: 1171
    height: 806
    minimumWidth: 580
    minimumHeight: 560
    titleHeight: 34
    appBar: null

    property int maxEqualWidth: 220
    property int minEqualWidth: 78
    property int appBarpreferredWidth: 160
    property var tabItemMap: ({})

    Component.onCompleted: {
        initDefaultData()
    }

    Item {
        anchors.fill: parent
        Rectangle {
            id: _backItem
            width: parent.width
            height: tabWindow.titleHeight
            color: "#ededed"
            anchors {
                left: parent.left
                top: parent.top
            }
        }

        RowLayout {
            width: parent.width
            height: _backItem.height
            spacing: 0
            Row {
                id: _updateButtons
                spacing: 4
                Layout.preferredHeight: 30
                Layout.leftMargin: 6
                Repeater {
                    model: ListModel {
                        id: _updateBtnModel
                        ListElement {itemText: "后退"; itemIcon: FluentIcons.ChevronLeft20; itemValue : "back"}
                        ListElement {itemText: "前进"; itemIcon: FluentIcons.ChevronRight20; itemValue : "forward"}
                        ListElement {itemText: "重新加载页面"; itemIcon: FluentIcons.Refresh; itemValue : "refresh"}
                    }
                    KIconButton {
                        text: itemText
                        iconSource: itemIcon
                        height: 25; width: 25
                        iconSize: 12
                        normalColor: "transparent"
                        onClicked: {
                            console.log("button click:", itemValue)
                        }
                    }
                }
            }
            KListView {
                id: _pageTabView
                orientation: ListView.Horizontal
                Layout.preferredHeight: 30
                Layout.preferredWidth: {
                    var equalWidth = tabWindow.maxEqualWidth * count
                    if (equalWidth > _backItem.width - tabWindow.appBarpreferredWidth - _updateButtons.width) {
                        equalWidth = tabWindow.minEqualWidth*count
                    }
                    return equalWidth
                }
                spacing: 2
                delegate: Item {
                    id: _itemDelegate
                    height: _pageTabView.height
                    width: Math.min(tabWindow.maxEqualWidth, _pageTabView.width/_pageTabView.count)
                    MouseArea{
                        id: _mouseHove
                        anchors.fill: parent
                        hoverEnabled: true
                        onClicked: {
                            changeTabPage(index, model.url)
                        }
                        onWheel: function(wheel){
                            if(wheel.angleDelta.y > 0) {
                                _pageTabView.hScroll.decrease()
                            }
                            else {
                                _pageTabView.hScroll.increase()
                            }
                        }
                        //drag.axis: Drag.XAxis
                        //drag.target: _itemDelegate
                    }
                    Rectangle {
                        anchors {
                            left: parent.left
                            right: parent.right
                            top: parent.top
                            topMargin: 1
                            bottom: parent.bottom
                            bottomMargin: 1
                        }
                        radius: 4
                        border.color: "#e6e7ea"
                        border.width: 2
                        color: {
                            if(_mouseHove.containsMouse || _btnClose.hovered || _pageTabView.currentIndex === index) {
                                return "#FFFFFF"
                            }
                            return "#ededed"
                        }
                    }
                    RowLayout {
                        anchors {
                            left: parent.left
                            leftMargin: 4
                            verticalCenter: parent.verticalCenter
                        }
                        KImage {
                            Layout.leftMargin: 6
                            //source: "../Config/Theme/images/programTitle.svg"
                            source: model.itemIcon
                            width: 16
                            height: 16
                        }
                        KText {
                            text: model.itemTitle
                            Layout.alignment: Qt.AlignVCenter
                        }
                    }
                    KIconButton {
                        id: _btnClose
                        height: 24
                        width: visible ? 24 : 0
                        iconSource: FluentIcons.ChromeClose
                        iconSize: 10
                        visible: (_mouseHove.containsMouse || _pageTabView.currentIndex === index)
                        anchors {
                            right: parent.right
                            rightMargin: 5
                            verticalCenter: parent.verticalCenter
                        }
                        onClicked: {
                            closeTabPage(index, model.url)
                        }
                    }
                }
            }
            KAppBar {
                id: _app_bar
                Layout.preferredHeight: tabWindow.titleHeight
                Layout.preferredWidth: tabWindow.appBarpreferredWidth
                Layout.minimumWidth: tabWindow.appBarpreferredWidth
                Layout.fillWidth: true
                Layout.leftMargin: 20
                iconSize: 16
                textColor: tabWindow.titleTextColor
                buttonSize: Qt.size(34, tabWindow.titleHeight)
                showStayTop: tabWindow.showStayTop
            }
        }
        KStackLayout {
            id: _contentLayout
            width: parent.width
            height: parent.height - _backItem.height
            anchors {
                left: parent.left
                top: _backItem.bottom
                right: parent.right
                bottom: parent.botton
            }
        }
    }

    function initDefaultData(){
        tabItemMap.miniProgram =    {"itemTitle": g_language.tabMiniProgram, "itemIcon": "../Config/Theme/images/tabProgramTitle.svg", "url": "./../WindowExt/KMiniProgramPage.qml"}
        tabItemMap.search =         {"itemTitle": g_language.tabSearch, "itemIcon": "../Config/Theme/images/tabSearchTitle.svg", "url": "./../WindowExt/KSearchPage.qml"}
        tabItemMap.stories =        {"itemTitle": g_language.tabStories, "itemIcon": "../Config/Theme/images/tabStoreesTitle.svg", "url": "./../WindowExt/KStoriesPage.qml"}
    }

    function initialize(arg) {
        var tabType = arg.type
        if(!tabItemMap.hasOwnProperty(tabType)){
            console.error("no register tab type:", tabType, " please register.")
            return false
        }
        var tabItemModel = tabItemMap[tabType]
        var tabIndex = -1
        var url = ""
        for(var i = 0; i < _pageTabView.listModel.count; i++) {
            var modelObj = _pageTabView.listModel.get(i)
            if(tabItemModel.itemTitle === modelObj.itemTitle) {
                tabIndex = i
                url = modelObj.url
                break
            }
        }
        if(-1 === tabIndex) {
            _pageTabView.listModel.append(tabItemModel)
            url = tabItemModel["url"]
            tabIndex = _pageTabView.count -1
        }
        return changeTabPage(tabIndex, url)
    }

    function changeTabPage(tabIndex, url) {
        _pageTabView.currentIndex = tabIndex
        return _contentLayout.activeItem(url)
    }
    function closeTabPage(tabIndex, url){
        _contentLayout.removeItem(url)
        _pageTabView.listModel.remove(tabIndex, 1)

        // update active index
        for(var i = 0; i < _pageTabView.listModel.count; i++) {
            var modelObj = _pageTabView.listModel.get(i)
            changeTabPage(i, modelObj.url)
            break
        }
        if(0 === _pageTabView.count) {
            tabWindow.close()
        }
    }
}
