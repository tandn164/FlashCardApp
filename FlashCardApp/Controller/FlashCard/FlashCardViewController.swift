//
//  FlashCardViewController.swift
//  FlashCardApp
//
//  Created by Nguyễn Đức Tân on 06/03/2021.
//  Copyright © 2021 Nguyễn Đức Tân. All rights reserved.
//

import UIKit

class FlashCardViewController: UIViewController {

    var listCard: [String:CardView] = [:]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        generateCard()
        
    }
    
    @objc func draggedView(_ sender:UIPanGestureRecognizer){
        let translation = sender.translation(in: self.view)
        guard let card = listCard[sender.name ?? ""] else {
            return
        }
        if (sender.state == UIGestureRecognizer.State.ended) {
            if card.center.x + translation.x > DeviceInfo.width * 3/4 || card.center.x + translation.x < DeviceInfo.width / 4 {
                card.isHidden = true
            }
            card.center =  CGPoint(x: view.center.x,
                                   y: view.center.y)
            card.setTransformRotation(toDegrees: -card.rolate)
            card.rolate = 0
            
        } else {
            card.center = CGPoint(x: card.center.x + translation.x,
                                  y: card.center.y + translation.y)
            card.rolate += translation.x/4
            card.setTransformRotation(toDegrees: translation.x/4)
        }
        
        let blurAlpha = 1 - (abs(card.center.x - DeviceInfo.width/2) / (DeviceInfo.width/2) * 2)
        card.updateStatus(card.center.x > DeviceInfo.width/2)
        card.blurView.backgroundColor = UIColor.white.withAlphaComponent(blurAlpha)
        sender.setTranslation(CGPoint.zero, in: self.view)
    }
    
    @IBAction func closeAction(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    func generateCard() {
        for index in 0..<5 {
            let word = "\(index)"
            listCard[word] = createCart(word: word)
        }
    }
    
    func regenerateCard() {
        
    }
    
    func updateLearnedWord(word: String) {
        
    }
    
    @IBAction func resetAction(_ sender: UIButton) {
    }
    
    func createCart(word: String) -> CardView {
        let newCard = CardView()
        newCard.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(newCard)
        view.bringSubviewToFront(newCard)
        newCard.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.8).isActive = true
        newCard.heightAnchor.constraint(equalTo: newCard.widthAnchor, multiplier: 230/165).isActive = true
        newCard.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        newCard.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        newCard.backgroundColor = .white
        let panGesture = UIPanGestureRecognizer(target: self,
                                                action: #selector(draggedView(_:)))
        newCard.isUserInteractionEnabled = true
        newCard.addGestureRecognizer(panGesture)
        newCard.isHidden = false
        newCard.wordLabel.text = word
        newCard.word = word
        newCard.setTransformRotation(toDegrees: CGFloat(Int.random(in: -3..<3)))
        panGesture.name = word
        
        return newCard
    }
}
