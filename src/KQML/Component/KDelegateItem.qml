import QtQuick 2.15

Item {

    function parseModel(model){
        var childValues = []
        if(!model) {
            return childValues
        }
        for(var i = 0; i < model.count; i++) {
            var obj = model.get(i)
            var subModel = {}
            for(var property in obj) {
                var type = typeof(obj[property])
                var value = undefined
                if ("string" === type) {
                    value = obj[property]
                }
                else if("object" === type) {
                    value = parseModel(obj[property])
                }
                if(!value) {
                    continue
                }

                subModel[property] = value
            }
            if(!subModel) {
                continue
            }
            childValues.push(subModel)
        }
        return childValues
    }
}
