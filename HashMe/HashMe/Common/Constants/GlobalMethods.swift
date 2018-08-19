//
//  GlobalMethods.swift
//  HashMe
//
//  Created by Dheeru on 10/23/17.
//  Copyright © 2017 Dheeru. All rights reserved.
//

import Foundation
import UIKit

/// - Parameters:
///   - items: Zero or more items to print.
///   - separator: A string to print between each item. The default is a single
///     space (`" "`).
///   - terminator: The string to print after all items have been printed. The
///     default is a newline (`"\n"`).
public func print(_ items: Any..., separator: String = " ", terminator: String = "\n") {
    #if DEBUG
        Swift.print(items, separator:separator, terminator: terminator)
    #endif
}

/// Executes the closure on the main queue after the given delay.
///
/// - Parameters:
///   - delay: Delay in seconds
///   - closure: Code to be executed after the delay.
public func dispatchOnMainQueueWith(delay: Double, closure: @escaping ()->()) {
    DispatchQueue.main.asyncAfter(deadline: TimeInterval.convertToDispatchTimeT(delay), execute: closure)
}

/// Executes the closure on the main queue.
///
/// - Parameter closure: Code to be executed.
public func dispatchOnMainQueue(closure: @escaping ()->()) {
    DispatchQueue.main.async(execute: closure)
}

// Helper function inserted by Swift 4.2 migrator.
public func convertToUIApplicationOpenExternalURLOptionsKeyDictionary(_ input: [String: Any]) -> [UIApplication.OpenExternalURLOptionsKey: Any] {
    return Dictionary(uniqueKeysWithValues: input.map { key, value in (UIApplication.OpenExternalURLOptionsKey(rawValue: key), value)})
}

// Helper function inserted by Swift 4.2 migrator.
 func convertFromUIImagePickerControllerInfoKey(_ input: UIImagePickerController.InfoKey) -> String {
    return input.rawValue
}
