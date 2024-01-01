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
import QtQuick.Layouts 1.3
import com.kevinlq.kchat 1.0

Popup {
    id: popup
    padding: 0
    margins: 0
    modal:true
    closePolicy: Popup.CloseOnEscape

    background: KRectangle {
        radius: [popup.radius, popup.radius, popup.radius, popup.radius]
        color: g_theme.skinDialog.backgroundColor
        KShadow {
            radius: popup.radius
        }
    }
    Overlay.modal: Item {
    }

    focus: true
    implicitWidth: 300
    implicitHeight: 180

    property bool canMove: true
    property bool showTitle: true
    property bool showClose: false
    property real radius: 4
    property string title: ""
    property string contentMsg: ""
    property string okBtnText: g_language.dlgOKBtnText
    property string cancelBtnText: g_language.dlgCancelBtnText
    property color contentTextColor: g_theme.skinText.color

    signal buttonClicked(string btnName)
    signal closeButtonClicked()

    QtObject {
        id: d
        property point clickPos: Qt.point(0,0)
    }

    MouseArea {
        id: _moveArea
        enabled: popup.canMove
        width: parent.width
        height: popup.showTitle ? _titleItem.height : 24
        anchors {
            left: parent.left
            top: parent.top
        }
    }
    Connections {
        target: _moveArea
        function onClicked(mouse) {mouse.accepted = true}
        function onPressed (mouse) {d.clickPos = Qt.point(mouse.x, mouse.y)}
        function onPositionChanged(mouse) {
            var mainframe = popup.Overlay.overlay
            var delt = Qt.point(mouse.x - d.clickPos.x, mouse.y - d.clickPos.y)
            var posX = popup.x + delt.x
            var posY = popup.y + delt.y
            if(posX + popup.width > mainframe.width) {
                posX = mainframe.width - popup.width
            }
            if(posY + popup.height > mainframe.height) {
                posY = mainframe.height - popup.height
            }
            posX = Math.max(0, Math.min(posX, mainframe.width -popup.width))
            posY = Math.max(0, Math.min(posY, mainframe.height-popup.height))

            popup.x = posX
            popup.y = posY
        }
    }

    ColumnLayout {
        id: _contentLayout
        width: parent.width
        spacing: 8
        // title
        Rectangle {
            id: _titleItem
            visible: popup.showTitle
            radius: popup.radius
            color: g_theme.skinDialog.backgroundColor
            border.width: 0
            border.color: "transparent"
            Layout.preferredHeight: 30
            Layout.fillWidth: true
            Layout.leftMargin: 2
            Layout.rightMargin: 2
            Layout.topMargin: 2
            KText {
                text: popup.title
                wrapMode: Text.WrapAnywhere
                anchors {
                    left: parent.left
                    leftMargin: 24
                    verticalCenter: parent.verticalCenter
                }
            }
        }

        // content
        Flickable {
            clip: true
            boundsBehavior:Flickable.StopAtBounds
            ScrollBar.vertical: ScrollBar {}
            contentWidth: width
            contentHeight: _contentText.height
            Layout.fillWidth: true
            Layout.preferredHeight: Math.min(140, _contentText.height)
            Layout.topMargin: popup.showTitle ? 2 : 24
            KText {
                id: _contentText
                text: popup.contentMsg
                color: popup.contentTextColor
                wrapMode: Text.WrapAnywhere
                width: parent.width
                leftPadding: 26
                rightPadding: 26
                topPadding: 16
                font.pixelSize: 14
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
            }
        }
    }
    // footer button
    RowLayout {
        spacing: 10
        width: parent.width-24*2
        height: 40
        anchors {
            margins: 24
            left: parent.left
            right: parent.right
            bottom: parent.bottom
        }
        KTextButton {
            text: okBtnText
            objectName: "ok"
            Layout.preferredWidth: 96
            Layout.preferredHeight: 30
            Layout.alignment: Qt.AlignHCenter
            normalColor: g_theme.skinComColor.okTextColor
            backgroundHoverColor: g_theme.skinComColor.backgroundHoverColor
            backgroundNormalColor: g_theme.skinComColor.backgroundNormalColor
            backgroundPressedColor: g_theme.skinComColor.backgroundPressedColor
            font.pixelSize: 14
            visible: "" !== okBtnText
            onClicked: {
                popup.close()
                buttonClicked(objectName)
            }
        }
        KTextButton {
            text: cancelBtnText
            objectName: "cancel"
            Layout.preferredWidth: 96
            Layout.preferredHeight: 30
            Layout.alignment: Qt.AlignHCenter
            normalColor: g_theme.skinComColor.lightest
            pressedColor: normalColor
            font.pixelSize: 14
            visible: "" !== cancelBtnText
            onClicked: {
                popup.close()
                buttonClicked(objectName)
            }
        }
    }

    function openDialog(arg) {
        var mainframe = Overlay.overlay
        popup.x = (mainframe.width - popup.width)/2
        popup.y = (mainframe.height - popup.height)/2

        var okText = g_language.dlgOKBtnText
        var cancelText = g_language.dlgCancelBtnText
        if(arg.hasOwnProperty("okText")) {
            okText = arg.okText
        }
        if(arg.hasOwnProperty("cancelText")) {
            cancelText = arg.cancelText
        }
        popup.okBtnText = okText
        popup.cancelBtnText = cancelText

        popup.open()
    }
}
