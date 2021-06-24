//
//  SnapaskTargetType.swift
//  SnapaskHomework
//
//  Created by Albert_Chien on 2021/6/23.
//

import Foundation
import Moya

protocol SnapaskTargetType: TargetType, Endpoints {
    associatedtype ResponseType: Codable
}

extension SnapaskTargetType {
    var baseURL: URL {
        URL(string: apiBaseURL)!
    }

    var headers: [String: String]? {
        [:]
    }

    var sampleData: Data {
        "".data(using: String.Encoding.utf8)!
    }
}
