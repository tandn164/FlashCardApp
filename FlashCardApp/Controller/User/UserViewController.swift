//
//  UserViewController.swift
//  FlashCardApp
//
//  Created by Nguyễn Đức Tân on 9/5/20.
//  Copyright © 2020 Nguyễn Đức Tân. All rights reserved.
//

import UIKit
import FirebaseAuth

enum UserViewCellType: Int {
    
    case header = 0
    case emptyView
    case footerBlank
    case function
    case logout
    
    init(index: Int) {
        switch index {
        case 0:
            self = .header
        case 1:
            if ((DataLocal.getObject(AppKey.accountType) as? Int ?? 0) == 3 &&
                Auth.auth().currentUser?.isEmailVerified != true) ||
                (Auth.auth().currentUser == nil) {
                self = .emptyView
            } else  {
                self = .function
            }
        case 2:
            if ((DataLocal.getObject(AppKey.accountType) as? Int ?? 0) == 3 &&
                Auth.auth().currentUser?.isEmailVerified != true) ||
                (Auth.auth().currentUser == nil) { 
                self = .logout
            } else {
                self = .footerBlank
            }
        case 3:
            self = .logout
        default:
            self = .footerBlank
        }
    }
    
    var cellClass: UITableViewCell.Type {
        switch self {
        case .emptyView:
            return EmptyUserTableViewCell.self
        case .footerBlank:
            return UITableViewCell.self
        case .header:
            return UserTopTableViewCell.self
        case .logout:
            return SignOutTableViewCell.self
        case .function:
            return UITableViewCell.self
        }
    }
    
    var height: CGFloat {
        switch self {
        case .emptyView:
            if Auth.auth().currentUser?.isEmailVerified == false {
                return DeviceInfo.height - DeviceInfo.statusBarHeight*2 - 44 - 138 - 46
            } else {
                return DeviceInfo.height - DeviceInfo.statusBarHeight*2 - 44 - 138
            }
        case .header:
            return 138 + DeviceInfo.statusBarHeight
        case .function:
            return UITableViewCell().bounds.height
        case .footerBlank:
            return DeviceInfo.height - DeviceInfo.statusBarHeight*2 - 44 - 138 - UITableViewCell().bounds.height * 2
        case .logout:
            return 46
        }
    }
}

class UserViewController: BaseViewController {

    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: false)
        if let user = Auth.auth().currentUser {
            user.reload {[weak self] (error) in
                if let error = error {
                    UIAlertController.showError(message: error.localizedDescription)
                }
                self?.tableView.reloadData()
            }
        } else {
            tableView.reloadData()
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: false)
    }
}

extension UserViewController: UITableViewDelegate, UITableViewDataSource {
    
    func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.registerCellByNib(UserTopTableViewCell.self)
        tableView.registerCellByNib(SignOutTableViewCell.self)
        tableView.registerCell(EmptyUserTableViewCell.self)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if Auth.auth().currentUser == nil {
            tableView.isScrollEnabled = false
            return 2
        } else if (DataLocal.getObject(AppKey.accountType) as? Int ?? 0) == 3 &&
                    Auth.auth().currentUser?.isEmailVerified != true {
            tableView.isScrollEnabled = false
            return 3
        } else {
            tableView.isScrollEnabled = true
            return 4
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let cellType = UserViewCellType(index: indexPath.row)
        return cellType.height
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cellType = UserViewCellType(index: indexPath.row)
        switch cellType {
        case .header:
            guard let cell = tableView.dequeueCell(cellType.cellClass,
                                                   forIndexPath: indexPath) as? UserTopTableViewCell else {
                return UITableViewCell()
            }
            cell.delegate = self
            return cell
        case .emptyView:
            guard let cell = tableView.dequeueCell(cellType.cellClass,
                                                   forIndexPath: indexPath) as? EmptyUserTableViewCell else {
                return UITableViewCell()
            }
            return cell
        case .logout:
            guard let cell = tableView.dequeueCell(cellType.cellClass,
                                                   forIndexPath: indexPath) as? SignOutTableViewCell else {
                return UITableViewCell()
            }
            cell.delegate = self
            return cell
        default:
            let cell = UITableViewCell()
            cell.selectionStyle = .none
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return UIView()
    }
}

extension UserViewController: UserTopTableViewCellDelegate {
    
    func signInPressed() {
        let signInViewController = SignInViewController()
        signInViewController.delegate = self
        presentView(signInViewController)
    }
    
    func signUpPressed() {
        let signUpViewController = SignUpViewController()
        signUpViewController.delegate = self
        presentView(signUpViewController)
    }
    
    func presentView(_ viewController: BaseViewController) {
        let viewController = viewController
        let navi = BaseNavigationController(rootViewController: viewController)
        navi.modalPresentationStyle = .overFullScreen
        navi.modalTransitionStyle = .crossDissolve
        present(navi, animated: true)
    }
}

extension UserViewController: SignInDelegate, SignUpDelegate, SignOutDelegate {
    func didSignIn() {
        tableView.reloadData()
    }
    
    func didSignUp() {
        if Auth.auth().currentUser != nil {
            tableView.reloadData()
        }
    }
    
    func didSignOut() {
        tableView.reloadData()
    }
}
