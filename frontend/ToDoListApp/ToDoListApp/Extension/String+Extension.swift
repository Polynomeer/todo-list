//
//  String+Extension.swift
//  ToDoListApp
//
//  Created by 이다훈 on 2021/04/14.
//

import UIKit

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
    
    func emphasize(target words : String...) -> NSMutableAttributedString {
        let attributedString = NSMutableAttributedString(string: self)
        
        for word in words {
            attributedString.addAttribute(.font, value: UIFont.boldSystemFont(ofSize: 17), range: (self as NSString).range(of: "\(word)"))
        }
        
        return attributedString
    }
}
