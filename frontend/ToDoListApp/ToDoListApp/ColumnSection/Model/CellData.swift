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
    var createdTime : String
    var position: Int
}
