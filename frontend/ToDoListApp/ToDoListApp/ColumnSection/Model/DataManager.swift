//
//  ColumnDatas.swift
//  ToDoListApp
//
//  Created by 박정하 on 2021/04/07.
//

import Foundation

class DataManager : DataManagingProtocol{
    static var shared = DataManager()
    
    private var cellData : [CellData]
    
    init() {
        cellData = []
    }
    
    func add(cellData : CellData) -> Void{
        self.cellData.append(cellData)
    }
    func remove(index : Int) -> Void {
        cellData.remove(at: index)
    }
    
    func move(to column: Int, cellId : Int) -> Void{
        guard let cellIndex = cellData.firstIndex(where: { cell in
            cell.cardId == cellId
        }) else {
            return
        }
        cellData[cellIndex].columnId = column
    }
    
    func currentDatasCount(columnId : Int) -> Int{
        return cellData.filter({ cellData in
            cellData.columnId == columnId
        }).count
    }
    
    func cellDataTitle(index : Int) -> String{
        return cellData[index].title
    }
    
    func cellDataContent(index : Int) -> String{
        return cellData[index].content
    }
}
