//
//  NavigationControllerAnimationPresentable.swift
//  HashMe
//
//  Created by Dheeru on 10/11/17.
//  Copyright © 2017 Dheeru. All rights reserved.
//

import Foundation
import UIKit

public protocol NavigationControllerAnimationPresentable: NavigationFlowControllable {
    
    /// This is a navigation animation helps especially when you work on Modals. This is a navigation push, but animation looks like navigation present.
    ///
    /// - Parameter viewController: ViewController that needs to be pushed.
    func pushViewControllerWithAnimation(_ viewController: UIViewController)
    
    /// This pops the top view controller
    func popViewControllerWithAnimation()
    
    /// This will collapse the complete navigation controller.
    func collapseTheNavigationController()
}

public extension NavigationControllerAnimationPresentable {
    func pushViewControllerWithAnimation(_ viewController: UIViewController) {
        let transition: CATransition = CATransition()
        transition.duration = 0.5
        transition.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
        transition.type = kCATransitionMoveIn
        transition.subtype = kCATransitionFromTop
        self.navigationController?.view.layer.add(transition, forKey: kCATransition)
        if let validNavController = self.navigationController {
            validNavController.pushViewController(viewController, animated: false)
        }
    }
    
    func popViewControllerWithAnimation() {
        let transition: CATransition = CATransition()
        transition.duration = 0.5
        transition.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
        transition.type = kCATransitionReveal
        transition.subtype = kCATransitionFromBottom
        self.navigationController?.view.layer.add(transition, forKey: kCATransition)
        self.navigationController?.popViewController(animated: false)
    }
    
    func collapseTheNavigationController() {
        self.navigationController?.dismiss(animated: true, completion: nil)
    }
    
}
