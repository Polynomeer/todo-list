//
//  SideBarViewController.swift
//  ToDoListApp
//
//  Created by 이다훈 on 2021/04/12.
//

import UIKit

class SideBarViewController: UIViewController {
    @IBOutlet weak var historyTableView: UITableView!
    
    @IBAction func dismissButtonPushed(_ sender: Any) {
        DispatchQueue.main.async {
            self.dismiss(animated: true, completion: nil)
        }
    }
    
    let historyDatasource = HistoryDatasource()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        historyTableView.dataSource = historyDatasource
    }
}
