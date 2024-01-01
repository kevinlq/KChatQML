import QtQuick 2.15

QtObject {

    property color normalColor: "#FFFFFFFF"
    property color textColor: primaryColor()

    property color checkHoverColor: "#FFFFFFFF"
    property color unCheckHoverColor: Qt.rgba(222/255,222/255,222/255,1)
    property color checkDisableColor: Qt.rgba(159/255,159/255,159/255,1)
    property color unCheckDisableColor: Qt.rgba(222/255,222/255,222/255,1)
    property color checkBorderNormalColor: primaryColor()
    property color unCheckBorderNormalColor: Qt.rgba(141/255,141/255,141/255,1)
    property color borderDisableColor: Qt.rgba(198/255,198/255,198/255,1)

}
