//
//  SideBarPresentationController.swift
//  ToDoListApp
//
//  Created by 이다훈 on 2021/04/13.
//

import UIKit

class SideBarPresentationController: UIPresentationController {
    override var frameOfPresentedViewInContainerView: CGRect {
        var frame : CGRect = . zero
        
        guard let containerView = containerView else {
            return frame
        }
        
        frame = .init(x: containerView.bounds.width - 428, y: 0, width: 0, height: 0)
        frame.size = CGSize(width: 428, height: containerView.bounds.height)
        
        return frame
    }
}
