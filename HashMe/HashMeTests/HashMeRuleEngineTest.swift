//
//  HashMeRuleEngineTest.swift
//  HashMeTests
//
//  Created by Dheeru on 2/8/18.
//  Copyright © 2018 Dheeru. All rights reserved.
//

import XCTest
@testable import HashAll

class HashMeRuleEngineTest: XCTestCase, HashMeRuleEngineProtocol {
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testPerformanceExample() {
        self.measure {
            
        }
    }
    
    func testHashMeRuleEngine() {
        XCTAssertNotNil(self.context, "Context should not be nil")
        
        XCTAssertNotNil(self.maximumTagsForIpad(), "Maximum tags for iPad should not be nil")
        XCTAssertNotNil(self.maximumTagsForIphone(), "Maximum tags for iPhone should not be nil")
        XCTAssertNotNil(self.contactUsEmailId(), "Contact us email id should not be nil")
        XCTAssertNotNil(self.contactUsEmailSubject(), "Contacts us emaild subject should not be nil")
        XCTAssertNotNil(self.appendHashToString(tobeFormattedString: ""), "Append hash should not be nil")

        XCTAssertEqual(self.maximumTagsForIpad(), 10, "Maximum number of tags for iPad are not equal")
        XCTAssertEqual(self.maximumTagsForIphone(), 7, "Maximum number of tags for iPhone are not equal")
        XCTAssertEqual(self.contactUsEmailId(), Constants.ContactUs.recipient, "Contact us email id is not same")
        XCTAssertEqual(self.contactUsEmailSubject(), Constants.ContactUs.subject, "Contact us are not same")
        XCTAssertEqual(self.appendHashToString(tobeFormattedString: "hashAll"), "#hashAll", "Formatted string doesnt match")
    }
}
