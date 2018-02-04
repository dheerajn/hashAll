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
    
    static let appNameCamelCased = NSLocalizedString("appNameCamelCased", comment: "App Name")
    //Alert Buttons
    static let okButtonTitle = NSLocalizedString("OkButtonTitle", comment: "Title for OK button")
    static let noThanksButtonTitle = NSLocalizedString("NoThanksButtonTitle", comment: "Title for No Thanks button")
    static let settingsButtonTitle = NSLocalizedString("SettingsButtonTitle", comment: "Title for Settings button")
    static let cancelButtonTitle = NSLocalizedString("cancelButtonTitle", comment: "Title for Cancel button")
    static let doneButtonTitle = NSLocalizedString("doneButtonTitle", comment: "Title for Done button")

    //Predictions
    static let alertTitle = NSLocalizedString("ImagePickerAlert", comment: "Title shown when Image picker can not open")
    static let alertMessage = NSLocalizedString("ImagePickerIssue", comment: "Message shown when Image picker can not open")
    static let photoLibraryAccessTitle = NSLocalizedString("photoLibraryAccessTitle", comment: "Title for asking user for photo library permission")
    static let photoLibraryAccessMessage = NSLocalizedString("photoLibraryAccessMessage", comment: "Message for asking user for photo library permission")
    static let appStoreOpenIssueTitle = NSLocalizedString("AppStoreOpenIssueTitle", comment: "Title for app store opening issue")
    static let appStoreOpenIssueMessage = NSLocalizedString("AppStoreOpenIssueMessage", comment: "Message for app store opening issue")
    
    //UIButtons
    static let cameraButtonTitle = NSLocalizedString("CameraButtonTitle", comment: "Title for camera button")
    static let photoLibraryButtonTitle = NSLocalizedString("PhotoLibraryButtonTitle", comment: "Title for photo library button")
    static let getStartedButtonTitle = NSLocalizedString("GetStartedButtonTitle", comment: "Title for get started button")
    static let copyButtonTitle = NSLocalizedString("copyButtonTitle", comment: "Title for copy button")
    static let selecAllButtonTitle = NSLocalizedString("selectAllButtonTitle", comment: "Title for selecet all button")
    static let deselecAllButtonTitle = NSLocalizedString("deselectAllButtonTitle", comment: "Title for deselecet all button")
    
    static let theHashTagTitle = NSLocalizedString("hashTagTitle", comment: "Title for the screen")
    static let hashTagDescription = NSLocalizedString("hashTagDescription", comment: "Description for hash tag")
    
    //Onboarding
    static let onboardingStep1Text = NSLocalizedString("step1OnboardingText", comment: "Text for the tutorial step 1")
    static let onboardingStep2Text = NSLocalizedString("step2OnboardingText", comment: "Text for the tutorial step 2")
    static let onboardingStep3Text = NSLocalizedString("step3OnboardingText", comment: "Text for the tutorial step 3")
    
    //Prediction Results
    static let copiedText = NSLocalizedString("CopiedText", comment: "Title for Copied Label")
    static let askForCopyingTags = NSLocalizedString("AskForCopyingTags", comment: "Text for asking user to copy tags")
    static let instagramIssueTitle = NSLocalizedString("InstagramIssue", comment: "Title for alert when instagram can not be opened.")
    static let installNowMessage = NSLocalizedString("installNowMessage", comment: "Message for install now")
    static let  addNewTagTitle = NSLocalizedString("addNewTagTitle", comment: "Title for add new tag")
    static let  addNewTagPlaceHolder = NSLocalizedString("addNewTagPlaceHolder", comment: "Placeholder for add new tag")
    
    
    //SocialView
    static let shareWithLabelTitle = NSLocalizedString("ShareWithLabelTitle", comment: "Title for Label on Social View")
    static let instagramLabelTitle = NSLocalizedString("InstagramLabelTitle", comment: "Title for Label on Social View")
    static let moreLabelTitle = NSLocalizedString("MoreLabelTitle", comment: "Title for Label on Social View")
}
