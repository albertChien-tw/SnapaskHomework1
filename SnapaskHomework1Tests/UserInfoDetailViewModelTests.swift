//
//  UserInfoDetailViewModelTests.swift
//  SnapaskHomeworkTests
//
//  Created by Albert_Chien on 2021/6/24.
//

import XCTest
import Moya
import RxSwift
import RxCocoa
import RxTest
import RxBlocking

@testable import SnapaskHomework1

class UserInfoDetailViewModelTests: XCTestCase {
    
    private var sut:UserInfoDetailViewModel!
    var service:SnapaskNetworkService!
    
    func testWhen_GetUserInfoSuccess() {
        class Mock:GitHubUserApi.Client {
            override func getUserDetail(userName: String) -> Single<UserInfoDetail> {
                let stubbing = StubbingConstructor()
                let response = GitHubUserApi.Request.ResponseType(login: "Albert",
                                                                  id: 1,
                                                                  nodeID: "1",
                                                                  avatarURL: "",
                                                                  type: "",
                                                                  siteAdmin: true,
                                                                  name: "AlbertChien",
                                                                  blog: "",
                                                                  location: "",
                                                                  bio: nil,
                                                                  twitterUsername: nil)
                let data = response.encoded()!
                let request = GitHubUserApi.Request(userName: "")
                let service = stubbing.setSuccess(mockData: data)
                return service.request(request)
            }
        }
        let mock = Mock()
        DIContainer.shared.register(type: GitHubUserApi.Client.self, component: mock)
        sut = UserInfoDetailViewModel()
        let result = sut.getUserObject(userName: "").toBlocking().materialize()
        switch result {
        case .completed(elements: let elements):
            XCTAssertTrue(elements == [UserInfoDetailView.Object(imageURL: "",
                                                                fullName: "AlbertChien",
                                                                loginName: "Albert",
                                                                bio: nil,
                                                                isSiteAdmin: true,
                                                                location: "",
                                                                blog: "")])
        case .failed:
            XCTAssertFalse(true, "It is not possible.")
        }
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
