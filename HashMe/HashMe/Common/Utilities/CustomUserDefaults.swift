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
        UserDefaults.standard.setValue("Done", forKey: Constants.onboaringIdentifier)
    }
    
    func getOnboardingValue() -> String? {
        return UserDefaults.standard.value(forKey: Constants.onboaringIdentifier) as? String
    }
}
