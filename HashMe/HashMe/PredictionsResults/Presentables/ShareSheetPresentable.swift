//
//  ShareSheetPresentable.swift
//  HashMe
//
//  Created by Dheeru on 10/14/17.
//  Copyright © 2017 Dheeru. All rights reserved.
//

import Foundation
import UIKit

public typealias ShareSheetActivities = (tags: [String], predictedImage: UIImage)

public protocol ShareSheetPresentable: NavigationFlowControllable {
    func launchShareSheet(withActivities activities: ShareSheetActivities, andSubject subject: String)
}

public extension ShareSheetPresentable {
    func launchShareSheet(withActivities activities: ShareSheetActivities, andSubject subject: String) {
        let facebookActivity = FacebookActivity()
        let activityVC = UIActivityViewController(activityItems: [activities.tags, activities.predictedImage], applicationActivities: [facebookActivity])
        activityVC.setValue("Stay at the )", forKey: "subject")
        let excludeActivities: [UIActivityType] = [.airDrop,
                                                   .assignToContact,
                                                   .copyToPasteboard,
                                                   .markupAsPDF,
                                                   .openInIBooks,
                                                   .print,
                                                   .saveToCameraRoll]
        activityVC.excludedActivityTypes = excludeActivities
        self.navigationController?.present(activityVC, animated: true, completion: nil)
    }
}
