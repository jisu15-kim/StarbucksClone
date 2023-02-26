//
//  StarbucksModel.swift
//  StarbucksClone
//
//  Created by 김지수 on 2022/11/28.
//

import UIKit

enum Menu {
    case drink
    case food
    case goods
}

enum Category: String, CaseIterable {
    case ColdBrew
    case Espresso
    case Frappuccino
    case Blended
    case Refresher
    case Fizzio
    case Teavana
    case Error
}

enum CupType: String, CaseIterable {
    case reusable
    case personal
    case disposable
}

enum CupSize: String, CaseIterable {
    case short
    case tall
    case grande
    case venti
}

struct Starbucks {
    let id: Int
    let menu: Menu
    let category: Category
    let name: String
    let englishName: String
    let desciption: String
    let price: Int
    let imageName: String
    let isBrandNew: Bool
    let isLimited: Bool
    let isRecommand: Bool
}

struct ProductForOrder {
    let product: Starbucks
    let cup: CupType
    let size: CupSize
    var count: Int
    let isIced: Bool
}
