//
//  CellData.swift
//  ToDoListApp
//
//  Created by 박정하 on 2021/04/07.
//

import Foundation

class CellData : Codable {
    
    var columnId : Int
    var cardId : Int
    var title : String
    var content: String
    var isApp : Bool
    var createdTime : String
    var position: Int
    
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
    
    func setCaption(){
        if !isApp {
            
        }
        else {
            
        }
    }
    
}
