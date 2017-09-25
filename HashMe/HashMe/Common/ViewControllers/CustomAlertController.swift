//
//  CustomAlertController.swift
//  HashMe
//
//  Created by Dheeru on 9/23/17.
//  Copyright © 2017 Dheeru. All rights reserved.
//

import Foundation
import UIKit

/// Alert button title, what type of action should the button take and completion handler.
public typealias CustomAlertAction = (title: String?, style: UIAlertActionStyle, handler: (() -> Void)?)

private class CustomHashTagAlertController: UIAlertController {
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        get {
            return .allButUpsideDown
        }
    }
}

/// This helps handling all the alerts presented in the app. This will tell us how many alerts are shown present and a gives us a place to dismiss all.
open class CustomAlertController: NSObject, UIAlertViewDelegate {
    open static let sharedInstance = CustomAlertController()
    fileprivate var presentedAlert: UIAlertController?
    
    /// Displays an alertDescription
    ///
    /// - Parameters:
    ///   - title: Title that will be shown on the alert.
    ///   - message: Message that will shown on the alert.
    ///   - preferredStyle: Type of style for the alert.
    ///   - actions: Array of actions for the alert.
    ///   - currentDisplayedVc: View controller to show the alert.
    open func displayAlertWithTitle(_ title: String?, message: String?, preferredStyle: UIAlertControllerStyle, andActions actions: [CustomAlertAction]?, onViewController currentDisplayedVc: UIViewController?) {
        
        dismissPresentAlert()
        
        let alert = CustomHashTagAlertController(title: title, message: message, preferredStyle: preferredStyle)
        if let dereferancedActions = actions {
            for action in dereferancedActions {
                alert.addAction(UIAlertAction(title: action.title, style: action.style, handler: { (alertAction) -> Void in
                    action.handler?()
                    self.alertViewDismised()
                }))
            }
        }
        currentDisplayedVc?.present(alert, animated: true, completion: nil)
        presentedAlert = alert
    }
    
    open func dismissPresentAlert() {
        presentedAlert?.dismiss(animated: false, completion: nil)
        presentedAlert = nil
    }
    
    @objc
    open func alertViewDismised() {
        presentedAlert = nil
    }
}
