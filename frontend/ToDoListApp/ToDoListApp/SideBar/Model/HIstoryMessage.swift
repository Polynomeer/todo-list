//
//  HIstoryMessage.swift
//  ToDoListApp
//
//  Created by 이다훈 on 2021/04/14.
//

import Foundation

protocol HistoryMessage {
    func show() -> String
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
    
    func show() -> String {
        return "moved \(title) from \(from) to \(to)"
    }
}

class addMessage: HistoryMessage {
    let title : String
    let to : String
    
    init(title : String, to : String) {
        self.title = title
        self.to = to
    }
    
    func show() -> String {
        return "added \(title) to \(to)"
    }
}

class removeMessage: HistoryMessage {
    let title : String
    let to : String
    
    init(title : String, to : String) {
        self.title = title
        self.to = to
    }
    
    func show() -> String {
        return "remove \(title) from \(to)"
    }
}

class updateMessage: HistoryMessage {
    let title : String
    let to : String
    
    init(title : String, to : String) {
        self.title = title
        self.to = to
    }
    
    func show() -> String {
        return "update \(title) at \(to)"
    }
}
class nilMessage: HistoryMessage {
    
    func show() -> String {
        return "nil"
    }
}
