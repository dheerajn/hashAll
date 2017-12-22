//
//  CustomUserDefaults.swift
//  HashMe
//
//  Created by Dheeru on 10/2/17.
//  Copyright © 2017 Dheeru. All rights reserved.
//

import Foundation
import UIKit

class CustomUserDefault {
    func setOnboardingWithValue() {
        UserDefaults.standard.setValue(0, forKey: Constants.onboardingIdentifier) //setting this 0 will change the logic not to show the onboarding view. 
    }
    
    func getOnboardingValue() -> Bool? {
        return UserDefaults.standard.value(forKey: Constants.onboardingIdentifier) as? Bool
    }
    
    func setAppOpenedCount(value: Int) {
        UserDefaults.standard.set(value, forKey: Constants.AppOpenedCount)
    }
    
    func getAppOpenedCount() -> Int? {
        return UserDefaults.standard.value(forKey: Constants.AppOpenedCount) as? Int
    }
}
