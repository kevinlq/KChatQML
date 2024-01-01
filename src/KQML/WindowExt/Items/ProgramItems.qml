import QtQuick 2.15
import "./../../Component"

Item {

    id: control
    property var _modelData: []
    property string itemType: "item"

    Flow {
        spacing: 8
        anchors.fill: parent
        Repeater {
            model: _modelData
            delegate: Loader {
                property var model: _modelData[index]
                sourceComponent: {
                    if("item" === control.itemType) {
                        return _comItem
                    }
                    else if ("blockItem" === control.itemType) {
                        return _comBlockItem
                    }
                    return undefined
                }
            }
        }
    }

    Component {
        id: _comItem
        ProgramItem {
            width: (control.width - 10 *(_modelData.length-1)) / _modelData.length
            height: 86
            name: model.itemText
            url: model.url
            des: model.des
            icon: model.icon
        }
    }
    Component {
        id: _comBlockItem
        ProgramBlockItem {
            width: (control.width - 40) / 5
            height: 126
            name: model.itemText
            url: model.url
            des: model.des
            icon: model.icon
            thumb: model.thumb
        }
    }
}
