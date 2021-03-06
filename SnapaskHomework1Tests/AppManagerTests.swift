//
//  AppManagerTests.swift
//  SnapaskHomeworkTests
//
//  Created by Albert_Chien on 2021/6/24.
//

import XCTest
@testable import SnapaskHomework1

class AppManagerTests: XCTestCase {
    
    private var sut:AppManager!
    
    func testWhen_AccessToken_Exist() {
        struct MockKeyChain:KeyChainable {
            var accessToken: String? = "123"
        }
        sut = AppManager(keyChain: MockKeyChain())
        XCTAssertTrue(sut.getCurrentRootViewController() is UserListViewController)
    }
    
    func testWhen_AccessToken_notExist() {
        struct MockKeyChain:KeyChainable {
            var accessToken: String? = nil
        }
        sut = AppManager(keyChain: MockKeyChain())
        XCTAssertTrue(sut.getCurrentRootViewController() is LoginAuthViewController)
    }
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}

