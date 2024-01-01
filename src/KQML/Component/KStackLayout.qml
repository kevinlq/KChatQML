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
import QtQuick.Layouts 1.3

StackLayout {
    id: controlLayout
    clip: true
    currentIndex: 0
    Repeater {
        model: ObjectModel {
            id: _container
        }
    }

    function activeItem(url){
        var pageItem = findItem(url)
        if(null === pageItem) {
            pageItem = createItem(url, controlLayout)
            if(null === pageItem) {
                return null
            }
            appendItem(pageItem)
        }
        controlLayout.currentIndex = pageItem.StackLayout.index
        return pageItem
    }
    function removeItem(url){
        var pageItem = findItem(url)
        if(null === pageItem) {
            return false
        }
        _container.remove(_container.index, 1)
        //pageItem.destroy()    // TODO: obj will auto delete
        return true
    }

    function findItem(url){
        for(var i = 0; i <_container.count; i++) {
            var pageItem = _container.get(i)
            if ( url === pageItem.url) {
                return pageItem
            }
        }
        return null
    }
    function appendItem(item){
        _container.append(item)
    }

    function createItem(url, parent) {
        var comp = Qt.createComponent(url)
        if(!comp) {
            console.error("create fail,", url)
            return null
        }

        if (comp.status !== Component.Ready) {
            console.error("Error loading component:", comp.errorString(), url);
            return null
        }
        var options = Object.assign({}, {url:url})
        return comp.createObject(parent,options)
    }
}
