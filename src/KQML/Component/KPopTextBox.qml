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
import QtQuick.Controls 2.15

Popup {
    id: popup

    closePolicy: Popup.CloseOnEscape | Popup.CloseOnPressOutside
    padding: 0
    margins: 0
    focus: true

    property string placeholderText: ""
    background: Item {
    }
    Overlay.modal: Item {
    }
    onOpened: {
        _textEdit.clear()
        _textEdit.forceActiveFocus()
    }
    contentItem: KTextBox {
        id: _textEdit
        placeholderText: popup.placeholderText
        width: parent.width-1
        height: parent.height-1

        onActiveFocusChanged: {
            if(!activeFocus) {
                popup.close()
            }
        }
    }
}
