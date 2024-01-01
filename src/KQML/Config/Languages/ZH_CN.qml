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

import QtQuick 2.11

QtObject {

    property string name : "ZH_CN"

    /*====================== window Begin ======================*/
    readonly property string minimizeText:          "最小化"
    readonly property string restoreText:           "向下还原"
    readonly property string maximizeText:          "最大化"
    readonly property string closeText:             "关闭"
    readonly property string stayTopText:           "置顶"
    readonly property string stayTopCancelText:     "取消置顶"
    readonly property string darkText:              "夜间模式"
    readonly property string settingText:           "设置"
    /*====================== window End ======================*/

    /*====================== dialog Begin ======================*/
    readonly property string dlgOKBtnText:          "确认"
    readonly property string dlgCancelBtnText:      "取消"
    /*====================== dialog end ======================*/

    /*====================== login Begin ======================*/
    readonly property string loginTitle:    "微信"
    readonly property string enterChat:     "进入微信"
    readonly property string switAccount:   "切换账号"
    readonly property string transFiles:    "仅传输文件"
    readonly property string scanQRLogin:   "扫码登录"
    readonly property string proxySetting:  "网络代理设置"
    readonly property string useProxyText:  "使用代理"
    readonly property string closeProxy:    "关闭"
    readonly property string openProxy:     "开启"
    readonly property string proxyAddress:  "地  址"
    readonly property string proxyPort:     "端  口"
    readonly property string proxyAccount:  "账  户"
    readonly property string proxyPassword: "密  码"
    readonly property string proxyOK:       "确认"
    readonly property string proxyMoreSet:  "更多设置"
    readonly property string logingText:    "正在进入"
    readonly property string loginCancel:   "取消"

    readonly property string lockFrameBigTip:           "Windows Weixin 已被锁定"
    readonly property string lockFrameSmallTip:         "您可以在手机微信的会话列表顶部状态栏解锁"
    readonly property string lockFrameUnlockOnPhone:    "在手机上解锁"
    /*======================= Begin =============================*/

    readonly property string navItemChat:   "聊天"
    readonly property string navContast:    "通讯录"
    readonly property string navFavorites:  "收藏"
    readonly property string navChatFiles:  "聊天文件"
    readonly property string navMoments:    "朋友圈"
    readonly property string navChannels:   "视频号"
    readonly property string navTopStories: "看一看"
    readonly property string navSearch:     "搜一搜"

    readonly property string navMiniProgram:        "小程序面板"
    readonly property string navPhone:              "手机"
    readonly property string navFloating:           "浮窗"
    readonly property string navFileTransfer:       "文件传输助手"
    readonly property string navSettingOther:       "设置及其他"
    readonly property string navChannelsTool:       "视频号直播工具"
    readonly property string navMigrateAndBackup:   "迁移与备份"
    readonly property string navLock:               "锁定"
    readonly property string navFeedback:           "意见反馈"
    readonly property string navSettings:           "设置"

    /*====================== 系统设置  Begin ======================*/
    readonly property string setWindowTitle:   "设置"
    readonly property string setAccountSet:    "账号设置"
    readonly property string setMsgNotify:      "消息通知"
    readonly property string setCommonSet:      "通用设置"
    readonly property string setFileMgr:        "文件管理"
    readonly property string setShortcut:       "快捷键"
    readonly property string setAboutChat:      "关于微信"

    readonly property string setNickName:       "微信号："
    readonly property string setAutoLogin:      "自动登录"
    readonly property string setSignout:        "退出登录" //sign out
    readonly property string setTurnedOn:       "已开启"
    readonly property string setClosure:        "关闭"
    readonly property string setAutoSignTips:   "开启后，在本机登录微信将无需手机确认。可在手机和电脑上关闭。"
    readonly property string setCloseSignTips:   "关闭后，下次登录需要手机确认"
    readonly property string setLogOutTip:      "退出登录后将无法收到新消息，确认退出登录？"


    readonly property string setSimplifiedChinese: "简体中文"
    readonly property string setTraditionalChinese: "繁體中文"
    readonly property string setEnglish:            "English"
    readonly property string setThemeDark:          "深色"
    readonly property string setThemeWhite:         "浅色"
    readonly property string setThemeAuto:          "更随系统"

    readonly property string setNotify:             "通知声音"
    readonly property string setNewMsgAlert:        "新消息通知声音"
    readonly property string setVoiceVideoAlert:    "语音和视频通话通知声音"
    readonly property string setNotiftFlag:         "通知标记"
    readonly property string setMomentsNotify:      "朋友圈"
    readonly property string setChannelsNotify:     "视频号"
    readonly property string setTopStoriesNotify:   "看一看"
    readonly property string setMiniProgramsNotify: "小程序"
    readonly property string setNotiftFlagTip:      "有内容更新时，侧边栏中该功能图标将出现标记提示。"

    readonly property string setLanguage:           "语言"
    readonly property string setTheme:              "主题"
    readonly property string setGeneral:            "通用"
    readonly property string setAutoUpdateChat:     "有更新时自动升级微信"
    readonly property string setAutoStartAtBoot:        "开机自动打开微信"
    readonly property string setSaveChatHistory:        "保留聊天记录"
    readonly property string setShowWebSearchHistory:   "显示网络搜索历史"
    readonly property string setAdaptSysScaling:        "适配系统缩放比例"
    readonly property string setUseDefaultBrowser:      "使用系统默认浏览器打开网页"
    readonly property string setVoiceAuto2Text:         "聊天中的语音消息自动转成文字"
    readonly property string setChearChatHistory:       "清空聊天记录(15.0G)"
    readonly property string setManagerStorage:         "存储空间管理"

    readonly property string setFileSet:                "文件设置"
    readonly property string setEnableautoDownloadFile: "开启文件自动下载（200MB以内）"
    readonly property string setReadonlyOpenChatFile:   "以只读的方式打开聊天中的文件"
    readonly property string setChatFileDefaultDirect:  "微信文件的默认保存位置"
    readonly property string setChangeFolder:           "更改"
    readonly property string setOpenFolder:             "打开文件夹"

    readonly property string setSendMessage:            "发送消息"
    readonly property string setTakeScreenshot:         "截取屏幕"
    readonly property string setOpenChat:               "打开微信"
    readonly property string setLockChat:               "锁定微信"
    readonly property string setCheckShortcuts:         "检测快捷键"
    readonly property string setShortcutAlreadySet:     "快捷键与其他软件冲突时提醒"
    readonly property string setRestoreDefault:         "恢复默认设置"

    readonly property string setUpdateInfo:             "版本信息"
    readonly property string setCheckUpdate:            "检查更新"
    readonly property string setChatHelp:               "微信帮助"
    readonly property string setViewHelp:               "查看帮助"
    readonly property string setTermService:            "服务协议"
    readonly property string setPrivacyPolicy:          "隐私协议"
    readonly property string setCopyright:              "Copyright @ 2011~2013 All Rights Reserved."

    /*============================ End ============================*/

    readonly property string searchText:            "搜索"
    readonly property string addFriendsText:        "发起群聊"

    // 通讯录管理
    readonly property string ctManageContacts:      "通讯录管理"
    readonly property string ctNewFriends:          "新朋友"
    readonly property string ctStared:              "星标朋友"
    readonly property string ctOfficalAccounts:     "公众号"
    readonly property string ctEnterpriseAccount:   "企业号"
    readonly property string ctSavedGroups:         "群聊"

    /*============================ 聊天模块 Begin ============================*/
    readonly property string chatSendText:          "发送(S)"
    readonly property string chatSendEmptyTip:      "不能发送空白消息"
    readonly property string chatNumber:            "微信号："
    readonly property string chatArea:              "地区："
    readonly property string chatSendMessage:       "发送消息"

    readonly property string groupSearchMember:     "搜索群成员"
    readonly property string groupShowMore:         "查看更多..."
    readonly property string groupName:             "群聊名称"
    readonly property string groupNotice:           "群公告"
    readonly property string remark:                "备注"
    readonly property string remarkPlaceText:       "群聊的备注仅自己可见"
    readonly property string aliasInGroup:          "我在本群的昵称"
    readonly property string chatHistory:           "聊天记录"
    readonly property string showGrpupNickNames:    "显示群成员昵称"
    readonly property string disturbMessage:        "消息免打扰"
    readonly property string collapseGroupChat:     "折叠该群聊"
    readonly property string pinnedChat:            "置顶聊天"
    readonly property string save2AddressBook:      "保存到通讯录"
    readonly property string clearChatHistory:      "清空聊天记录"
    readonly property string exitGroupChat:         "退出群聊"

    readonly property string menuTickled:           "拍一拍"
    readonly property string menuCopy:               "复制"
    readonly property string menuEdit:               "编辑"
    readonly property string menuTranslate:          "翻译"
    readonly property string menuForward:            "转发..."
    readonly property string menuFavorites:          "收藏"
    readonly property string menuSelect:             "多选"
    readonly property string menuQuote:              "引用"
    readonly property string menuSearch:             "搜一搜"
    readonly property string menuStickyTop:          "置顶"
    readonly property string menuDelete:             "删除"
    readonly property string menuSaveas:             "另存为..."
    readonly property string menuOpenDefaultBrowser: "用默认浏览器打开"
    readonly property string menuSpeeech2Text:       "语音转文字"
    readonly property string menuMutePlay:            "静音播放"
    readonly property string menuOpenFolder:          "打开文件夹"
    readonly property string menuOriginalLocation:    "定位到原文位置"

    /*============================ End ============================*/

    /*========================= Begin TabWindow ====================*/
    readonly property string tabMiniProgram:            "小程序"
    readonly property string tabSearch:                 "搜一搜"
    readonly property string tabStories:                "看一看"
    readonly property string tabItemOfficalAccounts:    "公众号"
    readonly property string tabItemEmoticons:          "表情"
    readonly property string tabItemArticle:            "文章"
    readonly property string tabItemAllText:            "全部"
    readonly property string tabItemSearchFind:         "搜索发现"
    readonly property string tabItemMoments:            "朋友圈"
    /*========================== End  ============================*/

}
