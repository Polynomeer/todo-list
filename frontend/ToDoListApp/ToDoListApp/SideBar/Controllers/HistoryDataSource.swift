//
//  HistoryDataSource.swift
//  ToDoListApp
//
//  Created by 이다훈 on 2021/04/13.
//

import UIKit

class HistoryDatasource: NSObject, UITableViewDataSource {
    let positionManager = PositionManager()
    let historyData : [HistoryData]
    
    init(historyDatas : [HistoryData]) {
        self.historyData = historyDatas
        super.init()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return historyData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "HistoryCell", for: indexPath) as? HistoryCell else {
            return UITableViewCell()
        }
        let sortedHistoryData = positionManager.sort(history: historyData)
        
        cell.historyContent.text = "\(sortedHistoryData[indexPath.row].author) \(sortedHistoryData[indexPath.row].title)"
        cell.historyDate.text = "\(sortedHistoryData[indexPath.row].date)"
        return cell
    }
}
