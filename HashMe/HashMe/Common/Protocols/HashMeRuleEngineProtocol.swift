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

public protocol HashMeRuleEngineProtocol: JsContextProtocolLocal {
    
    /// This method returns the max number of tags to be shown for iPad
    ///
    /// - Returns: Int value or nil if not found anything
    func maximumTagsForIpad() -> Int?
    
    /// This method returns the max number of tags to be shown for iPhone
    ///
    /// - Returns: Int value or nil if not found anything
    func maximumTagsForIphone() -> Int?
    
    /// This method helps getting the contact us email id
    ///
    /// - Returns: String value or nil if not found anything
    func contactUsEmailId() -> String?
    
    /// This method helps gettings the contact us email subject
    ///
    /// - Returns: String value or nil if not found anything
    func contactUsEmailSubject() -> String?
    
    /// This method helps in formatting the string by appending "#" to it
    ///
    /// - Parameter string: String that needs to be formatted
    /// - Returns: String Value or nil if not found anything
    func appendHashToString(tobeFormattedString string: String) -> String?
}

extension HashMeRuleEngineProtocol {
    
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
    
    public func appendHashToString(tobeFormattedString string: String) -> String? {
        let appendHashToStringFunction = context?.objectForKeyedSubscript("appendHashToString")
        let jsValueString = appendHashToStringFunction?.call(withArguments: [string])
        
        if let validJsValueString = jsValueString?.isNull {
            return validJsValueString ? nil : jsValueString?.toString()
        }
        return nil
    }
}

