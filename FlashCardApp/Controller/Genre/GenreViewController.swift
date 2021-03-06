//
//  GenreViewController.swift
//  FlashCardApp
//
//  Created by Nguyễn Đức Tân on 04/03/2021.
//  Copyright © 2021 Nguyễn Đức Tân. All rights reserved.
//

import UIKit
import ALProgressRing
import SwipeCellKit

class GenreViewController: BaseViewController {

    @IBOutlet weak var progressView: UIView!
    @IBOutlet weak var collectionView: UICollectionView!
    private lazy var progressRing = ALProgressRing()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setTitleHeader(title: "Genre Title")
        setupProgressView()
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.registerCellByNib(BigFlashcardCollectionViewCell.self)
    }
    
    func setupProgressView() {
        progressView.addSubview(progressRing)
        progressRing.translatesAutoresizingMaskIntoConstraints = false
        progressRing.centerXAnchor.constraint(equalTo: progressView.centerXAnchor).isActive = true
        progressRing.centerYAnchor.constraint(equalTo: progressView.centerYAnchor).isActive = true
        progressRing.widthAnchor.constraint(equalToConstant: progressView.frame.width).isActive = true
        progressRing.heightAnchor.constraint(equalToConstant: progressView.frame.height).isActive = true
        
        progressRing.setProgress(0.8, animated: true)
        progressRing.startColor = UIColor.thirdColor ?? .systemPink
        progressRing.endColor = UIColor.primaryColor ?? .systemRed
        progressRing.ringWidth = 10
        progressRing.grooveWidth = 8
    }
}

extension GenreViewController: UICollectionViewDelegateFlowLayout,
                               UICollectionViewDelegate,
                               UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let reusableCell = collectionView.dequeueCell(BigFlashcardCollectionViewCell.self, forIndexPath: indexPath) else {
            return UICollectionViewCell()
        }
        reusableCell.delegate = self
        reusableCell.actionDelegate = self
        return reusableCell
    }
    
    func preferredLayoutAttributesFitting(_ layoutAttributes: UICollectionViewLayoutAttributes) -> UICollectionViewLayoutAttributes {
        return layoutAttributes
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 25, left: 0, bottom: 0, right: 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = DeviceInfo.width
        let height = width * 150/375
        
        let size = CGSize(width: width, height: height)
        return size
    }
}

extension GenreViewController: SwipeCollectionViewCellDelegate, BigFlashcardDelegate {
    
    func collectionView(_ collectionView: UICollectionView, editActionsForItemAt indexPath: IndexPath, for orientation: SwipeActionsOrientation) -> [SwipeAction]? {
        guard orientation == .right else { return nil }

        let deleteAction = SwipeAction(style: .destructive, title: "Delete") { action, indexPath in
            // handle action by updating model with deletion
        }

        // customize the action appearance
        deleteAction.image = UIImage(named: "delete")

        return [deleteAction]
    }
    
    func collectionView(_ collectionView: UICollectionView, editActionsOptionsForItemAt indexPath: IndexPath, for orientation: SwipeActionsOrientation) -> SwipeOptions {
        var options = SwipeOptions()
        options.expansionStyle = .destructive
        options.transitionStyle = .border
        return options
    }
    
    func seeDetail() {
        let vc = FlashCardOverViewController()
        vc.hidesBottomBarWhenPushed = true
        push(vc)
    }
}


