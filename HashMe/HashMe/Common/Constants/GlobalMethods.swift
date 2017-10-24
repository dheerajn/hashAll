//
//  GlobalMethods.swift
//  HashMe
//
//  Created by Dheeru on 10/23/17.
//  Copyright © 2017 Dheeru. All rights reserved.
//

import Foundation

/// - Parameters:
///   - items: Zero or more items to print.
///   - separator: A string to print between each item. The default is a single
///     space (`" "`).
///   - terminator: The string to print after all items have been printed. The
///     default is a newline (`"\n"`).
public func print(_ items: Any..., separator: String = " ", terminator: String = "\n") {
    #if DEBUG
        Swift.print(items[0], separator:separator, terminator: terminator)
    #endif
}
