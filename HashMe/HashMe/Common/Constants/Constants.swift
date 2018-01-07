//
//  Constants.swift
//  HashMe
//
//  Created by Dheeru on 9/23/17.
//  Copyright © 2017 Dheeru. All rights reserved.
//

import Foundation

struct Constants {
    static let appId = "1329812139"
    
    static let AppStoreAppID = "itms-apps://itunes.apple.com/gb/app/id\(Constants.appId)?action=write-review&mt=8"
    static let InstagramAppId = "https://itunes.apple.com/us/app/instagram/id389801252?mt=8"
    
    struct Tags {
        static let loadingViewTag               = 54321
        static let activateButtonTag            = 1210
    }
    
    struct ContactUs {
        static let recipient = "hashallcontactus@gmail.com"
        static let feedbackForm = "https://goo.gl/AZt6c4"
        static let subject = "HashAll-ContactUs"
    }
    
    static let mainStoryboardIdentifier         = "Main"
    
    static let AppOpenedCount                   = "AppOpenedKey"
    
    static let onboardingIdentifier             = "OnBoarding"
    static let onboardingViewController1        = "onboardingViewController1"
    static let onboardingViewController2        = "onboardingViewController2"
    static let onboardingViewController3        = "onboardingViewController3"
    
    static let hashtagsVcIdentifier             = "PredictionsViewController"
    static let onboardingVcIdentifier           = "OnboardingViewController"
    static let predictionsResultsVcIdentifier   = "PredictionResultsViewController"
    
    static let socialMediaViewIdentifier        = "SocialMediaView"
}
