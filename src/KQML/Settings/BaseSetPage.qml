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
  the base setting page.
*/

import QtQuick 2.15
import QtQuick.Controls 2.4
import QtQuick.Layouts 1.3
import Qt.labs.qmlmodels 1.0

import "./../Component"

Item {

    id: control

    property string pageNamge: ""
    property string url: ""
    property var funApi: null

    property bool inited: false
    property int spacing: 44
    property int leftMargion: 50
    property int textWidth: 60
    property Component delegate: _chooser
    property alias listView: _listView

    property Component titleDelegate: _titleDelegate
    property Component switchDelegate: _switchDelegate
    property Component textCheckboxDelegate: _textCheckboxDelegate
    property Component textButtonDelegate: _textButtonDelegate
    property Component textEditDelegate: _textEditDelegate
    property Component textDelegate: _textDelegate
    property Component textComboxDelegate: _textComboxDelegate

    property var apiMap: ({})

    Component.onCompleted: {
    }

    KListView {
        id: _listView
        width: parent.width
        height: parent.height
        anchors {
            left: parent.left
            leftMargin: control.leftMargion
            top: parent.top
        }
        spacing: 10
        delegate: control.delegate
    }

    DelegateChooser {
        id: _chooser
        role: "itemType"
        DelegateChoice { roleValue: "title";             delegate: titleDelegate}
        DelegateChoice { roleValue: "switchButton";      delegate: switchDelegate }
        DelegateChoice { roleValue: "textCheckbox";      delegate: textCheckboxDelegate }
        DelegateChoice { roleValue: "textButton";        delegate: textButtonDelegate }
        DelegateChoice { roleValue: "textCombox";        delegate: textComboxDelegate}
        DelegateChoice { roleValue: "textEdit";          delegate: textEditDelegate }
        DelegateChoice { roleValue: "text";          delegate: textDelegate }
    }

    Component {
        id: _titleDelegate
        KText {
            text: model.itemText
            color: g_theme.skinSetting.accountTextColor
            wrapMode: Text.WrapAnywhere
            width: 300
        }
    }
    Component {
        id: _switchDelegate
        KLabelSwitchButton {
            id: _switchButton
            text: model.itemText
            checked: model.checked
            iconSource: convertSourceName(model.iconSource)
            onClicked: {
                control.runFunction( fun, index, _switchButton, null)
            }
        }
    }
    Component {
        id: _textCheckboxDelegate
        RowLayout {
            id: _textCheckLayout
            spacing: control.spacing
            property bool comInited: false
            Component.onCompleted: {
                comInited = true
            }
            KText {
                text: model.itemText
                Layout.preferredWidth: Math.max(control.textWidth, contentWidth+10)
            }
            KCheckBox {
                id: _checkBox
                checked: model.checked
                text: model.itemValue
                onCheckedChanged: {
                    if(_textCheckLayout.comInited) {
                        setModelProperty(index, "checked", checked)
                        control.runFunction( fun, index, _checkBox, null)
                    }
                }
            }
        }
    }
    Component {
        id: _textButtonDelegate
        RowLayout {
            id: _textBtnLayout
            spacing: control.spacing
            property bool comInited: false
            Component.onCompleted: {
                comInited = true
            }
            KText {
                text: model.itemText
                Layout.preferredWidth: control.textWidth
            }
            KTextButton {
                id: _textButton
                text: model.itemValue
                height: 30
                Layout.preferredWidth: Math.max(180, implicitContentWidth)
                cursorShape: Qt.PointingHandCursor
                onClicked: {
                    if(_textBtnLayout.comInited) {
                        control.runFunction( fun, index, _textButton, null)
                    }
                }
            }
        }
    }
    Component {
        id: _textEditDelegate
        RowLayout {
            id: _textEditLayout
            spacing: control.spacing
            height: model.height
            KText {
                text: model.itemText
                Layout.preferredWidth: control.textWidth
            }
            Column {
                spacing: 1
                KTextBox {
                    readOnly: true
                    selectByMouse: false
                    disabled: true
                    text: model.itemValue
                    Layout.preferredWidth: 240
                    Layout.preferredHeight: 30
                }
                KText {
                    text: model.tipText
                    visible: text !== ""
                    color: g_theme.skinSetting.accountTextColor
                }
            }
        }
    }
    Component {
        id: _textDelegate
        RowLayout {
            spacing: control.spacing
            height: model.height
            KText {
                text: model.itemText
                Layout.preferredWidth: control.textWidth
            }
            KText {
                text: model.itemValue
                visible: text !== ""
                color: g_theme.skinSetting.accountTextColor
            }
        }
    }

    Component {
        id: _textComboxDelegate
        RowLayout {
            id: _cbxLayout
            spacing: control.spacing
            //height: 30
            property bool comInited: false
            property var childModelData: []
            property var childValues: model.itemValues
            onChildValuesChanged: {
                if (!childValues) {
                    return
                }
                comInited = false
                var cbxData = []
                childModelData = []
                var currentIndex = 0
                for(var i = 0; i < childValues.count; i++) {
                    var cItem = childValues.get(i)
                    childModelData.push(cItem)
                    cbxData.push(control.transComboxText(cItem.role) )
                    if(model.checkValue === cItem.role) {
                        currentIndex = i
                    }
                }
                currentIndex = Math.max(0, currentIndex)
                _combox.model = cbxData
                _combox.currentIndex = currentIndex
                comInited = true
            }
            Component.onCompleted: {
            }
            KText {
                text: model.itemText
                Layout.preferredWidth: control.textWidth
            }
            KComboBox {
                id: _combox
                height: 24
                currentIndex: 0
                onCurrentIndexChanged: {
                    if(_cbxLayout.comInited) {
                        control.runFunction( fun, index, _combox, _cbxLayout.childModelData)
                    }
                }
            }
        }
    }

    function initModel() {
        if(inited) {
            return true
        }
        listView.listModel.clear()
        var modelData = funApi.getModelData(control.pageNamge)
        listView.listModel.append(modelData)
        inited = true
        return true
    }
    function transComboxText(role) {
        return role
    }

    function initialize(arg) {
    }

    function runFunction(sFun,index,obj, param){
        if(!control.apiMap.hasOwnProperty(sFun)) {
            console.error("not register api: ", sFun)
            return false
        }
        var fun = control.apiMap[sFun]
        var modelData = listView.model.get(index)
        return fun(index, obj, modelData, param)
    }

    function setModelProperty(index, pro, value) {
        var model = listView.model
        model.setProperty(index, pro, value)
    }

    function languageChanged(arg) {
        var model = listView.listModel

        var modelData = funApi.getModelData(control.pageNamge)
        for(var i = 0; i < model.count; i++) {
            var object = model.get(i)
            object.itemText = modelData[i].itemText
            object.itemValue = modelData[i].itemValue
            model.set(i, object)
        }
    }
    function themeChanged(arg){
    }
}
