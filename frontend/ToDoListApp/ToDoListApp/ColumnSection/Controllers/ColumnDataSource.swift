//
//  ColumnDataSource.swift
//  ToDoListApp
//
//  Created by 박정하 on 2021/04/07.
//

import UIKit

class ColumnDataSource : NSObject, UITableViewDataSource {
    var columnId : Int!

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return DataManager.shared.currentDataCount(columnId: columnId)
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIdentifier : String = "ColumnCell"
        guard let cell : ColumnCell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? ColumnCell else {
            return UITableViewCell()
        }
        let columnData = DataManager.shared.getCells(with: columnId)
        let sorted = DataManager.shared.positionManager.sort(card: columnData)
        
        cell.updateCell(title: sorted[indexPath.section].title, content: sorted[indexPath.section].content)
        cell.cellid = sorted[indexPath.section].cardId
        
        NotificationCenter.default.post(name: .reloadAllColumnTable, object: nil)
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete{
            DataManager.shared.remove(index: indexPath.section)
            tableView.deleteSections(IndexSet(integer: indexPath.section), with: .fade)
        }
    }
}
