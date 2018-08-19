//
//  OnboardingViewConfigurable.swift
//  HashMe
//
//  Created by Dheeru on 9/23/17.
//  Copyright © 2017 Dheeru. All rights reserved.
//

import Foundation

public protocol OnboardingViewConfigurable: HashMeRuleEngineProtocol {
    
    /// This helps in transition to different screes
    var flowDelegate: HashTagFlowDelegate? { get set }
    
    /// Title for get started button
    var getStartedButtonTitle: String? { get }
    
    /// This functions helps to set user defaults for onboarding screen
    func setOnboardingValue()
    
    /// This helps showing the predictions view
    func showPredicitionsView()
}
