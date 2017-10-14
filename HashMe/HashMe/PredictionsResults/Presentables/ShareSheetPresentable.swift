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
    func launchShareSheet(withActivities activities: [String], andSubject subject: String)
}

public extension ShareSheetPresentable {
    func launchShareSheet(withActivities activities: [String], andSubject subject: String) {
        //            let calendarActivity = HHCalendarActivity()
        let activityVC = UIActivityViewController(activityItems: activities, applicationActivities: [/*calendarActivity*/])
        activityVC.setValue("Stay at the )", forKey: "subject")
        let excludeActivities: [UIActivityType] = [.airDrop,
                                                   .assignToContact,
                                                   .markupAsPDF,
                                                   .openInIBooks,
                                                   .print,
                                                   .saveToCameraRoll]
        activityVC.excludedActivityTypes = excludeActivities
        self.navigationController?.present(activityVC, animated: true, completion: nil)
    }
}
