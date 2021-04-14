//
//  ColumnDataSource.swift
//  ToDoListApp
//
//  Created by 박정하 on 2021/04/07.
//

import UIKit

class ColumnDataSource : NSObject, UITableViewDataSource {
    private let datas : DataManager
    
    private let cellInteractionDelegate : ContextMenuDelegateofCell
    private var cellInteraction : UIContextMenuInteraction
    
    init(datamanager : DataManager) {
        self.datas = datamanager
        self.cellInteractionDelegate = ContextMenuDelegateofCell(datas : datamanager)
        self.cellInteraction = UIContextMenuInteraction(delegate: cellInteractionDelegate)
        super.init()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return datas.currentDatasCount() //reload achive?
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell : ColumnCell = tableView.dequeueReusableCell(withIdentifier: "ColumnCell", for: indexPath) as? ColumnCell else {return UITableViewCell()}
        cell.update(title: datas.cellDataTitle(index: indexPath.section))
        cell.update(content: datas.cellDataContent(index: indexPath.section))
        cell.addInteraction(cellInteraction)
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete{
            datas.remove(index: indexPath.section)
            tableView.deleteSections(IndexSet(integer: indexPath.section), with: .fade)
        }
    }
}
