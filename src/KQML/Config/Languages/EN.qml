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

    property string name : "EN"

    /*====================== window Begin ======================*/
    readonly property string minimizeText:          "minimize"
    readonly property string restoreText:           "restore down"
    readonly property string maximizeText:          "maximize"
    readonly property string closeText:             "close"
    readonly property string stayTopText:           "pin to top"
    readonly property string stayTopCancelText:     "unpin"
    readonly property string darkText:              "night mode"
    readonly property string settingText:           "settings"
    /*====================== window End ======================*/

    /*====================== dialog Begin ======================*/
    readonly property string dlgOKBtnText:          "OK"
    readonly property string dlgCancelBtnText:      "Cancel"
    /*====================== dialog end ======================*/

    /*====================== login Begin ======================*/
    readonly property string loginTitle:    "Weinxin"
    readonly property string enterChat:     "Enter Weixin"
    readonly property string switAccount:   "Switch Account"
    readonly property string transFiles:    "Transfer Files only"
    readonly property string scanQRLogin:   "Scan to log in"
    readonly property string proxySetting:          "Network proxy settings"
    readonly property string useProxyText:          "Use proxy"
    readonly property string closeProxy:            "Disable"
    readonly property string openProxy:             "Enable"
    readonly property string proxyAddress:          "Address"
    readonly property string proxyPort:             "Port"
    readonly property string proxyAccount:          "Account"
    readonly property string proxyPassword:         "Password"
    readonly property string proxyOK:               "OK"
    readonly property string proxyMoreSet:          "More settings"
    readonly property string logingText:            "Entering"
    readonly property string loginCancel:           "Cancel"

    readonly property string lockFrameBigTip:           "Weixin for Windows locked"
    readonly property string lockFrameSmallTip:         "You can unlock on the toolbar at the top of Weixin session"
    readonly property string lockFrameUnlockOnPhone:    "Unlock on Phone"
    /*======================= Begin =============================*/

    readonly property string navItemChat:   "chat"
    readonly property string navContast:    "contast"
    readonly property string navFavorites:  "favorites"
    readonly property string navChatFiles:  "chat files"
    readonly property string navMoments:    "moments"
    readonly property string navChannels:   "channels"
    readonly property string navTopStories: "topStories"
    readonly property string navSearch:     "search"

    readonly property string navMiniProgram:        "Mini Program Panel"
    readonly property string navPhone:              "Phone"
    readonly property string navFloating:           "Floating"
    readonly property string navFileTransfer:       "File Transfer"
    readonly property string navSettingOther:       "Settings and Others"
    readonly property string navChannelsTool:       "Channels Live Tool"
    readonly property string navMigrateAndBackup:   "Migrate & Backup"
    readonly property string navLock:               "Lock"
    readonly property string navFeedback:           "Feedback"
    readonly property string navSettings:           "Settings"
    /*====================== 系统设置  Begin ======================*/
    readonly property string setWindowTitle:   "Settings"
    readonly property string setAccountSet:    "My Account"
    readonly property string setMsgNotify:      "Notifications"
    readonly property string setCommonSet:      "General"
    readonly property string setFileMgr:        "Manage Files"
    readonly property string setShortcut:       "Shortcuts"
    readonly property string setAboutChat:      "About"

    readonly property string setNickName:       "Weixin ID："
    readonly property string setAutoLogin:      "Auto Login"
    readonly property string setSignout:        "Log Out" //sign out
    readonly property string setTurnedOn:       "Enabled"
    readonly property string setClosure:        "Disable"
    readonly property string setAutoSignTips:   "After enabling confirming on phone is not required when you log in to Chat on this device. Can be disabled on both phone and coputer."
    readonly property string setCloseSignTips:   "After closing, the next login requires mobile phone confirmation."
    readonly property string setLogOutTip:      "You wont't be notified of any new messages after loging out. Log out？"

    readonly property string setSimplifiedChinese: "简体中文"
    readonly property string setTraditionalChinese: "繁體中文"
    readonly property string setEnglish:            "English"
    readonly property string setThemeDark:          "Dark"
    readonly property string setThemeWhite:         "Light"
    readonly property string setThemeAuto:          "With the system"

    readonly property string setNotify:             "Notification Alert"
    readonly property string setNewMsgAlert:        "New Message Alert Sound"
    readonly property string setVoiceVideoAlert:    "Voice and Video Calls Alert Sound"
    readonly property string setNotiftFlag:         "Notification Flag"
    readonly property string setMomentsNotify:      "Moments"
    readonly property string setChannelsNotify:     "Channels"
    readonly property string setTopStoriesNotify:   "Top Stories"
    readonly property string setMiniProgramsNotify: "Mini Programs"
    readonly property string setNotiftFlagTip:      "When there is an update,a flag appers next to the feature icon in the sidebar."

    readonly property string setLanguage:           "Language"
    readonly property string setTheme:              "Theme"
    readonly property string setGeneral:            "General"
    readonly property string setAutoUpdateChat:     "Auto-Update Weixin"
    readonly property string setAutoStartAtBoot:        "Run Wexin When PC Boots"
    readonly property string setSaveChatHistory:        "Save Chat History"
    readonly property string setShowWebSearchHistory:   "Show Web Search History"
    readonly property string setAdaptSysScaling:        "Adapt to PC Display Scaling"
    readonly property string setUseDefaultBrowser:      "Open Using Default Browser"
    readonly property string setVoiceAuto2Text:         "Auto-Convert voice message to text"
    readonly property string setChearChatHistory:       "Clear Chat History (15.0G)"
    readonly property string setManagerStorage:         "Manage Storage"

    readonly property string setFileSet:                "File Settings"
    readonly property string setEnableautoDownloadFile: "Enable Auto Download（File size <= 200MB）"
    readonly property string setReadonlyOpenChatFile:   "Open chat files in read-only mode"
    readonly property string setChatFileDefaultDirect:  "Default directory to save Weixin files"
    readonly property string setChangeFolder:           "Change"
    readonly property string setOpenFolder:             "Open Folder"

    readonly property string setSendMessage:            "Send Message"
    readonly property string setTakeScreenshot:         "Take Screenshot"
    readonly property string setOpenChat:               "Open Chat"
    readonly property string setLockChat:               "Lock Chat"
    readonly property string setCheckShortcuts:         "Check Shortcuts"
    readonly property string setShortcutAlreadySet:     "Alert me if shortcut already set"
    readonly property string setRestoreDefault:         "Restore Defaults"

    readonly property string setUpdateInfo:             "Update"
    readonly property string setCheckUpdate:            "Check Update"
    readonly property string setChatHelp:               "Help"
    readonly property string setViewHelp:               "View help"
    readonly property string setTermService:            "Terms of Service"
    readonly property string setPrivacyPolicy:          "Privacy Policy"
    readonly property string setCopyright:              "Copyright @ 2011~2013 x All Rights Reserved."

    readonly property string changeLanguageTip:         "Language reset takes effect after restaring. Reset?"

    /*============================ End ============================*/

    readonly property string searchText:            "Search"
    readonly property string addFriendsText:        "Add Friends"

    // 通讯录管理
    readonly property string ctManageContacts:      "Manage Contacts"
    readonly property string ctNewFriends:          "New Friends"
    readonly property string ctStared:              "Stared"
    readonly property string ctOfficalAccounts:     "Offical Accounts"
    readonly property string ctEnterpriseAccount:   "Enterprise Account"
    readonly property string ctSavedGroups:         "Saved Groups"

    // 聊天模块
    readonly property string chatSendText:          "Send(S)"
    readonly property string chatSendEmptyTip:      "Message to be send cannot be empty"
    readonly property string chatNumber:            "Weixin ID："
    readonly property string chatArea:              "Region："
    readonly property string chatSendMessage:       "Messages"

    readonly property string groupSearchMember:     "Search"
    readonly property string groupShowMore:         "Show All ..."
    readonly property string groupName:             "Group Name"
    readonly property string groupNotice:           "Group Notice"
    readonly property string remark:                "Remark"
    readonly property string remarkPlaceText:       "The name is only visible to this Group"
    readonly property string aliasInGroup:          "My Alias in Group"
    readonly property string chatHistory:           "Chat History"
    readonly property string showGrpupNickNames:    "On-Screen Names"
    readonly property string disturbMessage:        "Mute Notifications"
    readonly property string collapseGroupChat:     "-Minimize Group"
    readonly property string pinnedChat:            "Sicky on Top"
    readonly property string save2AddressBook:      "Save to Contacts"
    readonly property string clearChatHistory:      "Clear Chat History"
    readonly property string exitGroupChat:         "Leave"

    readonly property string menuTickled:           "Tickled"
    readonly property string menuCopy:               "Copy"
    readonly property string menuEdit:               "Edit"
    readonly property string menuTranslate:          "Translate"
    readonly property string menuForward:            "Forward..."
    readonly property string menuFavorites:          "Add to Favorites"
    readonly property string menuSelect:             "Select..."
    readonly property string menuQuote:              "Quote"
    readonly property string menuSearch:             "Search"
    readonly property string menuStickyTop:          "Sticky on Top"
    readonly property string menuDelete:             "Delete"
    readonly property string menuSaveas:             "Save as..."
    readonly property string menuOpenDefaultBrowser: "Open With Default Browser"
    readonly property string menuSpeeech2Text:       "Speech to Text"
    readonly property string menuMutePlay:            "Mute play"
    readonly property string menuOpenFolder:          "Open folder"

    /*============================ End ============================*/

    /*========================= Begin TabWindow ====================*/
    readonly property string tabMiniProgram:            "MiniProgram"
    readonly property string tabSearch:                 "Search"
    readonly property string tabStories:                "Stories"
    readonly property string tabItemOfficalAccounts:    " OfficalAccounts"
    readonly property string tabItemEmoticons:          " Stickers"
    readonly property string tabItemArticle:            " Articles"
    readonly property string tabItemAllText:            "All"
    readonly property string tabItemSearchFind:         "WeChat Top Topics"
    readonly property string tabItemMoments:            " Moments"
    /*========================== End  ============================*/

}
