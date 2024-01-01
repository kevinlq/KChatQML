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
 chat view right menu items
*/
import QtQuick 2.15
import com.kevinlq.kchat 1.0
import "./../Component"

KMenus {

    id: menuControl
    fixWidth: false

    function initialize(arg) {
        var itemType = arg.itemType
        var hitTitle = arg.hitTitle
        var selectText = arg.selectText

        var itemModel = []
        if(hitTitle) {
            itemModel = getUserTitleModel()
        }
        else {
            if(KChatItem.TextMsg === itemType) {
                if("" === selectText) {
                    itemModel = getTextModel()
                }
                else {
                    itemModel = getSelectTextModel()
                }
            }
            else if (KChatItem.PictureMsg === itemType) {
                itemModel = getPictureModel()
            }
            else if (KChatItem.VoiceMsg === itemType){
                itemModel = getVoiceModel()
            }
        }

        if(0 === itemModel.length) {
            console.error("model empty..")
            return
        }

        menuControl.menuModel = itemModel
        menuControl.popup()
    }

    function getUserTitleModel(){
        var itemModel = []
        itemModel.push(createItem(g_language.menuTickled, "tickled") )
        return itemModel
    }

    function getTextModel(){
        var itemModel = []
        itemModel.push(createItem(g_language.menuCopy, "copy") )
        itemModel.push(createItem(g_language.menuTranslate, "translate") )
        itemModel.push(createSeparator() )
        itemModel.push(createItem(g_language.menuForward, "forward") )
        itemModel.push(createItem(g_language.menuFavorites, "favorites") )
        itemModel.push(createItem(g_language.menuSelect, "selects") )
        itemModel.push(createItem(g_language.menuQuote, "quote") )
        itemModel.push(createItem(g_language.menuSearch, "search") )
        itemModel.push(createItem(g_language.menuStickyTop, "stickytop") )
        itemModel.push(createSeparator() )
        itemModel.push(createItem(g_language.menuDelete, "delete") )
        return itemModel
    }

    // 有文本选中时，右键数据
    function getSelectTextModel(){
        var itemModel = []
        itemModel.push(createItem(g_language.menuCopy, "copy") )
        itemModel.push(createItem(g_language.menuSelect, "selects") )
        itemModel.push(createItem(g_language.menuSearch, "search") )
        return itemModel
    }

    // 图片右键数据
    function getPictureModel() {
        var itemModel = []
        itemModel.push(createItem(g_language.menuCopy, "copy") )
        itemModel.push(createItem(g_language.menuEdit, "edit") )
        itemModel.push(createSeparator() )
        itemModel.push(createItem(g_language.menuForward, "forward") )
        itemModel.push(createItem(g_language.menuFavorites, "favorites") )
        itemModel.push(createItem(g_language.menuSelect, "selects") )
        itemModel.push(createItem(g_language.menuQuote, "quote") )
        itemModel.push(createSeparator() )
        itemModel.push(createItem(g_language.menuSaveas, "saveas") )
        itemModel.push(createItem(g_language.menuStickyTop, "stickytop") )
        itemModel.push(createSeparator() )
        itemModel.push(createItem(g_language.menuDelete, "delete") )
        return itemModel
    }

    // 三方app卡片
    function get3rdpartyCardModel() {
        var itemModel = []
        itemModel.push(createItem(g_language.menuSelect, "selects") )
        itemModel.push(createSeparator() )
        itemModel.push(createItem(g_language.menuOpenDefaultBrowser, "openWithBrowser") )
        itemModel.push(createSeparator() )
        itemModel.push(createItem(g_language.menuDelete, "delete") )
        return itemModel
    }

    // 语音
    function getVoiceModel() {
        var itemModel = []
        itemModel.push(createItem(g_language.menuSpeeech2Text, "speeech2Text") )
        itemModel.push(createSeparator() )
        itemModel.push(createItem(g_language.menuFavorites, "favorites") )
        itemModel.push(createItem(g_language.menuSelect, "selects") )
        itemModel.push(createItem(g_language.menuQuote, "quote") )
        itemModel.push(createSeparator() )
        itemModel.push(createItem(g_language.menuDelete, "delete") )
        return itemModel
    }

    // 视频
    function getVideoModel() {
        var itemModel = []
        itemModel.push(createItem(g_language.menuMutePlay, "mutePlay") )
        itemModel.push(createItem(g_language.menuCopy, "copy") )
        itemModel.push(createSeparator() )
        itemModel.push(createItem(g_language.menuForward, "forward") )
        itemModel.push(createItem(g_language.menuFavorites, "favorites") )
        itemModel.push(createItem(g_language.menuSelect, "selects") )
        itemModel.push(createItem(g_language.menuQuote, "quote") )
        itemModel.push(createSeparator() )
        itemModel.push(createItem(g_language.menuSaveas, "saveas") )
        itemModel.push(createItem(g_language.menuOpenFolder, "openFolder") )
        itemModel.push(createSeparator() )
        itemModel.push(createItem(g_language.menuDelete, "delete") )
        return itemModel
    }

    // 定位到原位置
    function getSourceLocationModel(){
        var itemModel = []
        itemModel.push(createItem(g_language.menuOriginalLocation, "originalLocal") )
        return itemModel
    }

    function createItem(itemName, sFun, enable = true){
        return {"itemType": "menuItem", "itemName": itemName, "itemEnable": enable, "itemChecked": false,"itemFun": sFun}
    }
    function createSeparator() {
        return {"itemType": "separator", "itemName": "", "itemEnable": true, "itemChecked": false, "itemFun": ""}
    }

    function onTriggered(menuName, menuItem) {
        console.log("item trgg:", menuItem.objectName)
    }
}
