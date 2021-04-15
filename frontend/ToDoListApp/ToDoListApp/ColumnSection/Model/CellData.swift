//
//  CellData.swift
//  ToDoListApp
//
//  Created by 박정하 on 2021/04/07.
//

import Foundation

class CellData : Codable {
    
    var cardId : Int
    var title : String
    var content: String
    var isApp : Bool
    var position: Int
    var columnId : Int
    var createdTime : String
    
    init(columnId: Int,
        cardId: Int,
        title : String,
        content: String,
        isApp : Bool,
        createdTime : String,
        position: Int) {
        self.columnId = columnId
        self.cardId = cardId
        self.title = title
        self.content = content
        self.isApp = isApp
        self.createdTime = createdTime
        self.position = position
    }
}
