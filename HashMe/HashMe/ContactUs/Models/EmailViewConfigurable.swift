//
//  EmailViewConfigurable.swift
//  HashMe
//
//  Created by Dheeru on 12/25/17.
//  Copyright © 2017 Dheeru. All rights reserved.
//

import Foundation

public protocol EmailViewConfigurable: HashMeRuleEngineProtocol {
    
    /// Sets the email address to be sent to
    var recipients: [String]? { get }
    
    /// Sets the subject for the email
    var subject: String? { get }
}
