//
//  CartViewController.swift
//  StarbucksClone
//
//  Created by 김지수 on 2022/12/01.
//

import UIKit

class CartViewController: UIViewController {
    
    var cartData: [ProductForOrder] = []
    @IBOutlet weak var cartTableView: UITableView!
    @IBOutlet weak var productCount: UILabel!
    @IBOutlet weak var totalPrice: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupData()
        setupUI()
        
    }
    
    private func setupData() {
        self.navigationItem.title = "장바구니"
        self.navigationItem.largeTitleDisplayMode = .always
        self.cartData = CartDataManager.shared.getCartData()
    }
    
    private func setupUI() {
        cartTableView.delegate = self
        cartTableView.dataSource = self
        cartTableView.rowHeight = self.cartTableView.bounds.width * 0.5
        cartTableView.allowsSelection = false
        productCount.text = getProductCount()
        totalPrice.text = getTotalPrice()
    }
    
    // 리로드 !!
    private func reLoad() {
        self.cartData = CartDataManager.shared.getCartData()
        self.cartTableView.reloadData()
        self.productCount.text = getProductCount()
        self.totalPrice.text = getTotalPrice()
    }
    
    // 총 합계수량 계산
    private func getProductCount() -> String {
        var count = 0
        cartData.forEach { data in
            count += data.count
        }
        return String(count)
    }
    
    // 총 합계금액 계산
    private func getTotalPrice() -> String {
        var total = 0
        self.cartData.forEach { data in
            total += data.product.price * data.count
        }
        return priceToDecimal(price: total)
    }
    
    private func priceToDecimal(price: Int) -> String {
        let formatter = NumberFormatter()
        let price = price as NSNumber
        formatter.numberStyle = .decimal
        let result = formatter.string(from: price)
        return result ?? ""
    }
    
    @IBAction func orderButtonTapped(_ sender: UIButton) {
        let alert = UIAlertController(title: "주문완료", message: "해당 지점에서 음료를 수령해주세요", preferredStyle: UIAlertController.Style.alert)
        let okAction = UIAlertAction(title: "OK", style: .default) { action in
            CartDataManager.shared.orderFinish()
            self.navigationController?.popToRootViewController(animated: true)
        }
        alert.addAction(okAction)
        present(alert, animated: false, completion: nil)
    }
}

extension CartViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        self.cartData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = cartTableView.dequeueReusableCell(withIdentifier: "CartCell", for: indexPath) as? CartCell else { return UITableViewCell() }
        cell.item = cartData[indexPath.row]
        cell.cellIndex = indexPath.row
        cell.delegate = self
        cell.configure()
        return cell
    }
}

extension CartViewController: CartProductCellDelegate {
    func addProductCount(index: Int) {
        CartDataManager.shared.changeCount(index: index, value: 1)
        reLoad()
    }
    
    func minusProductCount(index: Int) {
        CartDataManager.shared.changeCount(index: index, value: -1)
        reLoad()
    }
}
