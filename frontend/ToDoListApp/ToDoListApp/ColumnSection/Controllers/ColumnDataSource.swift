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
    
    func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
            true
    }
    
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        let columnData = DataManager.shared.getCells(with: columnId)
        let sorted = DataManager.shared.positionManager.sort(card: columnData)
        
        let selectedCard = sorted[sourceIndexPath.section]
        
        DataManager.shared.positionManager.setPosition(target: selectedCard.cardId, column: columnId, to: destinationIndexPath.section)
        NetworkService.shared.putRequest(card: selectedCard, api: .deleteOrUpdateCell, closure: {
            result in
            switch result {
            case .success(let data):
                print(data)
            case .failure(let error):
                print(error)
            }
        })
        
        let index = IndexSet(integer: sourceIndexPath.section)
        tableView.deleteSections(index, with: .fade)
        
        let newIndex = IndexSet(integer: destinationIndexPath.section)
        tableView.insertSections(newIndex, with: .fade)
        
        
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
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete{
            DataManager.shared.remove(index: indexPath.section, columnId: columnId)
        }
    }
}
