//
//  PredictionResultsTests.swift
//  HashMeTests
//
//  Created by Dheeru on 2/9/18.
//  Copyright © 2018 Dheeru. All rights reserved.
//

import XCTest
@testable import HashAll

class PredictionResultsTests: XCTestCase {
    
    var storyBoard: UIStoryboard?
    var predictionResultsVc: PredictionResultsViewController?
    
    override func setUp() {
        super.setUp()
        self.storyBoard = UIStoryboard(name: Constants.mainStoryboardIdentifier, bundle: nil)
        XCTAssertNotNil(storyBoard, "Storyboard couldnt be instantiated.")
        
        guard let predictionResultsVc = storyBoard?.instantiateViewController(withIdentifier: Constants.predictionsResultsVcIdentifier) as? PredictionResultsViewController else {
            XCTFail("View controller is not yet here")
            return
        }
        self.predictionResultsVc = predictionResultsVc
        self.predictionResultsVc?.viewModel = PredictionResultsTestViewModel(predictions: ["one", "two"], withPredictionImage: UIImage())
        self.predictionResultsVc?.loadViewIfNeeded()
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testPerformanceExample() {
        self.measure {
            
        }
    }
    
    func testPredictionResults() {
        XCTAssertNotNil(predictionResultsVc, "Prediction Results Vc is nil")
        XCTAssertNotNil(predictionResultsVc?.copiedLabel, "CopiedLabel is empty")
        XCTAssertNotNil(predictionResultsVc?.socialMediaView, "SocialMediaView is empty")
        XCTAssertNotNil(predictionResultsVc?.copiedView, "CopiedViewis empty")
        XCTAssertNotNil(predictionResultsVc?.selectAllButton, "SelectAllButton is empty")
        XCTAssertNotNil(predictionResultsVc?.copyButton, "CopyButton is empty")
        XCTAssertNotNil(predictionResultsVc?.predictionResultsCollectionView, "PredictionResultsCollectionView is empty")
        XCTAssertNotNil(predictionResultsVc?.stackView, "StackView is empty")
        XCTAssertNotNil(predictionResultsVc?.shareButton, "ShareButton is empty")
    }
    
    func testPredictionsData() {
        XCTAssertEqual(predictionResultsVc?.copyButton.titleLabel?.text, "test copy button", "Copy button title is different")
        XCTAssertEqual(predictionResultsVc?.copiedLabel.text, "test copied", "Copy label title is different")
        
        let numberOfItems = predictionResultsVc?.predictionResultsCollectionView.numberOfItems(inSection: 0)
        XCTAssertEqual(numberOfItems, 100, "Number of items in collection view are different")
    }
}

