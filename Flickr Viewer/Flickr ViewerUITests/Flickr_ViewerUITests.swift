//
//  Flickr_ViewerUITests.swift
//  Flickr ViewerUITests
//
//  Created by Jorge Mendes on 24/10/16.
//  Copyright © 2016 Jorge Mendes. All rights reserved.
//

import XCTest

class Flickr_ViewerUITests: XCTestCase {
    
    fileprivate var app: XCUIApplication? = nil
    
    override func setUp() {
        super.setUp()
        
        continueAfterFailure = false
        
        self.app = XCUIApplication()
        self.app?.launch()
        
        sleep(10)
    }
    
    override func tearDown() {
        self.app = nil
        
        super.tearDown()
    }
    
    internal func testCellsFetch() {
        XCTAssertTrue(self.app!.collectionViews.cells.count > 0)
    }
    
    internal func testScrollLoad() {
        let initialCellsCount: Int = Int(self.app!.collectionViews.cells.count)
        
        for _ in 1 ... 10 {
            self.app!.otherElements.containing(.navigationBar, identifier:"eyetwist's album").children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .collectionView).element.swipeUp()
        }
        
        XCTAssertTrue(initialCellsCount < Int(self.app!.collectionViews.cells.count))
    }
    
    internal func testDetailNavigation() {
        self.app!.collectionViews.cells.otherElements.containing(.staticText, identifier:"that sign. hollywood, ca. 2016.").children(matching: .image).element.tap()
        XCTAssertTrue(self.app!.navigationBars["Photo Detail"].exists)
    }
    
    internal func testReturnFromDetail() {
        self.app!.collectionViews.cells.otherElements.containing(.staticText, identifier:"netflix and chill. bombay beach, ca. 2016.").children(matching: .image).element.tap()
        self.app!.navigationBars["Photo Detail"].buttons["eyetwist's album"].tap()
        XCTAssertTrue(self.app!.navigationBars["eyetwist's album"].exists)
    }
    
}
