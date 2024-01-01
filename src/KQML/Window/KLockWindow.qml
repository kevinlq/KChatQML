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

import QtQuick 2.11
import QtQuick.Layouts 1.3
import FluentUI 1.0
import "./../Component"

KWindow {
    color: "#ededed"
    backgroundColor: "#ededed"
    width: 911
    height: 660
    showStayTop: true

    Item {
        width: parent.width
        height: parent.height
        ColumnLayout {
            anchors {
                top: parent.top
                topMargin: 128
                horizontalCenter: parent.horizontalCenter
            }
            KIcon {
                id: _icon
                iconSource: FluentIcons.SetlockScreen
                iconSize: 120
                Layout.preferredWidth: 100
                Layout.preferredHeight: 100
                Layout.alignment: Qt.AlignHCenter
            }
            KText {
                text: g_language.lockFrameBigTip
                font.pixelSize: 20
                Layout.topMargin: 44
                Layout.alignment: Qt.AlignHCenter
            }
            KText {
                text: g_language.lockFrameSmallTip
                font.pixelSize: 14
                Layout.alignment: Qt.AlignHCenter
            }
            KTextButton {
                text: g_language.lockFrameUnlockOnPhone
                Layout.preferredWidth: 180
                Layout.preferredHeight: 34
                Layout.alignment: Qt.AlignHCenter
                Layout.topMargin: 110
                font.pixelSize: 14
                normalColor: g_theme.skinLogin.normalColor
                backgroundHoverColor: g_theme.skinLogin.backgroundHoverColor
                backgroundNormalColor: g_theme.skinLogin.backgroundNormalColor
                backgroundPressedColor: g_theme.skinLogin.backgroundPressedColor
            }
        }
    }
}
