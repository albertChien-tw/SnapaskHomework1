//
//  UserListViewController.swift
//  SnapaskHomework
//
//  Created by Albert_Chien on 2021/6/24.
//

import UIKit

class UserListViewController: BaseViewController {

    private let viewModel: UserListViewModel = UserListViewModel()
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        tableView.backgroundColor = UIColor.black
        tableView.register(UserInfoTableViewCell.self, forCellReuseIdentifier: UserInfoTableViewCell.identifier)
        return tableView
    }()
    
    private var cellObjects:[UserInfoTableViewCell.Object] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initView()
        layout()
//        updateTableViewData()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setNavigationBarAppearance(backgroundColor: .black, titleColor: .white)
    }
}
//MARK:Private func
extension UserListViewController {
    
    private func initView(){
        view.backgroundColor = .black
        view.addSubview(tableView)
    }
    
    private func layout(){
        tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    private func updateTableViewData(){
        ProgressManager.showPressHUD()
        viewModel.getUserCellObjects(since: viewModel.since, perPage: viewModel.perPage)
            .subscribe { [weak self] objects in
                guard let self = self else {return}
                ProgressManager.dismiss()
                objects.forEach { object in
                    self.cellObjects.append(object)
                }
                self.tableView.reloadData()
                self.viewModel.updateSince(since: self.cellObjects.count)
            } onError: { error in
                ProgressManager.showErrorHUD(withStatus: error.localizedDescription)
            }.disposed(by: disposeBag)
    }
}
//MARK:TableViewDelegate
extension UserListViewController:UITableViewDataSource,UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        cellObjects.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let object = cellObjects[indexPath.row]
        guard let cell = tableView.dequeueReusableCell(withIdentifier: UserInfoTableViewCell.identifier, for: indexPath) as? UserInfoTableViewCell else {
            return UITableViewCell()
        }
        cell.updateFrame(object: object)
        return cell
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if viewModel.isNeedGetNextPage(index: indexPath.row) {
            updateTableViewData()
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let object = cellObjects[indexPath.row]
        let vc = UserInfoDetailViewController.init(userName: object.name)
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
