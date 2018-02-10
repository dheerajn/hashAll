//
//  PredictionsTests.swift
//  HashMeTests
//
//  Created by Dheeru on 2/2/18.
//  Copyright © 2018 Dheeru. All rights reserved.
//

import XCTest
@testable import HashAll

class PredictionsTests: XCTestCase {
    
    var storyBoard: UIStoryboard?
    var predictionVc: PredictionsViewController?
    
    override func setUp() {
        super.setUp()
        self.storyBoard = UIStoryboard(name: Constants.mainStoryboardIdentifier, bundle: nil)
        XCTAssertNotNil(storyBoard, "Storyboard couldnt be instantiated.")
        
        guard let predictionVc = storyBoard?.instantiateViewController(withIdentifier: Constants.predictionsVcIdentifier) as? PredictionsViewController else {
            XCTFail("View controller is not yet here")
            return
        }
        self.predictionVc = predictionVc
        self.predictionVc?.viewModel = PredictionsTestViewModel(flowDelegate: nil)
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testPerformanceExample() {
        self.measure {
            predictionVc?.viewModel?.predictImage(ref: #imageLiteral(resourceName: "screenshot3").buffer!, predictionImage: #imageLiteral(resourceName: "screenshot3"))
        }
    }
    
    func testPredictions() {
        
        predictionVc?.loadViewIfNeeded()
        
        XCTAssertNil(predictionVc?.flowDelegate, "FlowDelegate is not nil")
        XCTAssertNotNil(predictionVc?.imagePicker, "image picker is empty")
        XCTAssertNotNil(predictionVc?.descriptionLabel, "descriptionLabel is empty")
        XCTAssertNotNil(predictionVc?.cameraButton, "cameraButton is empty")
        XCTAssertNotNil(predictionVc?.photoLibraryButton, "photoLibraryButton is empty")
        XCTAssertNotNil(predictionVc?.contactUsContainerView, "contactUsContainerView is empty")
        XCTAssertNotNil(predictionVc?.feedbackButton, "feedbackButton is empty")
        XCTAssertNotNil(predictionVc?.contactUsButton, "contactUsButton is empty")

        predictionVc?.shouldHideContactsUsView = true
        XCTAssertTrue((predictionVc?.contactUsContainerView.isHidden)!, "shouldHideContactsUsView is not yet hidden")
        
        predictionVc?.shouldHideContactsUsView = false
        XCTAssertFalse((predictionVc?.contactUsContainerView.isHidden)!, "shouldHideContactsUsView is hidden already")
        
        predictionVc?.rightBarButtonTapped()
        XCTAssertTrue((predictionVc?.contactUsContainerView.isHidden)!, "shouldHideContactsUsView is not yet hidden, so hide it right now")
        
        predictionVc?.viewDidAppear(true)
        predictionVc?.setStatusBar()
        XCTAssertNil(predictionVc?.navigationController?.navigationBar.barStyle, "status bar style is set")
        
        XCTAssertEqual(predictionVc?.descriptionLabel.text, "test description", "description label is different")
        XCTAssertEqual(predictionVc?.photoLibraryButton.titleLabel?.text, "test photo library button", "Photo Library button title is different")
        XCTAssertEqual(predictionVc?.cameraButton.titleLabel?.text, "test camera button", "Camera button title is different")
    }
}
