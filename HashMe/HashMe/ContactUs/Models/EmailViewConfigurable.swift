//
//  EmailViewConfigurable.swift
//  HashMe
//
//  Created by Dheeru on 12/25/17.
//  Copyright © 2017 Dheeru. All rights reserved.
//

import Foundation

public protocol EmailViewConfigurable {
    
    var recipients: [String]? { get }
    var subject: String? { get }
}
