//
//  GitHubAccessManager.swift
//  SnapaskHomework
//
//  Created by Albert_Chien on 2021/6/23.
//

import RxCocoa
import RxSwift
import SafariServices
import OAuthSwift

class GitHubAccessManager {

    static let shared = GitHubAccessManager()

    private (set) lazy var oauthswift: OAuth2Swift = {
        let oauthswift = OAuth2Swift(
            consumerKey: GitHubAccessManager.clientID,
            consumerSecret: GitHubAccessManager.clientSecret,
            authorizeUrl: "https://github.com/login/oauth/authorize",
            accessTokenUrl: "https://github.com/login/oauth/access_token",
            responseType: "code"
        )
        return oauthswift
    }()
    
    
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
    
    func getAuthResult(vc: UIViewController)->Single<OAuthSwift.TokenSuccess> {
        unowned let unownedVC = vc
        return Single<OAuthSwift.TokenSuccess>.create { [weak self] (observer) -> Disposable in
            guard let self = self else {return Disposables.create()}
            
            let handler = SafariURLHandler(viewController: unownedVC, oauthSwift: self.oauthswift)
            
            handler.factory = { url in
                let controller = SFSafariViewController(url: url)
                return controller
            }
            self.oauthswift.authorizeURLHandler = handler
            
            let state = generateState(withLength: 20)
            _ = self.oauthswift.authorize(
                withCallbackURL: URL(string: "snapaskhomework://oauth-callback/snapask")!, scope: "user,repo", state: state) { result in
                switch result {
                case .success(let value):
                    observer(.success(value))
                case .failure(let error):
                    observer(.error(error))
                }
            }
            return Disposables.create()
        }
    }
}
