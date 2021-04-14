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
        
        cell.historyContent.text = createHistoryMessage(with: sortedHistoryData[indexPath.row]).show()
        cell.historyDate.text = timelapseMessage(with: sortedHistoryData[indexPath.row].date)
        return cell
    }
    
    private func createHistoryMessage(with data : HistoryData) -> HistoryMessage {
        switch data.action {
        case "move":
            return moveMessage.init(title: data.title, from: data.from!, to: data.to!)
        case "add":
            return addMessage.init(title: data.title, to: data.to!)
        case "remove":
            return removeMessage.init(title: data.title, to: data.to!)
        case "update":
            return updateMessage.init(title: data.title, to: data.to!)
        default:
            return nilMessage()
        }
        
    }
    
    private func timelapseMessage(with dateString : String) -> String {
        guard let date = dateString.toDate() else {
            return "알 수 없음"
        }
        let min = 60
        let hour = min * 60
        let day = hour * 24
        
        let timeGap = abs(Int(date.timeIntervalSince(Date())))
        
        if timeGap / day > 0 {
            return "\(timeGap / day)일 전"
        }
        
        if timeGap / hour > 0 {
            return "\(timeGap / hour)시간 전"
        }
        
        if timeGap / min > 0 {
            return "\(timeGap / min)분 전"
        }
        
        return "방금 전"
    }
}
