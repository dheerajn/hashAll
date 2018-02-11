//
//  KeyboardCustomViewTests.swift
//  HashMeTests
//
//  Created by Dheeru on 2/11/18.
//  Copyright © 2018 Dheeru. All rights reserved.
//

import XCTest
@testable import HashAll

class KeyboardCustomViewTests: XCTestCase {
    
    var storyBoard: UIStoryboard?
    var predictionResultsVc: PredictionResultsViewController?
    
    func testInitializingWithFrame() {
        let frame = CGRect(x: 0, y: 0, width: 10, height: 10)
        XCTAssertFalse(KeyboardCustomView(frame: frame).subviews.isEmpty,
                       "CustomView should add subviews from nib when instantiated in code")
    }
    
    func testInitializing() {
        self.storyBoard = UIStoryboard(name: Constants.mainStoryboardIdentifier, bundle: nil)
        XCTAssertNotNil(storyBoard, "Storyboard couldnt be instantiated.")
        
        guard let predictionVc = storyBoard?.instantiateViewController(withIdentifier: Constants.predictionsResultsVcIdentifier) as? PredictionResultsViewController else {
            XCTFail("View controller is not yet here")
            return
        }
        
        predictionVc.loadViewIfNeeded()
        
        guard let _ = predictionVc.keyboardView.subviews.first else {
            return XCTFail("ViewController should have outlet set for customView")
        }
    }
}

