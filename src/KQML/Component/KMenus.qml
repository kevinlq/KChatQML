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
import Qt.labs.platform 1.1

KMenu {
    id: mainMenu
    property var menuModel: []
    property var menuItems: []
    property bool fixWidth: true

    onMenuModelChanged: {
        mainMenu.clearAllItems()
        createMenuItems(mainMenu, menuModel)
    }

    function createMenuItems(menu, modelData) {
        if(!modelData) {
            return false
        }

        var itemWidths = []
        for(var i = 0; i < modelData.length; i++) {
            var itemData = modelData[i]
            var itemType = itemData.itemType
            var itemName = itemData.itemName
            var itemEnable = itemData.itemEnable
            var itemChecked = itemData.itemChecked
            var itemFun = itemData.itemFun
            var item = null
            if("menuItem" === itemType) {
                item = createComponent("./KMenuItem.qml", mainMenu.parent, {})
            }
            else if ("separator" === itemType){
                item = createComponent("./KMenuSeparator.qml", mainMenu.parent, {})
            }
            else if ("menu" === itemType) {
                var subMenu = createComponent("./KMenu.qml", menu, {})
                subMenu.title = itemName
                createMenuItems(subMenu, itemData.childs)
                menu.insertMenu(i, subMenu)
                menuItems.push(subMenu)
                itemWidths.push(subMenu.contentWidth)
            }
            if(null === item || !item) {
                continue
            }
            item.text = itemName
            item.objectName = itemFun
            item.menuTriggered.connect(mainMenu.onTriggered)
            itemWidths.push(item.contentWidth)

            menuItems.push(item)
            menu.insertItem(i, item)
        }

        if(!fixWidth) {
            var maxWidth = Math.max(...itemWidths)
            preferredWidth = 80
            if(maxWidth > (preferredWidth + leftPadding + rightPadding)) {
                preferredWidth = maxWidth + leftPadding + rightPadding
            }
        }
    }

    function clearAllItems() {
        while (mainMenu.count > 0) {
            mainMenu.takeItem(0)
        }

        for(var m in menuItems) {
            var item = menuItems[m]
            if(item) {
                item.destroy()
                item = null
            }
        }
        menuItems = []
    }

    function createComponent(url, parent,properties) {
        var component = Qt.createComponent(url, Component.PreferSynchronous, parent)
        if (component.status !== Component.Ready) {
            log.error("Error loading component:", component.status, component.errorString(), url);
            return null
        }
        return component.createObject(parent,properties)
    }
    function onTriggered(menuName, menuItem) {
        console.log("item trgg:", menuName, menuItem.objectName ,menuItem)
    }
}
