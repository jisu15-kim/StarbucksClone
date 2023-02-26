//
//  DetailProductViewController.swift
//  StarbucksClone
//
//  Created by 김지수 on 2022/11/29.
//

import UIKit

class DetailProductViewController: UIViewController {
    
    var selectedItem: Starbucks?
    weak var delegate: CartActionDelegate?
    
    var isLike: Bool = false {
        didSet {
            if isLike == true {
                heartButton.setImage(UIImage(systemName: "heart.fill"), for: .normal)
                heartButton.tintColor = #colorLiteral(red: 0, green: 0.6649811864, blue: 0.3861718774, alpha: 1)
            } else {
                heartButton.setImage(UIImage(systemName: "heart"), for: .normal)
                heartButton.tintColor = .darkGray
            }
        }
    }
    
    var productCount: Int = 1 {
        didSet {
            if productCount == 1 {
                minusCountButton.isEnabled = false
            } else if productCount == 5 {
                plusCountButton.isEnabled = false
            } else {
                minusCountButton.isEnabled = true
                plusCountButton.isEnabled = true
            }
            countChanged()
        }
    }
    
    // 내용
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var noticeLabel: UILabel!
    @IBOutlet weak var cupTypeSelector: UISegmentedControl!
    
    // 하단
    @IBOutlet weak var footerSection: UIView!
    @IBOutlet weak var totalPriceLabel: UILabel!
    @IBOutlet weak var countLabel: UILabel!
    
    // 버튼 모음
    @IBOutlet weak var orderButton: UIButton!
    @IBOutlet weak var cartButton: UIButton!
    @IBOutlet weak var minusCountButton: UIButton!
    @IBOutlet weak var plusCountButton: UIButton!
    @IBOutlet weak var heartButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
    }
    
    func setupUI() {
        
        guard let item = selectedItem else { return }
        titleLabel.text = item.name
        noticeLabel.text = "환경을 위해 일회용컵 사용 줄이기에 동참해 주세요"
        setupButtonUI()
        countChanged()
        addShadow(view: footerSection)
    }
    
    private func countChanged() {
        if let item = selectedItem {
            let total = item.price * productCount
            totalPriceLabel.text = "\(priceToDecimal(price: total))"
            countLabel.text = "\(productCount)"
        }
    }
    
    private func setupButtonUI() {
        minusCountButton.isEnabled = false
        buttonToCapsule(button: self.orderButton)
        buttonToCapsule(button: self.cartButton)
        cartButton.layer.borderWidth = 1
        cartButton.layer.borderColor = #colorLiteral(red: 0, green: 0.6649811864, blue: 0.3861718774, alpha: 1)
    }
    
    private func buttonToCapsule(button: UIButton) {
        button.layer.cornerRadius = 20
        button.clipsToBounds = true
    }
    
    private func addShadow(view: UIView) {
        view.layer.cornerRadius = 7
        view.clipsToBounds = true
        view.layer.masksToBounds = false
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowRadius = 2
        view.layer.shadowOffset = CGSize(width: 1, height: -10)
        view.layer.shadowOpacity = 0.03
        view.layer.shadowRadius = 5.0
    }
    
    private func priceToDecimal(price: Int) -> String {
        let formatter = NumberFormatter()
        let price = price as NSNumber
        formatter.numberStyle = .decimal
        let result = formatter.string(from: price)
        return result ?? ""
    }
    
    @IBAction func countUpButtonTapped(_ sender: UIButton) {
        productCount += 1
    }
    
    @IBAction func countDownButtonTapped(_ sender: UIButton) {
        productCount -= 1
    }
    
    @IBAction func likeButtonTapped(_ sender: UIButton) {
        self.isLike.toggle()
    }
    //MARK: -다음 액션
    
    @IBAction func cartButtonTapped(_ sender: UIButton) {
        // 장바구니에 넣기
        let product = initOrderProduct()
        CartDataManager.shared.addItemToCart(item: product)
        
        // Alert 창 표시
        let alert = UIAlertController(title: "장바구니에 추가되었습니다", message: "", preferredStyle: .actionSheet)
        let cart = UIAlertAction(title: "장바구니 가기", style: .default) { action in
            self.dismiss(animated: true) {
                self.delegate?.pushToCartVC()
            }
        }
        
        let viewMore = UIAlertAction(title: "다른 메뉴 더보기", style: .default) { action in
            self.dismiss(animated: true) {
                self.delegate?.popToRoot()
            }
        }
        
        alert.addAction(cart)
        alert.addAction(viewMore)
        present(alert, animated: true)
    }
    
    @IBAction func orderButtonTapped(_ sender: UIButton) {
        // 단품 주문 페이지로
        
    }
    
    private func initOrderProduct() -> ProductForOrder {
        var cupType: CupType
        
        switch cupTypeSelector.selectedSegmentIndex {
        case 0:
            cupType = .reusable
        case 1:
            cupType = .personal
        case 2:
            cupType = .disposable
        default:
            cupType = .disposable
        }
        
        let product = ProductForOrder(product: self.selectedItem!, cup: cupType, size: .tall, count: self.productCount, isIced: true)
        return product
    }
}
