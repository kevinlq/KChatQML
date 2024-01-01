
function getSearchTypeModel() {
    var itemModel = [
                {"itemText": g_language.tabItemAllText, "itemValue" : "all"},
                {"itemText": g_language.tabItemArticle,   "itemValue" : "article"},
                {"itemText": g_language.tabItemEmoticons,   "itemValue" : "emoticons"},
                {"itemText": g_language.tabItemOfficalAccounts, "itemValue" : "officalAccounts"},
                {"itemText": g_language.tabMiniProgram, "itemValue" : "miniProgram"},
                {"itemText": g_language.tabItemMoments, "itemValue" : "moments"}
            ]
    return itemModel
}
function getHotInfoModel(type) {
    switch(type) {
    case "all":
    case "article":
    case "emoticons":
    case "officalAccounts":
    case "moments":
        return getHotNormalModel()
    case "miniProgram":
        return getMiniProgramModel()
    }
}

function getHotNormalModel() {
    var hotInfoModel = []
    for(var i = 0; i < 10; i++) {
        hotInfoModel.push({"itemText": "考研今天起开考 全国438 万人报名 " + i, "url" : "http://kevinlq.com"})
    }
    return hotInfoModel
}

function getMiniProgramModel() {
    var hotInfoModel = [
                {"itemText": "对战小游戏", "url": "http://kevinlq.com"},
                {"itemText": "休闲小游戏", "url": "http://kevinlq.com"},
                {"itemText": "热门好玩小游戏", "url": "http://kevinlq.com"},
                {"itemText": "塔防小游戏", "url": "http://kevinlq.com"},
                {"itemText": "闯关小游戏", "url": "http://kevinlq.com"},
                {"itemText": "模拟经营小游戏", "url": "http://kevinlq.com"},
                {"itemText": "生存小游戏", "url": "http://kevinlq.com"},
                {"itemText": "经典小游戏", "url": "http://kevinlq.com"},
            ]
    return hotInfoModel
}

// prgram
function getTopProgramData(){
    var itemData = {"itemType": "cardBriefProgram", "itemValues": [
            {"itemText": "最近使用", "itemValues": getRecentlyUsedData()},
            {"itemText": "我的小程序", "itemValues": getMyProgramData()},
        ]}
    return itemData
}
function getMyProgramData() {
    // test data
    var itemData = []
    itemData.push(generateProgramData("腾讯公益", "让公益融入每个人的生活.", "/Config/Theme/images/program10.png", "/Config/Theme/images/program.png"))
    itemData.push(generateProgramData("微信指数", "微信官方提供的基于微信大数据分析的移动端指数.", "/Config/Theme/images/program9.png", "/Config/Theme/images/program.png"))
    itemData.push(generateProgramData("公众平台助手", "公众平台助手，支持公众号管理员及运营者再手机端管理.", "/Config/Theme/images/program8.png", "/Config/Theme/images/program.png"))
    itemData.push(generateProgramData("Readhub", "科技咨询，每天 3 分钟互联网行业动态速览.", "/Config/Theme/images/program7.png", "/Config/Theme/images/program.png"))
    itemData.push(generateProgramData("小商店助手", "商家管理端工具.", "/Config/Theme/images/program6.png", "/Config/Theme/images/program.png"))

    return itemData
}
function getRecentlyUsedData() {
    return getMyProgramData()
}

//Commonly used on PC
function getComUserPCData() {
    var model = getMyProgramData()
    model.push(generateProgramData("微信记账本", "方便快捷的记账工具.", "/Config/Theme/images/program1.png", "/Config/Theme/images/program.png"))
    model.push(generateProgramData("微信记账本", "方便快捷的记账工具.", "/Config/Theme/images/program2.png", "/Config/Theme/images/program.png"))
    model.push(generateProgramData("微信记账本", "方便快捷的记账工具.", "/Config/Theme/images/program3.png", "/Config/Theme/images/program.png"))
    model.push(generateProgramData("微信记账本", "方便快捷的记账工具.", "/Config/Theme/images/program4.png", "/Config/Theme/images/program.png"))
    model.push(generateProgramData("微信记账本", "方便快捷的记账工具.", "/Config/Theme/images/program5.png", "/Config/Theme/images/program.png"))

    var itemData = {"itemType": "singlePrograms", "itemText": "电脑端常用", "itemValues": model}
    return itemData
}
// Optimized for PC
function getOptimizedPCData(){
    var model = getMyProgramData()
    model.push(generateProgramData("微信记账本", "方便快捷的记账工具.", "/Config/Theme/images/program5.png", "/Config/Theme/images/program.png"))
    model.push(generateProgramData("微信记账本", "方便快捷的记账工具.", "/Config/Theme/images/program6.png", "/Config/Theme/images/program.png"))
    model.push(generateProgramData("微信记账本", "方便快捷的记账工具.", "/Config/Theme/images/program7.png", "/Config/Theme/images/program.png"))
    model.push(generateProgramData("微信记账本", "方便快捷的记账工具.", "/Config/Theme/images/program8.png", "/Config/Theme/images/program.png"))
    model.push(generateProgramData("微信记账本", "方便快捷的记账工具.", "/Config/Theme/images/program9.png", "/Config/Theme/images/program.png"))

    var itemData = {"itemType": "blocktemProgram", "itemText": "电脑端常用", "itemValues": model}

    return itemData
}

// Games
function getGamesData() {
    var model = []
    model.push(generateProgramData("欢乐斗地主", "真人对战.", "/Config/Theme/images/game1.png", "/Config/Theme/images/program.png"))
    model.push(generateProgramData("羊了个羊", "通关率仅有百分之 0.01.", "/Config/Theme/images/game2.png", "/Config/Theme/images/program.png"))
    model.push(generateProgramData("公众平台助手", "公众平台助手，支持公众号管理员及运营者再手机端管理.", "/Config/Theme/images/game3.png", "/Config/Theme/images/program.png"))
    model.push(generateProgramData("贪吃蛇大作战", "贪吃蛇大作战，13亿人都在玩的游戏.", "/Config/Theme/images/game4.png", "/Config/Theme/images/program.png"))
    model.push(generateProgramData("冒险大作战", "冒险家族，作战不服.", "/Config/Theme/images/game5.png", "/Config/Theme/images/program.png"))

    var itemData = {"itemType": "blocktemProgram", "itemText": "小游戏专区", "itemValues": model}
    return itemData
}

function generateProgramData(name, des, icon, thumb, url = "https://kevinlq.com/") {
    if(!thumb) {
        thumb = " "
    }
    return {"itemText": name, "des": des ,"icon": icon, "thumb": thumb, "url": url}
}
