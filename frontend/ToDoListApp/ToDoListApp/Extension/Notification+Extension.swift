//
//  Notification+Extension.swift
//  ToDoListApp
//
//  Created by 박정하 on 2021/04/14.
//

import Foundation

extension Notification.Name {
    static var addCard = Notification.Name.init("addCard")
    static var addData = Notification.Name.init("addData")
    static var deleteData = Notification.Name.init("DeleteData")
}
