//
//  HashMeRuleEngineProtocol.swift
//  HashMe
//
//  Created by Dheeru on 2/8/18.
//  Copyright © 2018 Dheeru. All rights reserved.
//

import Foundation
import UIKit
import JavaScriptCore

public protocol HashMeRuleEngineProtocol: class {
    
    /// This method returns the max number of tags to be shown for iPad
    ///
    /// - Returns: Int value
    func maximumTagsForIpad() -> Int?
    
    /// This method returns the max number of tags to be shown for iPhone
    ///
    /// - Returns: Int value
    func maximumTagsForIphone() -> Int?
    
    /// This method helps getting the contact us email id
    ///
    /// - Returns: String value
    func contactUsEmailId() -> String?
    
    /// This method helps gettings the contact us email subject
    ///
    /// - Returns: String value
    func contactUsEmailSubject() -> String?
    
    func validateDates(departureDate: Date, returnDate: Date) -> String?
}

extension HashMeRuleEngineProtocol  {
    
    var context: JSContext? {
        get {
            let context = JSContext()
            guard let
                commonJSPath = Bundle.main.path(forResource: "HashMe_Rule_Engine", ofType: "js") else {
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
        
        if let validJsValueString = jsValueString?.isNull {
            return validJsValueString ? nil : jsValueString?.toString()
        }
        return nil
    }
    
    public func maximumTagsForIpad() -> Int? {
        let iPadTagsFunction = context?.objectForKeyedSubscript("maximumTagsForIpad")
        let jsValueInt = iPadTagsFunction?.call(withArguments: [])
        if let validJsValueString = jsValueInt?.isNull {
            return validJsValueString ? nil : jsValueInt?.toNumber().intValue
        }
        return nil
    }
    
    public func maximumTagsForIphone() -> Int? {
        let iPhoneTagsFunction = context?.objectForKeyedSubscript("maximumTagsForIphone")
        let jsValueInt = iPhoneTagsFunction?.call(withArguments: [])
        if let validJsValueString = jsValueInt?.isNull {
            return validJsValueString ? nil : jsValueInt?.toNumber().intValue
        }
        return nil
    }
    
    public func contactUsEmailId() -> String? {
        let contactUsEmailIdFunction = context?.objectForKeyedSubscript("contactUsEmailId")
        let jsValueString = contactUsEmailIdFunction?.call(withArguments: [])
        
        if let validJsValueString = jsValueString?.isNull {
            return validJsValueString ? nil : jsValueString?.toString()
        }
        return nil
    }
    
    public func contactUsEmailSubject() -> String? {
        let contactUsEmailSubjectFunction = context?.objectForKeyedSubscript("contactUsEmailSubject")
        let jsValueString = contactUsEmailSubjectFunction?.call(withArguments: [])
        
        if let validJsValueString = jsValueString?.isNull {
            return validJsValueString ? nil : jsValueString?.toString()
        }
        return nil
    }
}

