//
//  GitHubUserListApi.swift
//  SnapaskHomework
//
//  Created by Albert_Chien on 2021/6/24.
//

import RxCocoa
import RxSwift
import Moya

struct GitHubUserListApi {
    struct Request: SnapaskTargetType {

        typealias ResponseType = [UserInfo]

        private var parameters: [String: Any] = [:]

        var path: String {
            "users"
        }

        var method: Moya.Method {
            .get
        }

        var task: Task {
            .requestParameters(parameters: parameters, encoding: URLEncoding.default)
        }

        var headers: [String: String]? {
            [:]
        }

        init(since: Int, perPage: Int) {
            parameters["since"] = since
            parameters["per_page"] = perPage

        }
    }

    class Client {
        private let provider = SnapaskProvider<Request>()

        func getUserList(since: Int, perPage: Int) -> Single<[UserInfo]> {
            return provider.request(Request.ResponseType.self, request: Request(since: since, perPage: perPage))
        }
    }
}
