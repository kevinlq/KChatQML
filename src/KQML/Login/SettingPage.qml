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
  settting page
*/
import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15
import "./../Component"

BasePage {

    id: controlPage
    property var integerValidator: RegularExpressionValidator {
        regularExpression: /^[0-9]{1,10}$/
    }
    property var emptyValidator: null

    Component.onCompleted: {

    }

    ListModel {
        id: _proxyInfoModel
    }

    KText {
        id: _titleProxy
        text: g_language.proxySetting
        anchors {
            top: parent.top
            topMargin: 44
            horizontalCenter: parent.horizontalCenter
        }
        font.pixelSize: 15
    }

    ColumnLayout {
        anchors {
            left: parent.left
            leftMargin: 18
            top: _titleProxy.bottom
            topMargin: 36
        }
        spacing: 16
        width: parent.width - 18 * 2
        Row {
            spacing: 16
            width: parent.width
            height: 30
            KText {
                text: g_language.useProxyText
                color: g_theme.skinLogin.normalLabelTextColor
            }
            Row {
                id: _radioButtonRow
                spacing: 30
                KRadioButton {
                    text: g_language.closeProxy
                    textColor: g_theme.skinLogin.normalLabelTextColor
                    checked: true
                    exclusive: true
                }
                KRadioButton {
                    id: _openProxy
                    exclusive: true
                    text: g_language.openProxy
                }
            }
            ButtonGroup {
                id: _group
                exclusive: true
                buttons: _radioButtonRow.children
            }
        }
        Column {
            Layout.fillWidth: true
            visible: _openProxy.checked

            Repeater {
                model: _proxyInfoModel
                Row {
                    spacing: 16
                    width: parent.width
                    height: 34
                    KText {
                        id: labelText
                        text: model.itemText
                        color: g_theme.skinLogin.normalLabelTextColor
                        width: Math.max(54, contentWidth)
                        anchors.verticalCenter: parent.verticalCenter
                    }
                    KTextBox {
                        placeholderText: ""
                        height: 28
                        maximumLength: 50
                        validator: {
                            if ("integer" === model.ItemType) {
                                return integerValidator
                            }
                            return emptyValidator
                        }
                        echoMode: {
                            if ("password" === model.ItemType) {
                                return TextField.Password
                            }
                            return TextField.Normal
                        }
                        width: parent.width - labelText.width - 18
                    }
                }
            }
            KTextButton {
                text: g_language.proxyMoreSet
                anchors.right: parent.right
                normalColor: g_theme.skinLogin.moreSettingTextColor
                backgroundNormalColor: "transparent"
                backgroundHoverColor: backgroundNormalColor
                backgroundPressedColor: backgroundNormalColor
                visible: _proxyInfoModel.count <= 2
                onClicked: {
                    addMoreSett()
                }
            }
        }
        KTextButton {
            text: g_language.proxyOK
            visible: _openProxy.checked
            Layout.preferredWidth: 136
            Layout.preferredHeight: 36
            Layout.topMargin: 4
            Layout.alignment: Qt.AlignHCenter
            normalColor: g_theme.skinLogin.normalColor
            backgroundHoverColor: g_theme.skinLogin.backgroundHoverColor
            backgroundNormalColor: g_theme.skinLogin.backgroundNormalColor
            backgroundPressedColor: g_theme.skinLogin.backgroundPressedColor
            onClicked: {

            }
        }
    }

    function initialize(arg) {
        var itemModel = [{
                             "itemText": g_language.proxyAddress,
                             "ItemType": "normal"
                         }, {
                             "itemText": g_language.proxyPort,
                             "ItemType": "integer"
                         }]
        _proxyInfoModel.clear()
        _proxyInfoModel.append(itemModel)
        return true
    }

    function addMoreSett() {
        if (_proxyInfoModel.count > 2) {
            return
        }
        var itemModel = [{
                             "itemText": g_language.proxyAccount,
                             "ItemType": "normal"
                         }, {
                             "itemText": g_language.proxyPassword,
                             "ItemType": "password"
                         }]
        _proxyInfoModel.append(itemModel)
    }
}
