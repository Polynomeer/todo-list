//
//  HistoryData.swift
//  ToDoListApp
//
//  Created by 이다훈 on 2021/04/13.
//

import Foundation

class HistoryData: Codable {
    var author : String
    var title : String
    var action : String
    var from : String?
    var to : String?
    var date : String
}
