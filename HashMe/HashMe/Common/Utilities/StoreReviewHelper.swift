//
//  StoreReviewHelper.swift
//  HashMe
//
//  Created by Dheeru on 12/22/17.
//  Copyright © 2017 Dheeru. All rights reserved.
//

import Foundation
import StoreKit

struct StoreReviewHelper {
    
    static func incrementAppOpenedCount() {
        guard var appOpenCount = CustomUserDefault().getAppOpenedCount() else {
            CustomUserDefault().setAppOpenedCount(value: 1)
            return
        }
        appOpenCount += 1
        CustomUserDefault().setAppOpenedCount(value: appOpenCount)        
    }
    
    static func checkAndAskForReview() {
        guard let appOpenCount = CustomUserDefault().getAppOpenedCount() else {
            CustomUserDefault().setAppOpenedCount(value: 1)
            return
        }
        
        switch appOpenCount {
        case 10,50:
            StoreReviewHelper().requestReview()
        case _ where appOpenCount%100 == 0 :
            StoreReviewHelper().requestReview()
        default:
            print("App run count is : \(appOpenCount)")
            break;
        }
    }
    
    fileprivate func requestReview() {
        if #available(iOS 10.3, *) {
            SKStoreReviewController.requestReview()
        } else {
            // Fallback on earlier versions
        }
    }
}
