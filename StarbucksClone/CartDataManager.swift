//
//  CartDataManager.swift
//  StarbucksClone
//
//  Created by 김지수 on 2022/12/01.
//

import UIKit

class CartDataManager {
    
    // 싱글톤 객체 생성
    public static var shared = CartDataManager()
    
    private init() {}
    
    private var cartData: [ProductForOrder] = []
    
    public func getCartData() -> [ProductForOrder] {
        return cartData
    }
    
    public func getCartCount() -> Int {
        var count = 0
        cartData.forEach { data in
            count += data.count
        }
        return count
    }
    
    public func addItemToCart(item: ProductForOrder) {
        self.cartData.append(item)
    }
    
    public func changeCount(index: Int, value: Int) {
        self.cartData[index].count += value
    }
    
    public func orderFinish() {
        // 주문 데이터 서버로 전송 ?
        self.cartData = []
    }
}
