//
//  LocalizedString.swift
//  HashMe
//
//  Created by Dheeru on 10/5/17.
//  Copyright © 2017 Dheeru. All rights reserved.
//

import Foundation

/**
 Custom CustomLocalizedString which returns the localized string if found, or the English translation if there is no translation
 found for the current language.
 
 If using this in a global constant defined in LocalizedString, use a computed var so that it will be reevaluated on each call.
 
 - note: If you need to provide a comment which is not the English translation, use CustomLocalizedStringWithDefaultValue
 */
public func CustomLocalizedString(_ key: String, english: String) -> String {
    return CustomLocalizedStringWithDefaultValue(key, tableName: nil, bundle: nil, value: english, comment: english)
}

/**
 Custom CustomLocalizedString which returns the localized string if found, or the English translation if there is no translation
 found for the current language.
 
 If using this in a global constant defined in LocalizedString, use a computed var so that it will be reevaluated on each call.
 
 - note: The current function signature (both name + arguments) is required by Xcode's genstrings tool
 */
public func CustomLocalizedStringWithDefaultValue(_ key: String, tableName: String?, bundle: Bundle?, value: String, comment: String) -> String {
    // TODO: load currently selected language, which may be different from the locale
    let languageBundle = bundle ?? Bundle.main
    let result = languageBundle.localizedString(forKey: key, value: value, table: tableName)
    
    if result == key {
        let currentLanguage = Locale.current.languageCode
        let errorMessage = "String key '\(key)' missing translation for language \(currentLanguage ?? "'nil'")"
        #if DEBUG
            fatalError(errorMessage)
        #else
            MFLoggingService.sharedInstance.logError(errorMessage)
            // Use English if there was no translation for the key at all
            return value
        #endif
    }
    return result
}

public class LocalizedString {
    public static var testString: String {
        return CustomLocalizedString("randonTitle", english: "This is a test")
    }
}
