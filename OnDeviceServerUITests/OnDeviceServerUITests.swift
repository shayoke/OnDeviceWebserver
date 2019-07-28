//
//  OnDeviceServerUITests.swift
//  OnDeviceServerUITests
//
//  Created by Shayoke Mukherjee on 17/06/2019.
//  Copyright © 2019 Shayoke Mukherjee. All rights reserved.
//

import XCTest

class OnDeviceServerUITests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
        XCUIApplication().launch()

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() {

        let expectation = XCTestExpectation()

        sendMockserverMessage {
            expectation.fulfill()
        }

        wait(for: [expectation], timeout: 500)
    }
    
    
    
    func sendMockserverMessage(onComplete: @escaping () -> Void) {
        
        var components = URLComponents()
        components.scheme = "http"
        components.port = 8080
        components.host = "localhost"
        components.path = "/mockservermessage/"

        
        let request = URLRequest(url: components.url!)
        
        let task = URLSession.shared.dataTask(with: request) { data, _, error in
            print(String(data: data ?? Data(), encoding: .utf8))
            onComplete()
        }
        
        task.resume()
    }

}
