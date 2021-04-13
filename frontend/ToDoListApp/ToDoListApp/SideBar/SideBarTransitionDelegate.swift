//
//  SideBarTransitionDelegate.swift
//  ToDoListApp
//
//  Created by 이다훈 on 2021/04/13.
//

import UIKit

class SideBarTransitionDelegate: NSObject {
    var sideBarWidth : Int = 428
}

extension SideBarTransitionDelegate : UIViewControllerTransitioningDelegate {
    func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {
        return SideBarPresentationController(presentedViewController: presented, presenting: presenting, width : sideBarWidth)
    }
    
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return SideBarPresentationAnimator(isPresent: true)
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return SideBarPresentationAnimator(isPresent: false)
    }
}
