//
//  ImageModelTests.swift
//  FlickrTestAppTests
//
//  Created by iOS Team on 02/10/17.
//  Copyright © 2017 Sourabh. All rights reserved.
//

import XCTest

class ImageModelTests: XCTestCase {
    
    func testSuccessfulInit() {
        XCTAssertNotNil(ImageModel(title:"Sourabh",remoteURL:URL(string:"https://farm5.staticflickr.com//4476//23602698758_675cd9cf8c_m.jpg")!))
    }
    
}
