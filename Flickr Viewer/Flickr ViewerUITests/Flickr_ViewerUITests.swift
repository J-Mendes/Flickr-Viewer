//
//  Flickr_ViewerUITests.swift
//  Flickr ViewerUITests
//
//  Created by Jorge Mendes on 24/10/16.
//  Copyright © 2016 Jorge Mendes. All rights reserved.
//

import XCTest

class Flickr_ViewerUITests: XCTestCase {
        
    override func setUp() {
        super.setUp()
        
        continueAfterFailure = false
        
        XCUIApplication().launch()
        
        sleep(30)
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    internal func testCellsFetch() {
        XCTAssertTrue(XCUIApplication().collectionViews.cells.otherElements.containing(.staticText, identifier: "that sign. hollywood, ca. 2016.").count > 0)
    }
    
}
