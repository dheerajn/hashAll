//
//  ShareSheetPresentable.swift
//  HashMe
//
//  Created by Dheeru on 10/14/17.
//  Copyright © 2017 Dheeru. All rights reserved.
//

import Foundation
import UIKit

public protocol ShareSheetPresentable: NavigationFlowControllable {
    func launchShareSheet(withActivities activities: NSMutableArray, andSubject subject: String, withFrame: CGRect)
}

public extension ShareSheetPresentable where Self: HashTagFlowController {
    func launchShareSheet(withActivities activities: NSMutableArray, andSubject subject: String, withFrame: CGRect) {
        
        guard let validActivities = activities as? [Any] else { return }
        let activityVC = UIActivityViewController(activityItems: validActivities, applicationActivities: [])
        activityVC.setValue("#\(LocalizedString.appNameCamelCased)App", forKey: "subject")
        let excludeActivities: [UIActivityType] = [.airDrop,
                                                   .assignToContact,
                                                   .copyToPasteboard,
                                                   .markupAsPDF,
                                                   .openInIBooks,
                                                   .print,
                                                   .saveToCameraRoll]
        activityVC.excludedActivityTypes = excludeActivities
        if isDeviceIpad {
            activityVC.popoverPresentationController?.sourceView = self.navigationController?.visibleViewController?.view
            activityVC.popoverPresentationController?.sourceRect = withFrame
        }
        dispatchOnMainQueue {
            self.navigationController?.present(activityVC, animated: true, completion: nil)
        }
    }
}
