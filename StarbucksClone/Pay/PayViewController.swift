//
//  PayViewController.swift
//  StarbucksClone
//
//  Created by 김지수 on 2022/11/28.
//

import UIKit

class PayViewController: UIViewController {

    @IBOutlet weak var cardImage: UIImageView!
    @IBOutlet weak var cardSectionView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
    }
    
    private func setupUI() {
        cardImage.layer.cornerRadius = 20
        cardImage.clipsToBounds = true
        cardImage.layer.borderWidth = 1
        cardImage.layer.borderColor = UIColor.lightGray.cgColor
        
        cardSectionView.layer.masksToBounds = false
        cardSectionView.layer.shadowColor = UIColor.black.cgColor
        cardSectionView.layer.shadowRadius = 2
        cardSectionView.layer.shadowOffset = CGSize(width: 0, height: 10)
        cardSectionView.layer.shadowOpacity = 0.1
        cardSectionView.layer.shadowRadius = 4.0
    }
}
