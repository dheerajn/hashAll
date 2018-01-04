//
//  OnboardingViewModel.swift
//  HashMe
//
//  Created by Dheeru on 9/23/17.
//  Copyright © 2017 Dheeru. All rights reserved.
//

import Foundation

enum OnboardingAnimationDuration: Double {
    case getStartedButton = 1.0
    case tutorialLabelAnimation = 1.25
}

class OnboardingViewModel: OnboardingViewConfigurable {
    var getStartedButtonTitle: String? {
        return LocalizedString.getStartedButtonTitle
    }
    
    var screeTitle: String? {
        return "HASH ME ONBOARDING"
    }
}
