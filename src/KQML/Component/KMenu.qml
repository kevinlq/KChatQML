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

FluMenu {
    id: mainMenu
    objectName: "menu"
    padding: 2
    delegate: KMenuItem { }

    property int preferredWidth: 80

    background: Rectangle {
        implicitWidth: mainMenu.preferredWidth
        implicitHeight: 26
        color: g_theme.skinComColor.menuBackgroundColor
        border.color: g_theme.skinComColor.menuBorderColor
        border.width: 1
        radius: 4
        KShadow{}
    }
}
