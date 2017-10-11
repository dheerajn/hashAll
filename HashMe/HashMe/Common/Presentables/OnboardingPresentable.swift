//
//  OnboardingPresentable.swift
//  HashMe
//
//  Created by Dheeru on 10/2/17.
//  Copyright © 2017 Dheeru. All rights reserved.
//

import Foundation
import UIKit

public protocol OnboardingPresentable: class {
    func showOnboardingView()
}

public extension OnboardingPresentable where Self: HashTagFlowController {
    func showOnboardingView() {
        let storyboard = UIStoryboard(name: Constants.mainStoryboardIdentifier, bundle: nil)
        let onboardingViewController = storyboard.instantiateViewController(withIdentifier: Constants.onboardingVcIdentifier) as? OnboardingViewController
        onboardingViewController?.flowDelegate = self
        onboardingViewController?.viewModel = OnboardingViewModel()
        self.pushViewControllerWithAnimation(onboardingViewController!)
    }
}
