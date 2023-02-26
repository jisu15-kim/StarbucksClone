//
//  CartCell.swift
//  StarbucksClone
//
//  Created by 김지수 on 2022/12/01.
//

import UIKit

class CartCell: UITableViewCell {
    
    @IBOutlet weak var mainImage: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var engTitleLabel: UILabel!
    @IBOutlet weak var isIced: UILabel!
    @IBOutlet weak var cupSize: UILabel!
    @IBOutlet weak var cupType: UILabel!
    

    @IBOutlet weak var minusButton: UIButton!
    @IBOutlet weak var plusButton: UIButton!
    
    @IBOutlet weak var itemCount: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var totalPriceLabel: UILabel!
    
    var cellIndex: Int?
    var item: ProductForOrder?
    weak var delegate: CartProductCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configure() {
        guard let item = item else { return }
        mainImage.image = UIImage(named: item.product.imageName)
        titleLabel.text = item.product.name
        engTitleLabel.text = item.product.englishName
        
        cupSize.text = item.size.rawValue
        cupType.text = item.cup.rawValue
        isIced.text = item.isIced == true ? "아이스" : "핫"
        
        itemCount.text = "\(item.count)"
        priceLabel.text = priceToDecimal(price: item.product.price)
        totalPriceLabel.text = priceToDecimal(price: item.count * item.product.price)
        
        setupUI()
        
        // 카운트에 따라 비활성화
        setButtonByCount(count: item.count)
    }
    
    private func setButtonByCount(count: Int) {
        if count == 1 {
            minusButton.isEnabled = false
        } else if count == 5 {
            plusButton.isEnabled = false
        } else {
            minusButton.isEnabled = true
            plusButton.isEnabled = true
        }
    }
    
    private func setupUI() {
        mainImage.layer.cornerRadius = mainImage.bounds.width / 2
        mainImage.clipsToBounds = true
        mainImage.layer.masksToBounds = true
    }
    
    private func priceToDecimal(price: Int) -> String {
        let formatter = NumberFormatter()
        let price = price as NSNumber
        formatter.numberStyle = .decimal
        let result = formatter.string(from: price)
        return result ?? ""
    }
    
    @IBAction func plusButtonTapped(_ sender: UIButton) {
        self.delegate?.addProductCount(index: cellIndex!)
    }
    

    @IBAction func minusButtonTapped(_ sender: UIButton) {
        self.delegate?.minusProductCount(index: cellIndex!)
    }
}
