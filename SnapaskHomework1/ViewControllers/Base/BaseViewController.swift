//
//  BaseViewController.swift
//  SnapaskHomework
//
//  Created by Albert_Chien on 2021/6/23.
//

import UIKit
import SnapKit
import RxCocoa
import RxSwift

class BaseViewController: UIViewController {

    let disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
}

extension BaseViewController {
    func setNavigationBarAppearance(backgroundColor: UIColor, titleColor: UIColor) {
        if #available(iOS 13.0, *) {
            if let appearance = navigationController?.navigationBar.standardAppearance.copy() {
                appearance.backgroundColor = backgroundColor
                appearance.titleTextAttributes = [NSAttributedString.Key.foregroundColor: titleColor]
                navigationController?.navigationBar.standardAppearance = appearance
                navigationController?.navigationBar.scrollEdgeAppearance = appearance
            } else {
                let navigationBarAppearence = UINavigationBarAppearance()
                navigationBarAppearence.configureWithOpaqueBackground()
                navigationBarAppearence.backgroundColor = backgroundColor
                navigationBarAppearence.titleTextAttributes = [NSAttributedString.Key.foregroundColor: titleColor]
                navigationController?.navigationBar.standardAppearance = navigationBarAppearence
                navigationController?.navigationBar.scrollEdgeAppearance = navigationBarAppearence
            }
        } else {
            navigationController?.navigationBar.tintColor = titleColor
            navigationController?.navigationBar.barTintColor = backgroundColor
            navigationController?.navigationBar.backgroundColor = backgroundColor
        }
        navigationController?.navigationBar.setNeedsLayout()
    }
}
