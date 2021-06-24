//
//  UserListViewModel.swift
//  SnapaskHomework
//
//  Created by Albert_Chien on 2021/6/24.
//

import RxCocoa
import RxSwift

class UserListViewModel {
    private let client: GitHubUserListApi.Client = GitHubUserListApi.Client()
    
    private (set) var since = 0
    
    private var canLoad:Bool = true
    
    let perPage = 20
    
    func getUserCellObjects(since: Int, perPage: Int)->Single<[UserInfoTableViewCell.Object]> {
        if !canLoad {
            return Single.error(NSError(domain: "", code: 0, userInfo: nil))
        }
        return client.getUserList(since: since, perPage: since)
            .flatMap({ [weak self] userInfos in
                guard let self = self else {return Single.error(NSError()) }
               let objects = userInfos.map { info in
                    return UserInfoTableViewCell.Object(name: info.login,
                                                        imageURL: info.avatarURL,
                                                        isSiteAdmin: info.siteAdmin)
                }
                self.canLoad = true
                return Single<[UserInfoTableViewCell.Object]>.just(objects)
            })
            
    }
    
    func updateSince(since:Int) {
        self.since = since
    }
    
    func isNeedGetNextPage(index:Int)->Bool{
       index == since - 1
    }
}
