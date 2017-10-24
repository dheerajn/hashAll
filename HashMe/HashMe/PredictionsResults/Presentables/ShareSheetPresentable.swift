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
    func launchShareSheet(withActivities activities: NSMutableArray, andSubject subject: String)
}

public extension ShareSheetPresentable {
    func launchShareSheet(withActivities activities: NSMutableArray, andSubject subject: String) {
        
        guard let validActivities = activities as? [Any] else { return }
        let activityVC = UIActivityViewController(activityItems: validActivities, applicationActivities: [])
        activityVC.setValue("Stay at the )", forKey: "subject")
        let excludeActivities: [UIActivityType] = [.airDrop,
                                                   .assignToContact,
                                                   .copyToPasteboard,
                                                   .markupAsPDF,
                                                   .openInIBooks,
                                                   .print,
                                                   .saveToCameraRoll]
        activityVC.excludedActivityTypes = excludeActivities
        dispatchOnMainQueue {
            self.navigationController?.present(activityVC, animated: true, completion: nil)
        }
    }
}
