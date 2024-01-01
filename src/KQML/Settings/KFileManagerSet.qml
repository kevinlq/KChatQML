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
import QtQuick.Layouts 1.3
import QtQuick.Controls 2.4
import Qt.labs.qmlmodels 1.0

import "./../Component"

BaseSetPage {

    id: control
    pageNamge: "fileManager"
    delegate: _chooser
    textWidth: 88
    spacing: 4

    apiMap: {
        "enableautoDownloadFile": enableautoDownloadFile,"readonlyOpenChatFile": readonlyOpenChatFile,
        "changeFolder": changeFolder, "openFolder": openFolder
    }

    Component.onCompleted: {
    }

    DelegateChooser {
        id: _chooser
        role: "itemType"
        DelegateChoice { roleValue: "textCheckbox";      delegate: textCheckboxDelegate }
        DelegateChoice { roleValue: "textButtons";        delegate: _buttonsDelegate }
        DelegateChoice { roleValue: "textEdit";        delegate: textEditDelegate }
    }

    Component {
        id: _buttonsDelegate
        RowLayout {
            id: _buttonLayout
            spacing: control.spacing
            property bool comInited: false
            property var childValues: model.values
            onChildValuesChanged: {
                comInited = false
                if(!childValues) {
                    return
                }
                var i = 0
                if(0 === _buttonModel.count) {
                    var tmoModelData = []
                    for(i = 0; i < childValues.count; i++){
                        tmoModelData.push(childValues.get(i))
                    }
                    _buttonModel.append(tmoModelData)
                }
                else {
                    for(i = 0; i < childValues.count; i++) {
                        _buttonModel.set(i, childValues.get(i))
                    }
                }
                comInited = true
            }
            Item {
                Layout.preferredWidth: control.textWidth
            }
            Row {
                Layout.fillWidth: true
                spacing: 8
                Repeater {
                    model: ListModel {
                        id: _buttonModel
                    }
                    KTextButton {
                        id: _textButton
                        text: model.text
                        height: 30
                        width: 100
                        cursorShape: Qt.PointingHandCursor
                        onClicked: {
                            if(_buttonLayout.comInited) {
                                control.runFunction( fun, index, _textButton, modelData, null)
                            }
                        }
                    }
                }
            }
        }
    }

    function initialize(arg) {
        initModel()
    }

    function enableautoDownloadFile(index,obj, modelData, param) {
    }
    function readonlyOpenChatFile(index,obj, modelData, param) {
    }
    function changeFolder(index,obj, modelData, param) {
    }
    function openFolder(index,obj, modelData, param) {
    }
}
