//
//  OnboardingViewConfigurable.swift
//  HashMe
//
//  Created by Dheeru on 9/23/17.
//  Copyright © 2017 Dheeru. All rights reserved.
//

import Foundation

public protocol OnboardingViewConfigurable: HashMeRuleEngineProtocol {
    
    var flowDelegate: HashTagFlowDelegate? { get set }
    /// Title for get started button
    var getStartedButtonTitle: String? { get }
    
    func showPredicitonsView()
}
