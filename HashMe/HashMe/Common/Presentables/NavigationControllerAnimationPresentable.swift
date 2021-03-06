//
//  NavigationControllerAnimationPresentable.swift
//  HashMe
//
//  Created by Dheeru on 10/11/17.
//  Copyright © 2017 Dheeru. All rights reserved.
//

import Foundation
import UIKit

public enum NavigationAnimationType: String {
    case fade
    case moveIn
    case push
    case reveal
}

public protocol NavigationControllerAnimationPresentable: NavigationFlowControllable {
    
    /// This is a navigation animation helps especially when you work on Modals. This is a navigation push, but animation looks like navigation present.
    ///
    /// - Parameter viewController: ViewController that needs to be pushed.
    func pushViewControllerWithAnimation(_ viewController: UIViewController, withAnimationType animation: NavigationAnimationType)
    
    /// This pops the top view controller
    func popViewControllerWithAnimation(withAnimationType animation: NavigationAnimationType)
    
    /// This will collapse the complete navigation controller.
    func collapseTheNavigationController()
}

public extension NavigationControllerAnimationPresentable {
    func pushViewControllerWithAnimation(_ viewController: UIViewController, withAnimationType animation: NavigationAnimationType) {
        let transition: CATransition = self.transition(withAnimation: animation)
        transition.subtype = CATransitionSubtype.fromTop
        
        self.navigationController?.view.layer.add(transition, forKey: kCATransition)
        self.navigationController?.pushViewController(viewController, animated: false)
    }
    
    func popViewControllerWithAnimation(withAnimationType animation: NavigationAnimationType) {
        let transition: CATransition = self.transition(withAnimation: animation)
        transition.subtype = CATransitionSubtype.fromBottom
        
        self.navigationController?.view.layer.add(transition, forKey: kCATransition)
        self.navigationController?.popViewController(animated: false)
    }
    
    func collapseTheNavigationController() {
        self.navigationController?.dismiss(animated: true, completion: nil)
    }
    
    fileprivate func transition(withAnimation animation: NavigationAnimationType) -> CATransition {
        let transition: CATransition = CATransition()
        transition.duration = 0.5
        transition.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
        switch animation {
        case .moveIn:
            transition.type = CATransitionType.moveIn
        case .fade:
            transition.type = CATransitionType.fade
        case .push:
            transition.type = CATransitionType.push
        case .reveal:
            transition.type = CATransitionType.reveal
        }
        return transition
    }
}
