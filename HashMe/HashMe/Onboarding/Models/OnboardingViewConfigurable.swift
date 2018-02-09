//
//  OnboardingViewConfigurable.swift
//  HashMe
//
//  Created by Dheeru on 9/23/17.
//  Copyright © 2017 Dheeru. All rights reserved.
//

import Foundation

public protocol OnboardingViewConfigurable: ViewModelConfigurable {
    
    /// Title for get started button
    var getStartedButtonTitle: String? { get }
}
