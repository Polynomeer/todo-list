//
//  HIstoryMessage.swift
//  ToDoListApp
//
//  Created by 이다훈 on 2021/04/14.
//

import UIKit

protocol HistoryMessage {
    func show() -> NSAttributedString
}

class moveMessage: HistoryMessage {
    let title : String
    let from : String
    let to : String
    
    init(title : String, from : String, to : String) {
        self.title = title
        self.from = from
        self.to = to
    }
    
    func show() -> NSAttributedString {
        let string = "moved \(title) from \(from) to \(to)"
        
        let attributedString = NSMutableAttributedString(string: string)
        attributedString.addAttribute(.font, value: UIFont.boldSystemFont(ofSize: 17), range: (string as NSString).range(of: "\(title)"))
        
        attributedString.addAttribute(.font, value: UIFont.boldSystemFont(ofSize: 17), range: (string as NSString).range(of: "\(from)"))
        
        attributedString.addAttribute(.font, value: UIFont.boldSystemFont(ofSize: 17), range: (string as NSString).range(of: "\(to)"))
        
        return attributedString
    }
}

class addMessage: HistoryMessage {
    let title : String
    let to : String
    
    init(title : String, to : String) {
        self.title = title
        self.to = to
    }
    
    func show() -> NSAttributedString {
        let string = "added \(title) to \(to)"
        
        let attributedString = NSMutableAttributedString(string: string)
        attributedString.addAttribute(.font, value: UIFont.boldSystemFont(ofSize: 17), range: (string as NSString).range(of: "\(title)"))
        
        attributedString.addAttribute(.font, value: UIFont.boldSystemFont(ofSize: 17), range: (string as NSString).range(of: "\(to)"))
        return attributedString
    }
}

class removeMessage: HistoryMessage {
    let title : String
    let to : String
    
    init(title : String, to : String) {
        self.title = title
        self.to = to
    }
    
    func show() -> NSAttributedString {
        let string = "remove \(title) from \(to)"
        
        let attributedString = NSMutableAttributedString(string: string)
        attributedString.addAttribute(.font, value: UIFont.boldSystemFont(ofSize: 17), range: (string as NSString).range(of: "\(title)"))
        
        attributedString.addAttribute(.font, value: UIFont.boldSystemFont(ofSize: 17), range: (string as NSString).range(of: "\(to)"))
        return attributedString
    }
}

class updateMessage: HistoryMessage {
    let title : String
    let to : String
    
    init(title : String, to : String) {
        self.title = title
        self.to = to
    }
    
    func show() -> NSAttributedString {
        let string = "update \(title) at \(to)"
        
        let attributedString = NSMutableAttributedString(string: string)
        attributedString.addAttribute(.font, value: UIFont.boldSystemFont(ofSize: 17), range: (string as NSString).range(of: "\(title)"))
        
        attributedString.addAttribute(.font, value: UIFont.boldSystemFont(ofSize: 17), range: (string as NSString).range(of: "\(to)"))
        return attributedString
    }
}
class nilMessage: HistoryMessage {
    
    func show() -> NSAttributedString {
        let string = "nil"
        let attributedString = NSMutableAttributedString(string: string)
        
        return attributedString
    }
}
