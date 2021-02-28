//
//  UserViewController.swift
//  FlashCardApp
//
//  Created by Nguyễn Đức Tân on 9/5/20.
//  Copyright © 2020 Nguyễn Đức Tân. All rights reserved.
//

import UIKit
import FirebaseAuth

class HomeViewController: BaseViewController {

    @IBOutlet weak var addNewGenreButton: UIImageView!
    @IBOutlet weak var collectionView: UICollectionView!
    private let numbersItemRow: CGFloat = 3.0
    private let spaceBetween: CGFloat = 10.0
    var numberOfRowsPerLine: Int = 3
    
    private var itemWidth: CGFloat = {
        let numbersItemRow: CGFloat = 3.0
        let spaceBetween: CGFloat = 11.0
        let rowWidth: CGFloat = DeviceInfo.width - 16.0*2
        return (rowWidth - spaceBetween * (numbersItemRow-1)) / numbersItemRow
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.registerHeaderByNib(AccountHeaderCollectionReusableView.self)
        collectionView.registerFooterByNib(AccountFooterCollectionReusableView.self)
        collectionView.registerHeaderByNib(GenreHeaderCollectionReusableView.self)
        collectionView.registerFooterByNib(GenreFooterCollectionReusableView.self)
        collectionView.registerFooterByNib(LastGenreFooterCollectionReusableView.self)
        collectionView.registerCellByNib(FlashCardCollectionViewCell.self)
        setTitleHeader(title: "Home")
        
        addNewGenreButton.addGestureRecognizer(UITapGestureRecognizer(target: self,
                                                                      action: #selector(addNewGenreAction)))
        addNewGenreButton.layer.shadowRadius = 5
        addNewGenreButton.layer.shadowOffset = CGSize(width: 0, height: 5)
        addNewGenreButton.layer.shadowOpacity = 0.1
        addNewGenreButton.layer.shadowColor = UIColor.primaryColor?.cgColor
        addNewGenreButton.layer.shadowPath = UIBezierPath(rect: addNewGenreButton.bounds).cgPath
        addNewGenreButton.layer.cornerRadius = 25
        
    }
    
    @objc func addNewGenreAction() {
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: false)
        if let user = Auth.auth().currentUser {
            user.reload {[weak self] (error) in
                if let error = error {
                    UIAlertController.showError(message: error.localizedDescription)
                }
                self?.collectionView.reloadData()
            }
        } else {
            collectionView.reloadData()
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: false)
    }
}

extension HomeViewController: UICollectionViewDelegateFlowLayout,
                              UICollectionViewDelegate,
                              UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section != 0 {
            return 3
        }
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let reusableCell = collectionView.dequeueCell(FlashCardCollectionViewCell.self, forIndexPath: indexPath)!
        return reusableCell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        switch kind {
        case UICollectionView.elementKindSectionHeader:
            if indexPath.section == 0 {
                guard let reusableView = collectionView.dequeueHeader(AccountHeaderCollectionReusableView.self,
                                                                      forIndexPath: indexPath) else {
                    return UICollectionReusableView()
                }
                reusableView.delegate = self
                return reusableView
            } else {
                guard let reusableView = collectionView.dequeueHeader(GenreHeaderCollectionReusableView.self,
                                                                      forIndexPath: indexPath) else {
                    return UICollectionReusableView()
                }
                return reusableView
            }
        default:
            if indexPath.section == 0 {
                guard let reusableView = collectionView.dequeueFooter(AccountFooterCollectionReusableView.self,
                                                                      forIndexPath: indexPath) else {
                    return UICollectionReusableView()
                }
                return reusableView
            } else if indexPath.section == 2 {
                guard let reusableView = collectionView.dequeueFooter(LastGenreFooterCollectionReusableView.self,
                                                                      forIndexPath: indexPath) else {
                    return UICollectionReusableView()
                }
                return reusableView
            } else {
                guard let reusableView = collectionView.dequeueFooter(GenreFooterCollectionReusableView.self,
                                                                      forIndexPath: indexPath) else {
                    return UICollectionReusableView()
                }
                return reusableView
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        if section == 0 {
            return CGSize(width: collectionView.frame.width, height: 203)
        } else {
            return CGSize(width: collectionView.frame.width, height: 50)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        if section == 0 {
            return CGSize(width: collectionView.frame.width, height: 10)

        }
        return CGSize(width: collectionView.frame.width, height: 20)
    }
    
    func preferredLayoutAttributesFitting(_ layoutAttributes: UICollectionViewLayoutAttributes) -> UICollectionViewLayoutAttributes {
        return layoutAttributes
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        insetForSectionAt section: Int) -> UIEdgeInsets {
        if section == 0 {
            return .zero
        }
        return UIEdgeInsets(top: 0, left: 16, bottom: 20, right: 16)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = itemWidth
        let height = (width * 4) / 3
        
        let size = CGSize(width: width, height: height)
        return size
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return spaceBetween
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return spaceBetween
    }
}

extension HomeViewController: AccountHeaderDelegate {
    
    func settingPressed() {
        
    }
    
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

extension HomeViewController: SignInDelegate, SignUpDelegate {
    func didSignIn() {
        collectionView.reloadData()
    }
    
    func didSignUp() {
    }
    
    override func logoutUser() {
        super.logoutUser()
        AuthService.instance.logout { (success) in
            if success {
                collectionView.reloadData()
            }
        }
    }
    
    override func editProfileUser() {
        super.editProfileUser()
    }
}
