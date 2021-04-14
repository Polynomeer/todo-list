//
//  String+Extension.swift
//  ToDoListApp
//
//  Created by 이다훈 on 2021/04/14.
//

import Foundation

extension String {
    func toDate() -> Date? { //"yyyy-MM-dd HH:mm:ss"
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        dateFormatter.timeZone = TimeZone(identifier: "UTC")
        if let date = dateFormatter.date(from: self) {
            return date
        }
        else {
            return nil
        }
    }
}
