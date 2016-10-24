//
//  NetworkManagerTests.swift
//  Flickr Viewer
//
//  Created by Jorge Mendes on 24/10/16.
//  Copyright © 2016 Jorge Mendes. All rights reserved.
//

import XCTest

@testable import Flickr_Viewer

class NetworkManagerTests: XCTestCase {
    
    fileprivate var manager: NetworkManager?
    
    override func setUp() {
        super.setUp()
        
        self.manager = NetworkManager.shared
    }
    
    override func tearDown() {
        self.manager = nil
        
        super.tearDown()
    }
    
    internal func testNetworkManagerInstance() {
        XCTAssertTrue(self.manager != nil)
    }
    
    internal func testNetworkSessionInstance() {
        XCTAssertTrue(self.manager?.session != nil)
    }
    
    internal func testFindPeopleRequest() {
        let requestExpectation: XCTestExpectation = expectation(description: "Find people by username")
        
        self.manager?.findPeopleByUsername(username: "eyetwist", result: { (response: [String : AnyObject], error: Error?) in
            if error == nil {
                XCTAssertTrue(response.keys.contains("stat"))
            } else {
                XCTFail()
            }
            requestExpectation.fulfill()
        })
        
        waitForExpectations(timeout: 60.0, handler: nil)
    }
    
    internal func testPublicPhotosRequest() {
        let requestExpectation: XCTestExpectation = expectation(description: "Get user public photos")
        
        self.manager?.getPublicPhotos(userId: "49191827@N00", page: 1, result: { (response: [String : AnyObject], error: Error?) in
            if error == nil {
                XCTAssertTrue(response.keys.contains("stat"))
            } else {
                XCTFail()
            }
            requestExpectation.fulfill()
        })
        
        waitForExpectations(timeout: 60.0, handler: nil)
    }
    
    internal func testPhotoInfoRequest() {
        let requestExpectation: XCTestExpectation = expectation(description: "Get photo infos")
        
        self.manager?.getPhotoInfo(photoId: "29894003064", photoSecret: "8cb19557a1", result: { (response: [String : AnyObject], error: Error?) in
            if error == nil {
                XCTAssertTrue(response.keys.contains("stat"))
            } else {
                XCTFail()
            }
            requestExpectation.fulfill()
        })
        
        waitForExpectations(timeout: 60.0, handler: nil)
    }
    
    internal func testPhotoSizesRequest() {
        let requestExpectation: XCTestExpectation = expectation(description: "Get photo sizes")
        
        self.manager?.getPhotoSizes(photoId: "29894003064", result: { (response: [String : AnyObject], error: Error?) in
            if error == nil {
                XCTAssertTrue(response.keys.contains("stat"))
            } else {
                XCTFail()
            }
            requestExpectation.fulfill()
        })
        
        waitForExpectations(timeout: 60.0, handler: nil)
    }
    
}
