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
  this is dark theme style.
*/

import QtQuick 2.15

ThemeBase {

    themeName: "Dark"

    windowActiveBackgroundColor: "#1a1a1a"
    windowBackgroundColor: "#202020"
    windowTextColor: "#FFFFFF"

    skinComColor {
        normal: Qt.rgba(1, 1, 1, 0)
        hoverColor: Qt.rgba(1, 1, 1, 0.03)
        pressColor: Qt.rgba(1, 1, 1, 0.06)
        checkColor: Qt.rgba(1, 1, 1, 0.09)
        disableColor: Qt.rgba(131/255,131/255,131/255,1)

        comBackgroundColor: Qt.rgba(50/255,49/255,48/255,1)
        menuBackgroundColor: Qt.rgba(45/255,45/255,45/255,1)
        menuBorderColor: Qt.rgba(55/255,55/255,55/255,1)
    }

    skinText {
        color: Qt.rgba(248/255, 248/255, 248/255, 1)
    }
    skinRadioButton {
        normalColor: Qt.rgba(50/255,50/255,50/255,1)
        checkHoverColor: Qt.rgba(50/255,50/255,50/255,1)
        unCheckHoverColor: Qt.rgba(43/255,43/255,43/255,1)
        checkDisableColor: Qt.rgba(159/255,159/255,159/255,1)
        unCheckDisableColor: Qt.rgba(43/255,43/255,43/255,1)
        unCheckBorderNormalColor: Qt.rgba(161/255,161/255,161/255,1)
        borderDisableColor: Qt.rgba(82/255,82/255,82/255,1)
    }
    skinEdit {
        backgroundNormalColor: "#3e3e3e"
        backgroundHoverColor: "#444444"
        backgroundDisableColor: "#3b3b3b"
        backgroundPressedColor: "#444444"
    }
    skinButton {
        normalColor: primaryColor()
        backgroundNormalColor: skinComColor.normalColor
    }

    skinListView {
        textColor: "red"
    }
    skinDialog {
        backgroundColor: Qt.rgba(43/255,43/255,43/255,1)
        shadowColor: "#FFFFFF"
    }

    skinSwitch {
        checkColor: "#07c160"
        normalColor: "#e5e5e5"
    }

    skinSetting {
        normalColor: "#FFFFFF"
        checkColor: "#3dce3d"
    }

    function primaryColor(){
        return skinComColor.lighter
    }
}
