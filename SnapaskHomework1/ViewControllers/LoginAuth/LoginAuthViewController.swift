//
//  LoginAuthViewController.swift
//  SnapaskHomework
//
//  Created by Albert_Chien on 2021/6/23.
//

import UIKit
import OAuthSwift
import SafariServices
import SVProgressHUD

class LoginAuthViewController: BaseViewController {

    private let viewModel: LoginAuthViewModel = LoginAuthViewModel()
    
    private var keyChain:KeyChainable = KeyChainManager()
    
    private let signInButton: UIButton = {
        let button = UIButton()
        button.setTitle("Sign in with GitHub", for: .normal)
        return button
    }()

    init(keyChain:KeyChainable = KeyChainManager()) {
        self.keyChain = keyChain
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initView()
        reactiveX()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setNavigationBarAppearance(backgroundColor: .black, titleColor: .white)
    }
}
// MARK: Private func
extension LoginAuthViewController {

    private func initView() {
        view.backgroundColor = .black
        view.addSubview(signInButton)
        signInButton.snp.makeConstraints { make in
            make.right.left.equalToSuperview()
            make.bottom.equalToSuperview().inset(50)
        }
    }

    private func reactiveX() {
        signInButton.rx.controlEvent(.touchUpInside)
            .subscribe { [weak self] _ in
                guard let self = self else {return}
                self.startOAuth()
            }.disposed(by: disposeBag)
    }

    private func startOAuth() {
        viewModel.getAuthResult(vc: self)
            .subscribe {[weak self] result in
                guard let self = self else {return}
                self.keyChain.accessToken = result.credential.oauthToken
                AppManager.shared.start(in: UIApplication.shared.keyWindow)
            } onError: { error in
                ProgressManager.showErrorHUD(withStatus: error.localizedDescription)
            }.disposed(by: disposeBag)
    }
}
