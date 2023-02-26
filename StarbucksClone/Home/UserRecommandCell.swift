//
//  UserRecommandCell.swift
//  StarbucksClone
//
//  Created by 김지수 on 2022/11/28.
//

import UIKit

class UserRecommandCell: UICollectionViewCell {
    
    var item: Starbucks?
    
    let mainImage: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    let itemLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 14, weight: .regular)
        label.lineBreakMode = .byCharWrapping
        label.numberOfLines = 0
        label.adjustsFontForContentSizeCategory = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    public func setupCell() {
        guard let safeItem = item else { return }
        setupLayout()
        
        mainImage.image = UIImage(named: safeItem.imageName)
        itemLabel.text = safeItem.name
    }
    
    private func setupLayout() {
        
        self.addSubview(mainImage)
        self.addSubview(itemLabel)
        
        NSLayoutConstraint.activate([
            mainImage.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            mainImage.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            mainImage.topAnchor.constraint(equalTo: self.topAnchor),
            mainImage.widthAnchor.constraint(equalTo: mainImage.heightAnchor, multiplier: 1.0),
            
            itemLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            itemLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            itemLabel.topAnchor.constraint(equalTo: mainImage.bottomAnchor, constant: 10),
            itemLabel.heightAnchor.constraint(greaterThanOrEqualToConstant: 10)
        ])
        
        mainImage.layer.cornerRadius = self.bounds.width / 2
        mainImage.clipsToBounds = true
    }
}
