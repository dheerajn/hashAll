//
//  HashTagFlowController.swift
//  HashMe
//
//  Created by Dheeru on 9/23/17.
//  Copyright © 2017 Dheeru. All rights reserved.
//

import Foundation
import UIKit

public protocol HashTagFlowDelegate: NavigationControllable, PredictionResultsPresentable, PredictionsViewPresentable, OnboardingPresentable {}

public class HashTagFlowController: HashTagFlowDelegate {
    
    public var navigationController: UINavigationController?
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
        
        let customUserDefaults = CustomUserDefault()
        if customUserDefaults.getOnboardingValue() == nil {
            self.showOnboardingView()
        } else {
            self.showPredictionsView()
        }
    }
}
