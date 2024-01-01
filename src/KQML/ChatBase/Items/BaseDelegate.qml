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
import FluentUI 1.0
import com.kevinlq.kchat 1.0

KChatItem {
    id: _backItem

    property string m_fontFamily: "Microsoft YaHei"
    property int m_msgMargin: 10
    property var m_msgPaddings: [46, 28, 46, 1]

    property bool sendMsg : 0 !== model.isSend
    property var msgContent: model.content

    objectName: "baseDelegate"
    itemColor: sendMsg ? g_theme.skinChat.itemBackColor1 : g_theme.skinChat.itemBackColor2
    color: "#00000000"
    width: _listView.width*0.7
    height: 40
    radius: 8
    borderWidth: 1
    borderColor: sendMsg ? g_theme.skinChat.itemBorderColor1: g_theme.skinChat.itemBorderColor2
    hoverColor: sendMsg ? g_theme.skinChat.itemBackHoverColor1 : g_theme.skinChat.itemBackHoverColor2
    nickNameColor: g_theme.skinChat.nickNameTextColor
    x: sendMsg ? (_listView.width - _backItem.width - m_msgMargin) : m_msgMargin
    y: 0
    paddings: [sendMsg ? 0 : m_msgPaddings[0], m_msgPaddings[1], sendMsg ? -m_msgPaddings[2] : m_msgPaddings[3], m_msgPaddings[3]]
    alignment: sendMsg ? Qt.AlignRight : Qt.AlignLeft
    font.family: m_fontFamily
    font.pixelSize: 12
    chartItemType: model.type
    nickName: model.nickName
    avatarPath: getAvatarImg(model.talker)

    onContentClicked: function (info) {
        var clickPos = info.pos
        var button = info.button
        var hitTitle = info.hitTitle
        var hitContent = info.hitContent

        var selectText = getSelectText()
        var rMenuArgs = {"itemType": chartItemType, "hitTitle": hitTitle, "selectText": selectText}

        if(Qt.LeftButton === button) {
            if (hitTitle) {
                var itemView = _listView.itemAtIndex(index)
                var iParam = {
                    "pos": itemView.mapToItem(app, clickPos.x, clickPos.y),
                    "info": {}
                }
                window.showUserInfoPop(iParam)
                return
            }
            else if (hitContent) {
                if(KChatItem.PictureMsg === chartItemType) {
                    var arg = {}
                    arg.properties = {}
                    arg.param = {msgContent}
                    app.changePage("/imgPreview", arg)
                }
            }

            updateSelectText("clear")
            _listView.forceActiveFocus()
        }
        else if (Qt.RightButton === button) {
            if (hitTitle) {
                chatView.showRightMenu(rMenuArgs)
                return
            }
            if (!hitContent) {
                return
            }
            if(KChatItem.TextMsg === chartItemType && "" === selectText) {
                updateSelectText("selectAll")
                selectText = getSelectText()
            }
            chatView.showRightMenu(rMenuArgs)
        }
    }

    function getSelectText() {
        return ""
    }
    function updateSelectText(arg){
    }
}
