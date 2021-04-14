//
//  HistoryDataSource.swift
//  ToDoListApp
//
//  Created by 이다훈 on 2021/04/13.
//

import UIKit

class HistoryDatasource: NSObject, UITableViewDataSource {
    
    let historyDatas : [HistoryData]
    
    init(historyDatas : [HistoryData]) {
        self.historyDatas = historyDatas
        super.init()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return historyDatas.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "HistoryCell", for: indexPath) as? HistoryCell else {
            return UITableViewCell()
        }
        cell.historyContent.text = "\(historyDatas[indexPath.row].author) \(historyDatas[indexPath.row].title)"
        cell.historyDate.text = "\(historyDatas[indexPath.row].date)"
        return cell
    }
}
