//
//  DetailCell.swift
//  StarbucksClone
//
//  Created by 김지수 on 2022/11/29.
//

import UIKit

class DetailCell: UICollectionViewCell {
    
    var item: Starbucks?
    
    @IBOutlet weak var itemTitleLabel: UILabel!
    @IBOutlet weak var itemEngTitleLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var itemImage: UIImageView!
    
    func setupCell() {
        guard let safeItem = item else { return }
        
        itemImage.image = UIImage(named: safeItem.imageName)
        itemImage.contentMode = .scaleAspectFill
        itemImage.layoutIfNeeded()
        itemImage.layer.cornerRadius = itemImage.frame.width / 2
        itemImage.clipsToBounds = true
        
        itemTitleLabel.text = safeItem.name
        itemEngTitleLabel.text = safeItem.englishName
        priceLabel.text = "\(priceToDecimal(price: safeItem.price))원"
    }
    
    func priceToDecimal(price: Int) -> String {
        let formatter = NumberFormatter()
        let price = price as NSNumber
        formatter.numberStyle = .decimal
        let result = formatter.string(from: price)
        return result ?? ""
    }
}
