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
    func appendHashToString(tobeFormattedString string: String) -> String?
    func validateDates(departureDate: Date, returnDate: Date) -> String?
}

extension HashMeRuleEngineProtocol {
    
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
    
    public func appendHashToString(tobeFormattedString string: String) -> String? {
        let appendHashToStringFunction = context?.objectForKeyedSubscript("appendHashToString")
        let jsValueString = appendHashToStringFunction?.call(withArguments: [string])
        
        if let validJsValueString = jsValueString?.isNull {
            return validJsValueString ? nil : jsValueString?.toString()
        }
        return nil
    }
}

