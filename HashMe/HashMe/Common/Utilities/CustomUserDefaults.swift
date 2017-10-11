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
        UserDefaults.standard.setValue(0, forKey: Constants.onboaringIdentifier) //setting this 0 will change the logic not to show the onboarding view. 
    }
    
    func getOnboardingValue() -> Bool? {
        return UserDefaults.standard.value(forKey: Constants.onboaringIdentifier) as? Bool
    }
}
