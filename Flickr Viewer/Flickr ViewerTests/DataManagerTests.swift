//
//  DataManagerTests.swift
//  Flickr Viewer
//
//  Created by Jorge Mendes on 24/10/16.
//  Copyright © 2016 Jorge Mendes. All rights reserved.
//

import XCTest

@testable import Flickr_Viewer

class DataManagerTests: XCTestCase {
    
    fileprivate var manager: DataManager?
    
    override func setUp() {
        super.setUp()
        
        self.manager = DataManager.shared
    }
    
    override func tearDown() {
        self.manager = nil
        
        super.tearDown()
    }
    
    internal func testDataManagerInstance() {
        XCTAssertTrue(self.manager != nil)
    }
    
    internal func testFlickerPhotosData() {
        let requestExpectation: XCTestExpectation = expectation(description: "Flicker photos data")
        
        self.manager?.getFlickerPhotos(page: 1, result: { (response: [Photo], error: Error?) in
            XCTAssertTrue(error == nil)
            requestExpectation.fulfill()
        })
        
        waitForExpectations(timeout: 240.0, handler: nil)
    }
    
    internal func testFlickerPhotosDataWithError() {
        let requestExpectation: XCTestExpectation = expectation(description: "Flicker photos data")
        
        self.manager?.getFlickerPhotos(page: UInt.max, result: { (response: [Photo], error: Error?) in
            XCTAssertTrue(error != nil)
            requestExpectation.fulfill()
        })
        
        waitForExpectations(timeout: 240.0, handler: nil)
    }
    
}
