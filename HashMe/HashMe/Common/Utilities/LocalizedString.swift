//
//  LocalizedString.swift
//  HashMe
//
//  Created by Dheeru on 10/5/17.
//  Copyright © 2017 Dheeru. All rights reserved.
//

import Foundation

/**
 CustomLocalizedString which returns the localized string if found, or the English translation if there is no translation
 found for the current language.
 
 If using this in a global constant defined in LocalizedString, use a computed var so that it will be reevaluated on each call.
 
 - note: If you need to provide a comment which is not the English translation, use CustomLocalizedStringWithDefaultValue
 */
public func CustomLocalizedString(_ key: String, english: String) -> String {
    return CustomLocalizedStringWithDefaultValue(key, tableName: nil, bundle: nil, value: english, comment: english)
}

/**
CustomLocalizedString which returns the localized string if found, or the English translation if there is no translation
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
            print(errorMessage)
            // Use English if there was no translation for the key at all
            return value
        #endif
    }
    return result
}

public class LocalizedString {
    
    //Alert Buttons
    static var okButtonTitle = NSLocalizedString("OkButtonTitle", comment: "Title for OK button")
    static var noThanksButtonTitle = NSLocalizedString("NoThanksButtonTitle", comment: "Title for No Thanks button")

    //Predictions
    static var alertTitle = NSLocalizedString("ImagePickerAlert", comment: "Title shown when Image picker can not open")
    static var alertMessage = NSLocalizedString("ImagePickerIssue", comment: "Message shown when Image picker can not open")
    
    //UIButtons
    static var cameraButtonTitle = NSLocalizedString("CameraButtonTitle", comment: "Title for camera button")
    static var photoLibraryButtonTitle = NSLocalizedString("PhotoLibraryButtonTitle", comment: "Title for photo library button")
    static var getStartedButtonTitle = NSLocalizedString("GetStartedButtonTitle", comment: "Title for get started button")
    static var copyButtonTitle = NSLocalizedString("copyButtonTitle", comment: "Title for copy button")
    static var selecAllButtonTitle = NSLocalizedString("selectAllButtonTitle", comment: "Title for selecet all button")
    static var deselecAllButtonTitle = NSLocalizedString("deselectAllButtonTitle", comment: "Title for deselecet all button")
    
    static var theHashTagTitle = NSLocalizedString("hashTagTitle", comment: "Title for the screen")
    static var hashTagDescription = NSLocalizedString("hashTagDescription", comment: "Description for hash tag")
    
    //Onboarding
    static var onboardingStep1Text = NSLocalizedString("step1OnboardingText", comment: "Text for the tutorial step 1")
    static var onboardingStep2Text = NSLocalizedString("step2OnboardingText", comment: "Text for the tutorial step 2")
    static var onboardingStep3Text = NSLocalizedString("step3OnboardingText", comment: "Text for the tutorial step 3")
    
    //Prediction Results
    static var copiedText = NSLocalizedString("CopiedText", comment: "Title for Copied Label")
    static var askForCopyingTags = NSLocalizedString("AskForCopyingTags", comment: "Text for asking user to copy tags")
    static var instagramIssueTitle = NSLocalizedString("InstagramIssue", comment: "Title for alert when instagram can not be opened.")
    static var pleaseTryAgainLater = NSLocalizedString("PleaseTryAgainLater", comment: "Title for alert when instagram can not be opened.")
    
    //SocialView
    static var shareWithLabelTitle = NSLocalizedString("ShareWithLabelTitle", comment: "Title for Label on Social View")
    static var instagramLabelTitle = NSLocalizedString("InstagramLabelTitle", comment: "Title for Label on Social View")
    static var moreLabelTitle = NSLocalizedString("MoreLabelTitle", comment: "Title for Label on Social View")
}
