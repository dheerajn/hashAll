//
//  PredictionsRuleEngineProtocol.swift
//  HashMe
//
//  Created by Dheeru on 2/8/18.
//  Copyright © 2018 Dheeru. All rights reserved.
//

import Foundation
import UIKit
import JavaScriptCore

public protocol PredictionsRuleEngineProtocol: class {
    
    /// This method returns the max number of tags to be shown for iPad
    ///
    /// - Returns: Int value
    func maximumTagsForIpad() -> Int?
    
    /// This method returns the max number of tags to be shown for iPhone
    ///
    /// - Returns: Int value
    func maximumTagsForIphone() -> Int?
    func validateDates(departureDate: Date, returnDate: Date) -> String?
}

extension PredictionsRuleEngineProtocol  {
    var context: JSContext? {
        get {
            let context = JSContext()
            guard let
                commonJSPath = Bundle.main.path(forResource: "Prediction_Rule_Engine", ofType: "js") else {
                    print("Unable to read resource files.")
                    return nil
            }
            do {
                let common = try String(contentsOfFile: commonJSPath, encoding: String.Encoding.utf8)
                _ = context?.evaluateScript(common)
            } catch (let error) {
                print("Error while processing script file: \(error)")
            }
            return context
        }
    }
    
    public func validateDates(departureDate: Date, returnDate: Date) -> String? {
        let dateFunction = context?.objectForKeyedSubscript("validateDates")
        let jsValueString = dateFunction?.call(withArguments: [ departureDate, returnDate])
        return (jsValueString?.isNull)! ? nil : jsValueString?.toString()
    }
    
    public func maximumTagsForIpad() -> Int? {
        let dateFunction = context?.objectForKeyedSubscript("maximumTagsForIpad")
        let jsValueInt = dateFunction?.call(withArguments: [])
        return (jsValueInt?.isNull)! ? nil : jsValueInt?.toNumber().intValue
    }
    
    public func maximumTagsForIphone() -> Int? {
        let dateFunction = context?.objectForKeyedSubscript("maximumTagsForIphone")
        let jsValueInt = dateFunction?.call(withArguments: [])
        return (jsValueInt?.isNull)! ? nil : jsValueInt?.toNumber().intValue
    }
}

