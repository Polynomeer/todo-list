//
//  ColumnViewController.swift
//  ToDoListApp
//
//  Created by 박정하 on 2021/04/07.
//

import UIKit

class ColumnViewController : UIViewController {
    @IBOutlet weak var columnTitle: UILabel!
    @IBOutlet weak var columnTableView: UITableView!
    private let columnDataSource = ColumnDataSource(datamanager: ColumnDatas())
    private let columnDelegate = ColumnDelegate()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        columnTableView.delegate = columnDelegate
        columnTableView.dataSource = columnDataSource
    }
}
