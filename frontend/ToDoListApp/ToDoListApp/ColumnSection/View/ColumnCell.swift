//
//  Column1Cell.swift
//  ToDoListApp
//
//  Created by 박정하 on 2021/04/07.
//

import UIKit

class ColumnCell : UITableViewCell {
    
    @IBOutlet weak private var title : UILabel!
    @IBOutlet weak private var content : UILabel!
    @IBOutlet weak private var caption : UILabel!
    
    var cellid : Int = Int()
    
    func updateCell(title: String, content: String){
        self.title.text = title
        self.content.text = content
    }
}

extension ColumnCell {
}
