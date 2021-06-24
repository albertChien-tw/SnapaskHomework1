//
//  UserInfoDetailViewModel.swift
//  SnapaskHomework
//
//  Created by Albert_Chien on 2021/6/24.
//

import RxCocoa
import RxSwift

class UserInfoDetailViewModel {
    
    @Injected(defaultValue: GitHubUserApi.Client())
    private var client: GitHubUserApi.Client
    
    func getUserObject(userName:String)->Single<UserInfoDetailView.Object> {
        client.getUserDetail(userName: userName).map { info in
            UserInfoDetailView.Object(imageURL: info.avatarURL,
                                      fullName: info.name,
                                      loginName: info.login,
                                      bio: info.bio,
                                      isSiteAdmin: info.siteAdmin,
                                      location: info.location,
                                      blog: info.blog)
        }
    }
    
}
