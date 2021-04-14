//
//  SideBarViewController.swift
//  ToDoListApp
//
//  Created by 이다훈 on 2021/04/12.
//

import UIKit

class SideBarViewController: UIViewController {
    @IBOutlet weak var historyTableView: UITableView!
    var historyDatas = [HistoryData]()
    var historyDatasource : HistoryDatasource!
    
    @IBAction func dismissButtonPushed(_ sender: Any) {
        DispatchQueue.main.async {
            self.dismiss(animated: true, completion: nil)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        historyDatasource = HistoryDatasource(historyDatas: historyDatas)
        historyTableView.dataSource = historyDatasource
    }
}
