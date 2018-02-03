//
//  SocialMediaCustomViewTests.swift
//  HashMeTests
//
//  Created by Dheeru on 2/3/18.
//  Copyright © 2018 Dheeru. All rights reserved.
//

import XCTest
@testable import HashAll

class SocialMediaCustomViewTests: XCTestCase {
    
    var storyBoard: UIStoryboard?
    var predictionResultsVc: PredictionResultsViewController?
    
    func testInitializingWithFrame() {
        let frame = CGRect(x: 0, y: 0, width: 10, height: 10)
        XCTAssertFalse(SocialMediaCustomView(frame: frame).subviews.isEmpty,
                       "CustomView should add subviews from nib when instantiated in code")
    }
    
    func testInitializingWithCoder() {
        self.storyBoard = UIStoryboard(name: Constants.mainStoryboardIdentifier, bundle: nil)
        XCTAssertNotNil(storyBoard, "Storyboard couldnt be instantiated.")
        
        guard let predictionVc = storyBoard?.instantiateViewController(withIdentifier: Constants.predictionsResultsVcIdentifier) as? PredictionResultsViewController else {
            XCTFail("View controller is not yet here")
            return
        }
        
        predictionVc.loadViewIfNeeded()
        
        guard let _ = predictionVc.socialMediaView.subviews.first else {
            return XCTFail("ViewController should have outlet set for customView")
        }
    }
}
