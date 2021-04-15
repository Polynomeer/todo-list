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
        return string.emphasize(target: self.title, self.to, self.from)
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
        return string.emphasize(target: self.title, self.to)
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
        return string.emphasize(target: self.title, self.to)
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
        return string.emphasize(target: self.title, self.to)
    }
}
class nilMessage: HistoryMessage {
    
    func show() -> NSAttributedString {
        let string = "nil"
        let attributedString = NSMutableAttributedString(string: string)
        
        return attributedString
    }
}
