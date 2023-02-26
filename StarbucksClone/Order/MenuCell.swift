//
//  MenuCell.swift
//  StarbucksClone
//
//  Created by 김지수 on 2022/11/28.
//

import UIKit

class MenuCell: UICollectionViewCell {
    var item: Starbucks?

    @IBOutlet weak var itemImage: UIImageView!
    @IBOutlet weak var itemTitleLabel: UILabel!
    @IBOutlet weak var itemEngTitleLabel: UILabel!
    
    func setupCell() {
        guard let safeItem = item else { return }

        itemImage.image = UIImage(named: safeItem.imageName)
        itemImage.contentMode = .scaleAspectFill
        itemImage.layoutIfNeeded()
        itemImage.layer.cornerRadius = itemImage.frame.width / 2
        itemImage.clipsToBounds = true
        
        // 카테고리별로 분기
        switch safeItem.category {
        case .ColdBrew:
            itemTitleLabel.text = "콜드 브루"
            itemEngTitleLabel.text = "Cold Brew"
        case .Teavana:
            itemTitleLabel.text = "티바나"
            itemEngTitleLabel.text = "Teavana"
        case .Refresher:
            itemTitleLabel.text = "리프레서"
            itemEngTitleLabel.text = "Starbucks Refreshers"
        case .Frappuccino:
            itemTitleLabel.text = "프라푸치노"
            itemEngTitleLabel.text = "Frappuccino"
        case .Fizzio:
            itemTitleLabel.text = "피지오"
            itemEngTitleLabel.text = "Starbucks Fizzio"
        case .Espresso:
            itemTitleLabel.text = "에스프레소"
            itemEngTitleLabel.text = "Espresso"
        case .Blended:
            itemTitleLabel.text = "블렌디드"
            itemEngTitleLabel.text = "Blended"
        default:
            return
        }
    }
}
