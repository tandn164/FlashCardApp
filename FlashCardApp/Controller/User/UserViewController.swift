//
//  UserViewController.swift
//  FlashCardApp
//
//  Created by Nguyễn Đức Tân on 9/5/20.
//  Copyright © 2020 Nguyễn Đức Tân. All rights reserved.
//

import UIKit

class UserViewController: BaseViewController {

    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: false)
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
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 138
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueCell(UserTopTableViewCell.self, forIndexPath: indexPath) else {
            return UITableViewCell()
        }
        cell.delegate = self
        
        return cell
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

extension UserViewController: SignInDelegate, SignUpDelegate {
    func didSignIn() {
        tableView.reloadRows(at: [IndexPath(row: 0, section: 0)], with: .none)
    }
    
    func didSignUp() {
    }
}
