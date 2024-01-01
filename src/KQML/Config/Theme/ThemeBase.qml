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
  this is base theme style
*/
import QtQuick 2.15
import "./themeElement"

QtObject {

    property string themeName: "default"

    property ColorSetStyle skinComColor: ColorSetStyle {}

    // common style
    property TextStype skinText: TextStype {}
    property TextEditStyle skinEdit: TextEditStyle {}
    property ButtonStyle skinButton: ButtonStyle {}
    property RadioButtonStyle skinRadioButton: RadioButtonStyle {}
    property ListViewStyle skinListView: ListViewStyle {}
    property DialogStyle skinDialog: DialogStyle {}

    // window
    property color windowActiveBackgroundColor: "#ffffff"
    property color windowBackgroundColor: "#F1ffffff"
    property color windowTextColor: "#999999"

    property SwitchButtonStyle skinSwitch: SwitchButtonStyle {}

    // custome style

    // LoginStyle
    property LoginStyle skinLogin: LoginStyle {}

    property SettingStyle skinSetting: SettingStyle{}

    // chat view style
    property ChatStyle skinChat: ChatStyle {}

    function primaryColor(){
        return skinComColor.dark
    }
}
