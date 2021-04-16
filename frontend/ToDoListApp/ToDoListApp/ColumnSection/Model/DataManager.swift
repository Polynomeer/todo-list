//
//  ColumnData.swift
//  ToDoListApp
//
//  Created by 박정하 on 2021/04/07.
//

import Foundation

class DataManager : DataManagingProtocol {
    static var shared = DataManager()
    
    private var cellData : [CellData]
    let positionManager = PositionManager()
    
    init() {
        cellData = []
    }
    
    func setData(cells : [CellData]) {
        cellData.append(contentsOf: cells)
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
            return 1
        }
        
        return max + 1
    }
    
    func find(cellId: Int) -> CellData? {
        return cellData.first(where: { cellData in
            cellData.cardId == cellId
        })
    }
    
    func modifyCellData(cellData : CellData) -> Void {
        guard let target = self.cellData.firstIndex(where: {
            $0.cardId == cellData.cardId
        }) else {
            return
        }
        self.cellData[target] = cellData
    }
    
    func add(cellData : CellData) -> Void{
        self.cellData.append(cellData)
        NotificationCenter.default.post(name: Notification.Name.addData, object: self, userInfo: ["columnId" : cellData.columnId])
        NotificationCenter.default.post(name: .reloadAllColumnTable, object: self)
    }
    
    func remove(index : Int, columnId : Int) -> Void {
        let cards = getCells(with: columnId)
        let sorted = positionManager.sort(card: cards)
        guard let target = cellData.firstIndex(where: {
            $0.cardId == sorted[index].cardId
        }) else {
            return
        }
        print(cellData[target].title, cellData[target].cardId)
        
        NetworkService.shared.deleteRequest(cardId: cellData[target].cardId, api: .deleteOrUpdateCell, closure: { result in
            switch result {
            case .success(let data):
                print(data)
            case .failure(let error):
                print(error)
            }
        })
        cellData.remove(at: target)
        let IndexAndColumnID : [Int] = [index, columnId]
        NotificationCenter.default.post(name: Notification.Name.deleteData, object: self, userInfo: ["delete" : IndexAndColumnID])
    }
    
    func move(to column: Int, cellId : Int) -> Void{
        guard let cellIndex = cellData.firstIndex(where: { cell in
            cell.cardId == cellId
        }) else {
            return
        }
        cellData[cellIndex].columnId = column
    }
    
    func setPosition(cellId : Int, position : Int) {
        guard let cellIndex = cellData.firstIndex(where: { cell in
            cell.cardId == cellId
        }) else {
            return
        }
        cellData[cellIndex].position = position
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
    
    func makeCellData(columnID: Int, titleTextField: String, contentTextField: String) -> CellData {
        let nextCardId = DataManager.shared.nextCellId()
        let cards = DataManager.shared.getCells(with: columnID)
        
        let positionManager = PositionManager()
        let nextPosition = positionManager.nextPosition(with: cards)
        
        let cellData : CellData = CellData.init(columnId: columnID, cardId: nextCardId, title: titleTextField, content: contentTextField, isApp: true, createdTime: Date().convert(), position: nextPosition)
        return cellData
    }
}
