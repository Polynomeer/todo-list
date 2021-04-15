//
//  ColumnViewDropDelegate.swift
//  ToDoListApp
//
//  Created by 이다훈 on 2021/04/15.
//

import UIKit

class ColumnViewDropDelegate: NSObject {
    var columnId = Int()
}

extension ColumnViewDropDelegate : UITableViewDropDelegate {
    func tableView(_ tableView: UITableView, performDropWith coordinator: UITableViewDropCoordinator) {
        var destinationIndexPath: IndexPath

        if let indexPath = coordinator.destinationIndexPath {
            destinationIndexPath = indexPath
        } else {
            destinationIndexPath = IndexPath(row: 0, section: 0)
        }
        
        guard let dragItems = coordinator.session.localDragSession?.items else {
            return
        }
        let localObjects = dragItems.compactMap {
            return $0.localObject as? CellData
        }
        localObjects.forEach({
            DataManager.shared.move(to: self.columnId, cellId: $0.cardId)
        })
        
        NotificationCenter.default.post(name: .reloadAllColumnTable, object: self)
    }
    
}
