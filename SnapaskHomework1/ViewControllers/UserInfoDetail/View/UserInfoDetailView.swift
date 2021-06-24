//
//  UserInfoDetailView.swift
//  SnapaskHomework
//
//  Created by Albert_Chien on 2021/6/24.
//

import UIKit
import Kingfisher

class UserInfoDetailView: UIView {
    
    private let iconImageView:UIImageView = {
        let view = UIImageView()
        view.layer.cornerRadius = 6
        view.clipsToBounds = true
        return view
    }()
    
    private let nameView:NameView = NameView()
    
    private let bioLabel:UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 15, weight: .regular)
        label.textColor = .white
        label.numberOfLines = 0
        return label
    }()
    
    private let locationLabel:UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 13, weight: .regular)
        label.textColor = .gray
        return label
    }()
    
    private let blogLabel:UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 15, weight: .regular)
        label.textColor = .white
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initView()
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func initView(){
        backgroundColor = .black
        addSubview(iconImageView)
        addSubview(nameView)
        addSubview(bioLabel)
        addSubview(locationLabel)
        addSubview(blogLabel)
    }
    
    private func layout(){
        iconImageView.snp.makeConstraints { make in
            make.top.left.equalToSuperview().inset(16)
            make.height.width.equalTo(100)
        }
        
        nameView.snp.makeConstraints { make in
            make.centerY.equalTo(iconImageView)
            make.left.equalTo(iconImageView.snp.right).offset(16)
        }
        
        bioLabel.snp.makeConstraints { make in
            make.top.equalTo(iconImageView.snp.bottom).offset(20)
            make.left.right.equalToSuperview().inset(16)
        }
        
        locationLabel.snp.makeConstraints { make in
            make.top.equalTo(bioLabel.snp.bottom).offset(20)
            make.left.right.equalToSuperview().inset(16)
        }
        
        blogLabel.snp.makeConstraints { make in
            make.top.equalTo(locationLabel.snp.bottom).offset(16)
            make.left.right.equalToSuperview().inset(16)
            make.bottom.equalToSuperview()
        }
    }
    
    func updateFrame(object:Object){
        iconImageView.kf.setImage(with: URL(string: object.imageURL))
        nameView.fullName = object.fullName
        nameView.loginName = object.loginName
        bioLabel.text = object.bio
        locationLabel.text = object.location
        blogLabel.text = object.blog
    }
}

extension UserInfoDetailView {
    struct Object:Equatable {
        let imageURL:String
        let fullName:String
        let loginName:String
        let bio:String?
        let isSiteAdmin:Bool
        let location:String
        let blog:String
    }
}

private class NameView:UIView {
    
    var fullName:String? {
        didSet{
            updateFrame()
        }
    }
    
    var loginName:String? {
        didSet{
            updateFrame()
        }
    }
    
    private let fullNameLabel:UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 22, weight: .semibold)
        label.textColor = .white
        return label
    }()
    
    private let loginNameLabel:UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 15, weight: .regular)
        label.textColor = .gray
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initView()
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func initView(){
        backgroundColor = .black
        addSubview(fullNameLabel)
        addSubview(loginNameLabel)
    }
    
    private func layout(){
        fullNameLabel.snp.makeConstraints { make in
            make.top.left.right.equalToSuperview()
        }
        loginNameLabel.snp.makeConstraints { make in
            make.top.equalTo(fullNameLabel.snp.bottom).offset(2)
            make.left.bottom.equalToSuperview()
        }
    }
    
    private func updateFrame(){
        fullNameLabel.text = fullName
        loginNameLabel.text = loginName
    }
}
