//
//  LoginAuthViewModel.swift
//  SnapaskHomework
//
//  Created by Albert_Chien on 2021/6/23.
//

import RxCocoa
import RxSwift
import SafariServices
import OAuthSwift

class LoginAuthViewModel {

    var disposeBag: DisposeBag = DisposeBag()
    
    private var oauthswift: OAuthSwift?

    func getAuthResult(vc: UIViewController)->Single<OAuthSwift.TokenSuccess> {
        unowned let unownedVC = vc
        return Single<OAuthSwift.TokenSuccess>.create { [weak self] (observer) -> Disposable in
            guard let self = self else {return Disposables.create()}
            let oauthswift = OAuth2Swift(
                consumerKey: GitHubAccessManager.clientID,
                consumerSecret: GitHubAccessManager.clientSecret,
                authorizeUrl: "https://github.com/login/oauth/authorize",
                accessTokenUrl: "https://github.com/login/oauth/access_token",
                responseType: "code"
            )
            self.oauthswift = oauthswift
            let handler = SafariURLHandler(viewController: unownedVC, oauthSwift: self.oauthswift!)
            
            handler.factory = { url in
                let controller = SFSafariViewController(url: url)
                return controller
            }
            oauthswift.authorizeURLHandler = handler
            
            let state = generateState(withLength: 20)
            _ = oauthswift.authorize(
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
