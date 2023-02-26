//
//  CustomDelegate.swift
//  StarbucksClone
//
//  Created by 김지수 on 2022/12/01.
//

import Foundation

protocol CartActionDelegate: AnyObject {
    func pushToCartVC()
    func popToRoot()
}

protocol CartProductCellDelegate: AnyObject {
    func addProductCount(index: Int)
    func minusProductCount(index: Int)
}
