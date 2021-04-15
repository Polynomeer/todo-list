//
//  SideBarPresentationAnimator.swift
//  ToDoListApp
//
//  Created by 이다훈 on 2021/04/13.
//

import UIKit

class SideBarPresentationAnimator : NSObject {
    var isPresent : Bool
    
    init(isPresent : Bool) {
        self.isPresent = isPresent
        super.init()
    }
}

extension SideBarPresentationAnimator : UIViewControllerAnimatedTransitioning {
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 1
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        let key : UITransitionContextViewControllerKey = isPresent ? .to : .from
        
        guard let controller = transitionContext.viewController(forKey: key) else {
            return
        }
        
        if isPresent {
            transitionContext.containerView.addSubview(controller.view)
        }
        
        let presentFrame = transitionContext.finalFrame(for: controller)
        var dismissFrame = presentFrame
        dismissFrame.origin.x += presentFrame.width
        
        let initialFrame = isPresent ? dismissFrame : presentFrame
        let finalFrame = isPresent ? presentFrame : dismissFrame
        
        controller.view.frame = initialFrame
        UIView.animate(withDuration: transitionDuration(using: transitionContext),
                       animations: {
                        controller.view.frame = finalFrame
                       },
                       completion: { isFinish in
                        if !self.isPresent {
                            controller.view.removeFromSuperview()
                        }
                        transitionContext.completeTransition(isFinish)
                       })
    }
}
