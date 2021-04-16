//
//  Column1Delegate.swift
//  ToDoListApp
//
//  Created by 박정하 on 2021/04/07.
//

import UIKit

class ColumnDelegate : NSObject, UITableViewDelegate{
    var columnId : Int!
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return CGFloat(10)
    }
    
    func tableView(_ tableView: UITableView, contextMenuConfigurationForRowAt indexPath: IndexPath, point: CGPoint) -> UIContextMenuConfiguration? {
        return UIContextMenuConfiguration(
            identifier: nil,
            previewProvider: nil) { (suggestedActions) -> UIMenu? in
            let moveTodone = UIAction(title: "완료한 일로 이동", image: UIImage(systemName: "arrow.right.doc.on.clipboard")) { _ in
                guard let cell = tableView.cellForRow(at: indexPath) as? ColumnCell else {
                    return
                }
                DataManager.shared.move(to: 3, cellId: cell.cellid)
                DataManager.shared.positionManager.setPosition(target: cell.cellid, column: 3, to: Int.max)
                guard let targetCellData = DataManager.shared.find(cellId: cell.cellid) else {
                    return
                }
                NetworkService.shared.putRequest(card: targetCellData, api: .deleteOrUpdateCell, closure: {
                    result in
                    switch result {
                    case .success(let data):
                        print(data)
                    case .failure(let error):
                        print(error)
                    }
                })
                NotificationCenter.default.post(name: .reloadAllColumnTable, object: self)
            }
            let fix = UIAction(title: "수정하기", image: UIImage(systemName: "pencil")){ _ in
                guard let cell = tableView.cellForRow(at: indexPath) as? ColumnCell else {
                    return
                }
                guard let cardData = DataManager.shared.find(cellId: cell.cellid) else {
                    return
                }
                NotificationCenter.default.post(name: .modifyCard, object: self, userInfo: ["CardData" : cardData])
            }
            let delete = UIAction(title: "삭제하기", image: UIImage(systemName: "trash.fill"), attributes: .destructive){_ in
                DataManager.shared.remove(index: indexPath.section, columnId: self.columnId)
                NotificationCenter.default.post(name: .reloadAllColumnTable, object: self)
            }
            return UIMenu(title: "", children: [moveTodone, fix, delete])
        }
    }
}
