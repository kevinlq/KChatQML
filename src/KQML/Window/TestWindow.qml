import QtQuick 2.11
import QtQuick.Controls 2.0
import QtQuick.Layouts 1.3
import QtQuick.Window 2.2
import Qt.labs.platform 1.1
import FluentUI 1.0

import "../Chat"
import "../Component"

KWindow
{
    id:window
    visible: true

    width: 990
    height: 660
    minimumWidth: 620
    minimumHeight: 500
    appBar: _app_bar
    titleHeight: 30

    Component.onCompleted: {
        var navItems = [
                    {"itemType": "item", "icon": FluentIcons.ChatBubbles, "infoBadge": 1}
                ]
        var footerItems = []
        //_navBar.initialize(navItems, footerItems)
    }

    KAppBar {
        id: _app_bar
        anchors {
            top: parent.top
            left: parent.left
            //leftMargin: _navBar.cellWidth
            right: parent.right
        }
        iconSize: 10
        textColor: window.titleTextColor
        height: window.titleHeight
        buttonSize: Qt.size(28, 28)
        //color: FluTheme.dark ? Qt.rgba(46/255, 46/255, 46/255, 1) : Qt.rgba(0,0,0,0)
        //color: "#F3F3F3"
        //color: "#2e2e2e"
    }

    // KNavigationView {
    //     id: _navBar
    //     anchors.fill: parent
    //     z: 1000
    // }
}
