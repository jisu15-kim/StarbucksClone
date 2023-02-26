//
//  ProductViewController.swift
//  StarbucksClone
//
//  Created by 김지수 on 2022/11/29.
//

import UIKit

class ProductViewController: UIViewController {
    
    var product: Starbucks?
    
    @IBOutlet weak var productImage: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var engTitleLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var orderButton: UIButton!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchData()
        setupUI()
    }
    
    func fetchData() {
        guard let product = self.product else { return }
        self.productImage.image = UIImage(named: product.imageName)
        self.titleLabel.text = product.name
        self.descriptionLabel.text = product.desciption
        self.engTitleLabel.text = product.englishName
        self.priceLabel.text = "\(priceToDecimal(price: product.price))원"
        self.navigationItem.title = "\(product.name)"
        self.navigationItem.largeTitleDisplayMode = .never
    }
    
    func setupUI() {
        orderButton.layer.cornerRadius = 20
        orderButton.clipsToBounds = true
    }
    
    func priceToDecimal(price: Int) -> String {
        let formatter = NumberFormatter()
        let price = price as NSNumber
        formatter.numberStyle = .decimal
        let result = formatter.string(from: price)
        return result ?? ""
    }
    
    @IBAction func orderButtonTapped(_ sender: UIButton) {
        
        guard let vc = self.storyboard?.instantiateViewController(withIdentifier: "DetailProductViewController") as? DetailProductViewController else { return }
        vc.selectedItem = product
        vc.delegate = self
        vc.modalPresentationStyle = .formSheet
        vc.modalTransitionStyle = .coverVertical
        present(vc, animated: true)
    }
}

extension ProductViewController: CartActionDelegate {
    func pushToCartVC() {
        print(#function)
        guard let vc = self.storyboard?.instantiateViewController(withIdentifier: "CartViewController") as? CartViewController else { return }
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func popToRoot() {
        print(#function)
        self.navigationController?.popToRootViewController(animated: true)
    }
}
