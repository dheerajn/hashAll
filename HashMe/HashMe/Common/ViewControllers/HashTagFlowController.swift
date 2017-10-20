//
//  HashTagFlowController.swift
//  HashMe
//
//  Created by Dheeru on 9/23/17.
//  Copyright © 2017 Dheeru. All rights reserved.
//

import Foundation
import UIKit

public protocol HashTagFlowDelegate: NavigationControllerAnimationPresentable, PredictionResultsPresentable, PredictionsInitialViewPresentable, OnboardingPresentable, ShareSheetPresentable {}

public class HashTagFlowController: HashTagFlowDelegate {
    
    public var navigationController: UINavigationController?
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
        
        let customUserDefaults = CustomUserDefault()
        //The very first time, getOnboardingValue() value will be nil since no body is setting, but from second time, the Bool value will be "0" which is false, so we will not show onboarding view anymore.
        if customUserDefaults.getOnboardingValue() ?? true {
            self.showOnboardingView()
        } else {
            self.showPredictionsView()
        }
    }
}
