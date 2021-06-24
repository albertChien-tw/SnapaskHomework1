//
//  UserInfoDetail.swift
//  SnapaskHomework
//
//  Created by Albert_Chien on 2021/6/24.
//

import Foundation
// MARK: - UserInfoDetail
struct UserInfoDetail: Codable {
    let login: String
    let id: Int
    let nodeID: String
    let avatarURL: String
    let type: String
    let siteAdmin: Bool
    let name: String
    let blog: String
    let location:String
    let bio, twitterUsername: String?

    enum CodingKeys: String, CodingKey {
        case login, id
        case nodeID = "node_id"
        case avatarURL = "avatar_url"
        case type
        case siteAdmin = "site_admin"
        case name, blog, location, bio
        case twitterUsername = "twitter_username"
    }
}
