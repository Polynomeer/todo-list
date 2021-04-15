//
//  ColumnData.swift
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
        NotificationCenter.default.post(name: Notification.Name.addData, object: self, userInfo: ["columnId" : cellData.columnId])
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
    
    func currentDataCount(columnId : Int) -> Int{
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
    
    func makeCellData(ColumnID: Int, titleTextField: String, contentTextField: String) -> CellData {
        let tempCellData : CellData = CellData.init(columnId: ColumnID, cardId: 0, title: titleTextField, content: contentTextField, isApp: false, createdTime: "", position: 0)
        return tempCellData
    }
}
