//
//  OnboardingTest.swift
//  HashMeTests
//
//  Created by Dheeru on 2/1/18.
//  Copyright © 2018 Dheeru. All rights reserved.
//

import XCTest
@testable import HashAll

class OnboardingTest: XCTestCase {
    
    var storyBoard: UIStoryboard?
    var onboardingVc: OnboardingViewController?
    
    override func setUp() {
        super.setUp()
        self.storyBoard = UIStoryboard(name: Constants.mainStoryboardIdentifier, bundle: nil)
        XCTAssertNotNil(storyBoard, "Storyboard couldnt be instantiated.")
        
        guard let onboardingVc = storyBoard?.instantiateViewController(withIdentifier: Constants.onboardingVcIdentifier) as? OnboardingViewController else {
            XCTFail("View controller is not here")
            return
        }
        self.onboardingVc = onboardingVc
        self.onboardingVc?.viewModel = OnboardingTestViewModel(flowDelegate: nil)
        self.onboardingVc?.loadViewIfNeeded()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
    func testOnboarding() {
        onboardingVc?.viewDidAppear(true)
        XCTAssertEqual(onboardingVc?.getstartedButton.titleLabel?.text, "test get started", "Get started button title is different")
        XCTAssertNotNil(onboardingVc?.pageControl, "Page control not initialized")
        XCTAssertNotNil(onboardingVc?.viewModel, "View Model is not initialized")
        
        onboardingVc?.viewDidAppear(true)
    }
    
    func testOnboardingSubViewControllerOne() {
        guard let onboardingVcOne = storyBoard?.instantiateViewController(withIdentifier: Constants.onboardingViewController1) as? OnboardingSubViewControllerOne else {
            XCTAssert(false, "OnboardingVieewControllerOne is not initialized.")
            return
        }
        let _ = onboardingVcOne.view
        onboardingVcOne.viewDidAppear(true)
        
        XCTAssertNotNil(onboardingVcOne.step1Label, "Step 1 label is not yet initialized")
        XCTAssertNotNil(onboardingVcOne.screenShot1, "Screen shot imagevie is not yet initialized")
        XCTAssertEqual(onboardingVcOne.step1Label.text, LocalizedString.onboardingStep1Text)
    }
    
    func testOnboardingSubViewControllerTwo() {
        guard let onboardingVcTwo = storyBoard?.instantiateViewController(withIdentifier: Constants.onboardingViewController2) as? OnboardingSubViewControllerTwo else {
            XCTAssert(false, "OnboardingVieewControllerOne is not initialized.")
            return
        }
        let _ = onboardingVcTwo.view
        onboardingVcTwo.viewDidAppear(true)
        
        XCTAssertNotNil(onboardingVcTwo.step2Label, "Step 2 label is not yet initialized")
        XCTAssertEqual(onboardingVcTwo.step2Label.text, LocalizedString.onboardingStep2Text)
    }
    
    func testOnboardingSubViewControllerThree() {
        guard let onboardingVcThree = storyBoard?.instantiateViewController(withIdentifier: Constants.onboardingViewController3) as? OnboardingSubViewControllerThree else {
            XCTAssert(false, "OnboardingVieewControllerOne is not initialized.")
            return
        }
        let _ = onboardingVcThree.view
        onboardingVcThree.viewDidAppear(true)
        
        XCTAssertNotNil(onboardingVcThree.step3Label, "Step 2 label is not yet initialized")
        XCTAssertEqual(onboardingVcThree.step3Label.text, LocalizedString.onboardingStep3Text)
    }
}


