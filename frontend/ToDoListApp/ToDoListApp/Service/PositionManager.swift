//
//  PositionManager.swift
//  ToDoListApp
//
//  Created by 이다훈 on 2021/04/08.
//

import Foundation

class PositionManager {
    
    let statingValue = 1024
    let gap = 125
    
    func getMaxPosition(in array : [CellData]) -> Int? {
        if array.isEmpty == true {
            return nil
        }
        guard var max = array.first?.position else { return nil }
        
        for cellData in array {
            max = cellData.position > max ? cellData.position : max
        }
        
        return max
    }
    
    func nextPosition(with array : [CellData]) -> Int {
        if array.isEmpty {
            return statingValue
        }
        
        guard let max = getMaxPosition(in: array) else {
            return statingValue
        }
        
        return max + gap
    }
    
    func relocate(array : [CellData]) -> [CellData] {
        let sorted = array.sorted(by: { lhs,rhs in
            lhs.position < rhs.position
        })
        
        var newPosition = statingValue
        for cellData in sorted {
            cellData.position = newPosition
            newPosition += gap
        }
        
        return sorted
    }
    
    func sort(history array : [HistoryData]) -> [HistoryData] {
        var sorted = array.sorted(by: { lhs, rhs in
            
            guard let lhsDate = lhs.date.toDate(),
                  let rhsDate = rhs.date.toDate() else {
                return false
            }
            return lhsDate > rhsDate
        })
        return sorted
    }
    
    func sort(card array : [CellData]) -> [CellData] {
        var sorted = array.sorted(by: { lhs, rhs in
            
            let lhsPosition = lhs.position
            let rhsPosition = rhs.position
            
            return lhsPosition > rhsPosition
        })
        return sorted
    }
    
    func setPosition(target cardId : Int, column : Int, to index : Int) {
        let columnCards = DataManager.shared.getCells(with: column)
        let cards = self.sort(card: columnCards)
        
        var lower = Int()
        var upper = Int()
        if index == 0 {
            upper = DataManager.shared.positionManager.nextPosition(with: cards)
            lower = cards[index].position
        } else if index == cards.count - 1 {
            upper = cards[index].position
            lower = 0
        } else {
            upper = cards[index - 1].position
            lower = cards[index + 1].position
        }
        
        let median = (upper + lower) / 2
        
        DataManager.shared.setPosition(cellId: cardId, position: median)
    }
}
