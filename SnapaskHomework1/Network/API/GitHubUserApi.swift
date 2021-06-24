//
//  GitHubUserApi.swift
//  SnapaskHomework
//
//  Created by Albert_Chien on 2021/6/24.
//

import RxCocoa
import RxSwift
import Moya

struct GitHubUserApi {
    struct Request: SnapaskTargetType {

        typealias ResponseType = UserInfoDetail

        private let userName: String

        var path: String {
            "users/\(userName)"
        }

        var method: Moya.Method {
            .get
        }

        var task: Task {
            .requestPlain
        }

        var headers: [String: String]? {
            [:]
        }

        init(userName:String) {
            self.userName = userName
        }
    }

    class Client {
        var service:SnapaskNetworkService
        
        init(service:SnapaskNetworkService = SnapaskNetworkService.shared) {
            self.service = service
        }
        
        func getUserDetail(userName:String) -> Single<UserInfoDetail> {
            service.request(Request(userName: userName))
        }
    }
}
