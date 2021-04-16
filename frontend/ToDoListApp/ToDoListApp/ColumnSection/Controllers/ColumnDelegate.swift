//
//  Column1Delegate.swift
//  ToDoListApp
//
//  Created by 박정하 on 2021/04/07.
//

import UIKit

class ColumnDelegate : NSObject, UITableViewDelegate{
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
                DataManager.shared.move(to: 2, cellId: cell.cellid)
            }
            let fix = UIAction(title: "수정하기", image: UIImage(systemName: "pencil")){ _ in
                print("fix was selected")
            }
            let delete = UIAction(title: "삭제하기", image: UIImage(systemName: "trash.fill"), attributes: .destructive){_ in
                
            }
            return UIMenu(title: "", children: [moveTodone, fix, delete])
        }
    }
}
