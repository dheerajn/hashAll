//
//  TimeIntervalExtension.swift
//  HashMe
//
//  Created by Dheeru on 9/25/17.
//  Copyright © 2017 Dheeru. All rights reserved.
//

import Foundation

public extension TimeInterval {
    public static func convertToDispatchTimeT(_ time: TimeInterval?) -> DispatchTime {
        let absolutePause: TimeInterval = time ?? TimeInterval(0.0)
        return .now() + absolutePause
    }
}

