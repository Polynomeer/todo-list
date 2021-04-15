//
//  ColumnViewDragDelegate.swift
//  ToDoListApp
//
//  Created by 이다훈 on 2021/04/15.
//

import UIKit
import MobileCoreServices

class ColumnViewDragDelegate: NSObject {
}

extension ColumnViewDragDelegate : UITableViewDragDelegate {
    func tableView(_ tableView: UITableView, itemsForBeginning session: UIDragSession, at indexPath: IndexPath) -> [UIDragItem] {
        
        let targetCellId = (tableView.cellForRow(at: indexPath) as! ColumnCell).cellid
        
        guard let cellDatum = DataManager.shared.find(cellId: targetCellId) else {
            return []
        }
        let itemProvider = NSItemProvider()
        let dragItem = UIDragItem(itemProvider: itemProvider)
        dragItem.localObject = cellDatum
        
        return [dragItem]
    }
}
