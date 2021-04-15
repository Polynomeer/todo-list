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
    
    private func findLastCardId() -> Int? {
        if cellData.isEmpty == true {
            return nil
        }
        
        guard var max = cellData.first?.cardId else {
            return nil
        }
        
        for cellDatum in cellData {
            max = cellDatum.cardId > max ? cellDatum.cardId : max
        }
        
        return max
    }
    func nextCellId() -> Int {
        guard let max = findLastCardId() else {
            return 0
        }
        
        return max + 1
    }
    
    func find(cellId: Int) -> CellData? {
        return cellData.first(where: { cellData in
            cellData.cardId == cellId
        })
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
    
    func getCells(with columnId : Int) -> [CellData] {
        return cellData.filter({ cellData in
            cellData.columnId == columnId
        })
    }
    
    func cellDataTitle(index : Int) -> String{
        return cellData[index].title
    }
    
    func cellDataContent(index : Int) -> String{
        return cellData[index].content
    }

    func makeCellData(columnID: Int) -> CellData {
        guard let titlefieldText = titleTextField.text,
              let contentFieldText = contentTextField.text
        else { return CellData.init(columnId: columnID, cardId: -1, title: "", content: "", isApp: true, createdTime: "", position: 0) }
        
        }
    
    func makeCellData(columnID: Int, titleTextField: String, contentTextField: String) -> CellData {
        let nextCardId = DataManager.shared.nextCellId()
        let cellData : CellData = CellData.init(columnId: columnID, cardId: nextCardId, title: titleTextField, content: contentTextField, isApp: true, createdTime: Date().convert(), position: 0)
        return cellData
    }
}
