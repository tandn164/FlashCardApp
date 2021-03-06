//
//  FlashCardViewController.swift
//  FlashCardApp
//
//  Created by Nguyễn Đức Tân on 04/03/2021.
//  Copyright © 2021 Nguyễn Đức Tân. All rights reserved.
//

import UIKit

class FlashCardOverViewController: BaseViewController {

    @IBOutlet weak var tableView: UITableView!
    var cellHeight: [CGFloat] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.registerCellByNib(FlashCardOverViewTableViewCell.self)
        tableView.delegate = self
        tableView.dataSource = self
    }
    @IBAction func startAction(_ sender: UIButton) {
        let vc = FlashCardViewController()
        vc.modalPresentationStyle = .fullScreen
        vc.modalTransitionStyle = .crossDissolve
        present(vc, animated: true, completion: nil)
    }
}  

extension FlashCardOverViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueCell(FlashCardOverViewTableViewCell.self, forIndexPath: indexPath) else {
            return UITableViewCell()
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}
