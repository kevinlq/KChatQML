import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15
import QtQuick.Window 2.15
import FluentUI 1.0

Rectangle{
    property string title: ""
    property string darkText : g_language.darkText
    property string settingText: g_language.settingText
    property string minimizeText : g_language.minimizeText
    property string restoreText : g_language.restoreText
    property string maximizeText : g_language.maximizeText
    property string closeText : g_language.closeText
    property string stayTopText : g_language.stayTopText
    property string stayTopCancelText : g_language.stayTopCancelText
    property color textColor: g_theme.windowTextColor
    property color minimizeNormalColor: g_theme.skinComColor.normalColor
    property color minimizeHoverColor: g_theme.skinComColor.hoverColor
    property color minimizePressColor: g_theme.skinComColor.pressColor
    property color maximizeNormalColor: g_theme.skinComColor.normalColor
    property color maximizeHoverColor: g_theme.skinComColor.hoverColor
    property color maximizePressColor: g_theme.skinComColor.pressColor
    property color closeNormalColor: Qt.rgba(0,0,0,0)
    property color closeHoverColor:  Qt.rgba(251/255,115/255,115/255,1)
    property color closePressColor: Qt.rgba(251/255,115/255,115/255,0.8)
    property bool showDark: false
    property bool showClose: true
    property bool showMinimize: true
    property bool showMaximize: true
    property bool showStayTop: true
    property bool showSetting: false
    property bool titleVisible: true
    property size buttonSize: Qt.size(28, 28)
    property var settingIconSource: [FluentIcons.Settings,FluentIcons.Home]
    property url icon
    property int iconSize: 20
    property bool isMac: FluTools.isMacos()
    property color borerlessColor : FluTheme.primaryColor
    property var maxClickListener : function(){
        if (d.win.visibility === Window.Maximized)
            d.win.visibility = Window.Windowed
        else
            d.win.visibility = Window.Maximized
    }
    property var minClickListener: function(){
        d.win.visibility = Window.Minimized
    }
    property var closeClickListener : function(){
        d.win.close()
    }
    property var stayTopClickListener: function(){
        if(d.win instanceof FluWindow){
            d.win.stayTop = !d.win.stayTop
        }
    }
    property var darkClickListener: function(){
        if(FluTheme.dark){
            FluTheme.darkMode = FluThemeType.Light
        }else{
            FluTheme.darkMode = FluThemeType.Dark
        }
    }

    id:control
    color: Qt.rgba(0,0,0,0)
    height: visible ? 30 : 0
    opacity: visible
    z: 65535

    signal settingClick(bool setting)

    Item{
        id:d
        property var win: Window.window
        property bool stayTop: {
            if(d.win instanceof FluWindow){
                return d.win.stayTop
            }
            return false
        }
        property bool isRestore: win && Window.Maximized === win.visibility
        property bool resizable: win && !(win.height === win.maximumHeight && win.height === win.minimumHeight && win.width === win.maximumWidth && win.width === win.minimumWidth)
        property bool isSetting: true

    }
    TapHandler {
        onTapped: if (tapCount === 2 && d.resizable) btn_maximize.clicked()
        gesturePolicy: TapHandler.DragThreshold
    }
    DragHandler {
        target: null
        grabPermissions: TapHandler.CanTakeOverFromAnything
        onActiveChanged: if (active) { d.win.startSystemMove(); }
    }
    Row{
        anchors{
            verticalCenter: parent.verticalCenter
            left: isMac ? undefined : parent.left
            leftMargin: isMac ? undefined : 10
            horizontalCenter: isMac ? parent.horizontalCenter : undefined
        }
        spacing: 10
        Image{
            width: control.iconSize
            height: control.iconSize
            visible: status === Image.Ready ? true : false
            source: control.icon
            anchors.verticalCenter: parent.verticalCenter
        }
        FluText {
            text: title
            visible: control.titleVisible
            color:control.textColor
            anchors.verticalCenter: parent.verticalCenter
        }
    }
    RowLayout{
        anchors.right: parent.right
        height: control.height
        spacing: 0
        FluToggleSwitch{
            id:btn_dark
            Layout.alignment: Qt.AlignVCenter
            Layout.rightMargin: 5
            visible: showDark
            text:darkText
            textColor:control.textColor
            checked: FluTheme.dark
            textRight: false
            clickListener:()=> darkClickListener(btn_dark)
        }
        KIconButton{
            id:btn_stay_top
            Layout.preferredWidth: control.buttonSize.width
            Layout.preferredHeight: control.buttonSize.height
            iconSource : FluentIcons.Pinned
            Layout.alignment: Qt.AlignVCenter
            iconSize: 9
            visible: {
                if(!(d.win instanceof FluWindow)){
                    return false
                }
                return showStayTop
            }
            text:d.stayTop ? control.stayTopCancelText : control.stayTopText
            radius: 0
            iconColor: d.stayTop ? FluTheme.primaryColor : control.textColor
            onClicked: stayTopClickListener()
        }
        KIconButton {
            id:btn_setting
            Layout.preferredWidth: control.buttonSize.width
            Layout.preferredHeight: control.buttonSize.height
            iconSource : d.isSetting ? control.settingIconSource[0] : control.settingIconSource[1]
            Layout.alignment: Qt.AlignVCenter
            iconSize: 10
            visible: control.showSetting
            text: control.settingText
            radius: 0
            iconColor: control.textColor
            color: {
                if(pressed){
                    return maximizePressColor
                }
                return hovered ? maximizeHoverColor : maximizeNormalColor
            }
            onClicked: {
                d.isSetting = !d.isSetting
                settingClick(d.isSetting)
            }
        }
        KIconButton{
            id:btn_minimize
            Layout.preferredWidth: control.buttonSize.width
            Layout.preferredHeight: control.buttonSize.height
            iconSource : FluentIcons.ChromeMinimize
            Layout.alignment: Qt.AlignVCenter
            iconSize: 9
            text:minimizeText
            radius: 0
            visible: !isMac && showMinimize
            iconColor: control.textColor
            color: {
                if(pressed){
                    return minimizePressColor
                }
                return hovered ? minimizeHoverColor : minimizeNormalColor
            }
            onClicked: minClickListener()
        }
        KIconButton{
            id:btn_maximize
            Layout.preferredWidth: control.buttonSize.width
            Layout.preferredHeight: control.buttonSize.height
            iconSource : d.isRestore  ? FluentIcons.ChromeRestore : FluentIcons.ChromeMaximize
            color: {
                if(pressed){
                    return maximizePressColor
                }
                return hovered ? maximizeHoverColor : maximizeNormalColor
            }
            Layout.alignment: Qt.AlignVCenter
            visible: d.resizable && !isMac && showMaximize
            radius: 0
            iconColor: control.textColor
            text:d.isRestore?restoreText:maximizeText
            iconSize: 9
            onClicked: maxClickListener()
        }
        KIconButton{
            id:btn_close
            iconSource : FluentIcons.ChromeClose
            Layout.alignment: Qt.AlignVCenter
            text:closeText
            Layout.preferredWidth: control.buttonSize.width
            Layout.preferredHeight: control.buttonSize.height
            visible: !isMac && showClose
            radius: 0
            iconSize: 10
            iconColor: hovered ? Qt.rgba(1,1,1,1) : control.textColor
            color:{
                if(pressed){
                    return closePressColor
                }
                return hovered ? closeHoverColor : closeNormalColor
            }
            onClicked: closeClickListener()
        }
    }
    function stayTopButton(){
        return btn_stay_top
    }
    function minimizeButton(){
        return btn_minimize
    }
    function maximizeButton(){
        return btn_maximize
    }
    function closeButton(){
        return btn_close
    }
    function darkButton(){
        return btn_dark
    }
    function settingButton() {
        return btn_setting
    }
}
