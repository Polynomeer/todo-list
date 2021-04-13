//
//  SideBarTransitionDelegate.swift
//  ToDoListApp
//
//  Created by 이다훈 on 2021/04/13.
//

import UIKit

class SideBarTransitionDelegate: NSObject {
     
}

extension SideBarTransitionDelegate : UIViewControllerTransitioningDelegate {
    func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {
        return SideBarPresentationController(presentedViewController: presented, presenting: presenting)
    }
}
