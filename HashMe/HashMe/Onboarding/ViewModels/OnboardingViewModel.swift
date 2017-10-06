//
//  OnboardingViewModel.swift
//  HashMe
//
//  Created by Dheeru on 9/23/17.
//  Copyright © 2017 Dheeru. All rights reserved.
//

import Foundation

class OnboardingViewModel: OnboardingViewConfigurable {
    var buttonTitle: String? {
        return NSLocalizedString("GetStartedButtonTitle", comment: "Title for get started button")
    }
    var screeTitle: String? {
        return "HASH ME ONBOARDING"
    }
}
