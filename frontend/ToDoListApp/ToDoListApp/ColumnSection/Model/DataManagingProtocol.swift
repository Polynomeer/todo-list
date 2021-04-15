//
//  DataManager.swift
//  ToDoListApp
//
//  Created by 박정하 on 2021/04/07.
//

import Foundation

protocol DataManagingProtocol {
    func currentDataCount(columnId : Int) -> Int
    func add(cellData : CellData) -> Void
    func remove(index : Int) -> Void
    func cellDataTitle(index : Int) -> String
    func cellDataContent(index : Int) -> String
}
