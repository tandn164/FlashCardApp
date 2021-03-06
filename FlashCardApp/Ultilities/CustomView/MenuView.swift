//
//  MenuView.swift
//  FlashCardApp
//
//  Created by Nguyễn Đức Tân on 01/03/2021.
//  Copyright © 2021 Nguyễn Đức Tân. All rights reserved.
//

import UIKit

enum MenuType: Int {
    case upload = 0
    case download
    case edit
    case logout
}

struct MenuItem {
    var title: String?
    var icon: UIImage?
    var type: MenuType?
}

protocol MenuViewDelegate: class {
    func logout()
    func editProfile()
}

class MenuView: UIView {

    @IBOutlet var contentView: UIView!
    @IBOutlet weak var tableView: UITableView!
    weak var delegate: MenuViewDelegate?
    
    let menuItem = [MenuItem(title: "Edit Profile",
                             icon: UIImage(named: "icProfile"),
                             type: .edit),
                    MenuItem(title: "Logout",
                             icon: UIImage(named: "icLogout"),
                             type: .logout)]
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
        initSubviews()
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        initSubviews()
    }
    
    func initSubviews() {
        let nib = UINib(nibName: "MenuView", bundle: nil)
        nib.instantiate(withOwner: self, options: nil)
        contentView.frame = bounds
        addSubview(contentView)
        
        contentView.forceConstraintToSuperView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.registerCellByNib(MenuItemTableViewCell.self)
    }
    
    func addShadow() {
        contentView.layer.shadowRadius = 5
        contentView.layer.shadowOffset = CGSize(width: 0, height: 5)
        contentView.layer.shadowOpacity = 0.1
        contentView.layer.shadowColor = UIColor.black.cgColor
        contentView.layer.shadowPath = UIBezierPath(rect: bounds).cgPath
        contentView.layer.cornerRadius = 5
        tableView.layer.cornerRadius = 5
    }
}

extension MenuView: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return menuItem.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueCell(MenuItemTableViewCell.self, forIndexPath: indexPath) else {
            return UITableViewCell()
        }
        cell.iconImageView.image = menuItem[indexPath.row].icon
        cell.titleLabel.text = menuItem[indexPath.row].title
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 40
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch menuItem[indexPath.row].type {
        case .logout:
            delegate?.logout()
        case .edit:
            delegate?.editProfile()
        default:
            break
        }
    }
}
