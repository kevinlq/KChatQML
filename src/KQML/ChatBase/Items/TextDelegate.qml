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
import "./../../Component"

BaseDelegate
{
    id: _chatControl
    objectName: "textDelegate"

    //property int textMargin: 10

    /*!
      rectangle max width 70%
    */
    contentMsgWidth: Math.min(_textEdit.implicitWidth + m_msgMargin*2 + m_msgPaddings[0], width)
    height: _textEdit.implicitHeight + m_msgPaddings[1]-2

    // chart text msg
    KTextEdit {
        id: _textEdit
        width: contentMsgWidth - m_msgMargin - m_msgPaddings[0]
        height: Math.max(40, contentHeight)
        anchors {
            left: sendMsg ? undefined :parent.left
            leftMargin: sendMsg ? 0: m_msgPaddings[0]
            right: sendMsg ? parent.right : undefined
            rightMargin: sendMsg ? m_msgMargin + m_msgPaddings[2] : 0
            top: parent.top
            topMargin: m_msgPaddings[1]-2
        }
        text: msgContent
        readOnly: true

        color: g_theme.skinChat.itemTextColor
    }

    function getSelectText() {
        return _textEdit.selectedText
    }
    function updateSelectText(arg){
        switch(arg) {
        case "clear":       _textEdit.cancelSelectText();    break
        case "selectAll":   _textEdit.selectAll();          break
        default:    break
        }
    }
}
