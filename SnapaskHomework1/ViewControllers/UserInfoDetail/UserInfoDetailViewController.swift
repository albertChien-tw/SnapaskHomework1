//
//  UserInfoDetailViewController.swift
//  SnapaskHomework
//
//  Created by Albert_Chien on 2021/6/24.
//

import UIKit

class UserInfoDetailViewController: BaseViewController {

    private let viewModel:UserInfoDetailViewModel = UserInfoDetailViewModel()
    
    private let detailView:UserInfoDetailView = UserInfoDetailView()
    
    private let userName:String
    
    init(userName:String) {
        self.userName = userName
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initView()
        layout()
        updateDetailViewData()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setNavigationBarAppearance(backgroundColor: .black, titleColor: .white)
    }
}
extension UserInfoDetailViewController {
    
    private func initView(){
        view.backgroundColor = .black
        view.addSubview(detailView)
    }
    
    private func layout(){
        detailView.snp.makeConstraints { make in
            make.right.left.equalToSuperview()
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
        }
    }
    
    private func updateDetailViewData(){
        ProgressManager.showPressHUD()
        viewModel.getUserObject(userName: userName)
            .subscribe {[weak self] object in
                guard let self = self else {return}
                ProgressManager.dismiss()
                self.detailView.updateFrame(object: object)
            } onError: { error in
                ProgressManager.showErrorHUD(withStatus: error.localizedDescription)
            }.disposed(by: disposeBag)
    }
}
