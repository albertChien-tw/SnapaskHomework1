//
//  UserInfoTableViewCell.swift
//  SnapaskHomework
//
//  Created by Albert_Chien on 2021/6/24.
//

import UIKit
import Kingfisher

class UserInfoTableViewCell: UITableViewCell {
    
    static let identifier = "UserInfoTableViewCell"
        
    private let cardView:UIView = {
        let view = UIView()
        view.layer.borderColor = UIColor.gray.cgColor
        view.layer.borderWidth = 0.5
        view.layer.cornerRadius = 6
        view.backgroundColor = .black.withAlphaComponent(0.85)
        return view
    }()
    
    private let nameLabel:UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 15, weight: .medium)
        label.textColor = .white
        return label
    }()
    
    private let iconImageView:UIImageView = {
        let view = UIImageView()
        view.layer.cornerRadius = 6
        view.clipsToBounds = true
        return view
    }()

    private let markImageView:UIImageView = {
        let image = UIImage(named: "unMark")
        let imageView = UIImageView.init(image: image)
        return imageView
    }()
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        initView()
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func initView(){
        contentView.backgroundColor = .black
        contentView.addSubview(cardView)
        cardView.addSubview(iconImageView)
        cardView.addSubview(nameLabel)
        cardView.addSubview(markImageView)
    }
    
    private func layout(){
        cardView.snp.makeConstraints { make in
            make.right.left.equalToSuperview().inset(16)
            make.top.bottom.equalToSuperview().inset(8)
        }
        
        iconImageView.snp.makeConstraints { make in
            make.left.equalToSuperview().inset(6)
            make.width.height.equalTo(44)
            make.bottom.top.equalToSuperview().inset(10)
        }
        
        nameLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(10)
            make.right.equalToSuperview().inset(6)
        }
        
        markImageView.snp.makeConstraints { make in
            make.right.equalToSuperview().inset(6)
            make.bottom.equalToSuperview().inset(10)
        }
    }
    
    func updateFrame(object:Object){
        nameLabel.text = object.name
        iconImageView.kf.setImage(with: URL(string: object.imageURL))
        let image = object.isSiteAdmin ? UIImage(named: "marked") : UIImage(named: "unMark")
        markImageView.image = image
    }
    
}

extension UserInfoTableViewCell {
    struct Object:Equatable {
        let name:String
        let imageURL:String
        let isSiteAdmin:Bool
    }
}
