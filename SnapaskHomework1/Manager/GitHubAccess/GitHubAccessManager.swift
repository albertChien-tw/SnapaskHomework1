//
//  GitHubAccessManager.swift
//  SnapaskHomework
//
//  Created by Albert_Chien on 2021/6/23.
//

import RxCocoa
import RxSwift

class GitHubAccessManager {

    static let shared = GitHubAccessManager()

    class var clientID: String {
        guard let id = shared.info?["clientID"] else {fatalError()}
        return id
    }

    class var clientSecret: String {
        guard let secret = shared.info?["clientSecret"] else {fatalError()}
        return secret
    }

    init() {}

    var accessToken: String?

    private var info: [String: String]? = {
        guard let path = Bundle.main.path(forResource: "SnapaskInfo", ofType: "plist"),
        let info = NSDictionary(contentsOfFile: path) as? [String: String] else {return nil}
        return info
    }()
}
