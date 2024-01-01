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

FluWindow {

    id: window
    appBar: KAppBar {
        iconSize: 16
        height: window.titleHeight
        textColor: window.titleTextColor
        buttonSize: Qt.size(34, window.titleHeight)
        title: window.title
        showDark: window.showDark
        showClose: window.showClose
        showMinimize: window.showMinimize
        showMaximize: window.showMaximize
        showStayTop: window.showStayTop

        width: window.width
    }
    loadingItem: null
    showStayTop: false
    color: g_theme.windowBackgroundColor
    borderItem: null

    property int titleHeight: 26
    property color titleTextColor: g_theme.windowTextColor
    backgroundColor: {
        if(active){
            return g_theme.windowActiveBackgroundColor
        }
        return g_theme.windowBackgroundColor
    }

    function initialize(arg){
        return true
    }
    function themeChanged(arg){
    }
    function languageChanged(arg) {
    }
}
