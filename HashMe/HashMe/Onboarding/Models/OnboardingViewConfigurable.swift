//
//  OnboardingViewConfigurable.swift
//  HashMe
//
//  Created by Dheeru on 9/23/17.
//  Copyright © 2017 Dheeru. All rights reserved.
//

import Foundation

public protocol OnboardingViewConfigurable: class {
    var screeTitle: String? { get }
    var buttonTitle: String? { get }
}
