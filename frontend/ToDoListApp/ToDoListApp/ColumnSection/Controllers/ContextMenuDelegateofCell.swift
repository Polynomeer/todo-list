//
//  ContextMenuDelegateofCell.swift
//  ToDoListApp
//
//  Created by 박정하 on 2021/04/13.
//

import UIKit

class ContextMenuDelegateofCell : NSObject, UIContextMenuInteractionDelegate {
     
    private let datas : DataManager
    
    init(datas: DataManager) {
        self.datas = datas
    }
    
    func contextMenuInteraction(_ interaction: UIContextMenuInteraction, configurationForMenuAtLocation location: CGPoint) -> UIContextMenuConfiguration? {
        return UIContextMenuConfiguration(
            identifier: nil,
            previewProvider: nil) { (suggestedActions) -> UIMenu? in
            let moveTodone = UIAction(title: "완료한 일로 이동", image: UIImage(systemName: "arrow.right.doc.on.clipboard")) { _ in
                print("Copy was selected")
            }
            let fix = UIAction(title: "수정하기", image: UIImage(systemName: "pencil")){ _ in
                print("fix was selected")
            }
            let delete = UIAction(title: "삭제하기", image: UIImage(systemName: "trash.fill"), attributes: .destructive){_ in
                NotificationCenter.default.post(name: NSNotification.Name("deleteCell"), object: self, userInfo: ["abcd":"abcd"])
            }
            return UIMenu(title: "", children: [moveTodone, fix, delete])
        }
    }
}
