.pragma library

var levels = {
    trace: 0,
    debug: 1,
    info: 2,
    warning: 3,
    error: 4,
    fatal: 5
};

var apiObj = null
var inited = false

function initLevel(parentItem, levelObj) {
    if(inited) {
        return true
    }
    apiObj = parentItem
    for(var key in levelObj) {
        if(levels.hasOwnProperty(key)) {
            levels[key] = levelObj[key];
        }
    }
    inited = true
    return true
}

function trace() {
    return write2Log(levels.trace, arguments)
}
function debug() {
    return write2Log(levels.debug, arguments)
}
function info() {
    return write2Log(levels.info, arguments)
}
function warning() {
    return write2Log(levels.warning, arguments)
}
function error() {
    return write2Log(levels.error, arguments)
}
function fatal() {
    return write2Log(levels.fatal, arguments)
}
function log(){
    return write2Log(levels.debug, arguments)
}
function write2Log(level, arg) {
    var msg = ""
    for(var i in arg) {
        msg += (arg[i] +" ");
    }
    return apiObj.write2Log(level, msg)
}
