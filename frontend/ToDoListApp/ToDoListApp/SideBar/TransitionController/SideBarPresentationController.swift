//
//  SideBarPresentationController.swift
//  ToDoListApp
//
//  Created by 이다훈 on 2021/04/13.
//

import UIKit

class SideBarPresentationController: UIPresentationController {
    var sideBarWidth : Int
    
    init(presentedViewController: UIViewController, presenting presentingViewController: UIViewController?, width : Int) {
        self.sideBarWidth = width
        super.init(presentedViewController: presentedViewController, presenting: presentingViewController)
    }
    
    override var frameOfPresentedViewInContainerView: CGRect {
        var frame : CGRect = . zero
        
        guard let containerView = containerView else {
            return frame
        }
        
        frame = .init(x: Int(containerView.bounds.width) - sideBarWidth, y: 0, width: 0, height: 0)
        frame.size = CGSize(width: sideBarWidth, height: Int(containerView.bounds.height))
        
        return frame
    }
}
