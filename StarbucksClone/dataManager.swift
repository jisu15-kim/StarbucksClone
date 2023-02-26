//
//  dataManager.swift
//  StarbucksClone
//
//  Created by 김지수 on 2022/11/28.
//

import UIKit

class DataManager {
    
    static let shard = DataManager()
    
    private init() {}
    
    private var starbucksModels: [Starbucks] = []
    public func getModelDatas() -> [Starbucks] {
        return starbucksModels
    }
    
    public func loadLocationsFromCSV(fileName: String) {
        let path = Bundle.main.path(forResource: fileName, ofType: "csv")!
        parseCSVAt(url: URL(fileURLWithPath: path))
    }
    
    private func parseCSVAt(url:URL) {
        do {
            let data = try Data(contentsOf: url)
            let dataEncoded = String(data: data, encoding: .utf8)
            
            if let dataArr = dataEncoded?.components(separatedBy: "\n").map({$0.components(separatedBy: ",")}) {
                for item in dataArr {
                    guard let model = itemToStarbucks(item: item) else { break }
                    self.starbucksModels.append(model)
                }
            }
        } catch  {
            print("Error reading CSV file")
        }
    }
    
    private func itemToStarbucks(item: [String]) -> Starbucks? {
        if item.count < 2 { return nil }
        let id = Int(item[0])
        let menu = menuToEnum(data: item[1])
        let category = categoryToEnum(data: item[2])
        let name = item[3]
        let enName = item[4]
        let description = item[5]
        let price = Int(item[6])
        let imageName = item[7]
        let new = boolCheck(data: item[8])
        let limit = boolCheck(data: item[9])
        let rec = boolCheck(data: item[10])
        let model = Starbucks(id: id!, menu: menu, category: category, name: name, englishName: enName, desciption: description, price: price!, imageName: imageName, isBrandNew: new, isLimited: limit, isRecommand: rec)
        return model
    }
    
    private func menuToEnum(data: String?) -> Menu {
        switch data {
        case "Drink":
            return Menu.drink
        case "Food":
            return Menu.food
        case "Goods":
            return Menu.goods
        default:
            return Menu.food
        }
    }
    
    private func categoryToEnum(data: String) -> Category {
        switch data {
        case "ColdBrew":
            return .ColdBrew
        case "Espresso":
            return .Espresso
        case "Frappuccino":
            return .Frappuccino
        case "Blended":
            return .Blended
        case "Refresher":
            return .Refresher
        case "Fizzio":
            return .Fizzio
        case "Teavana":
            return .Teavana
        default :
            return .Error
        }
    }
    
    private func boolCheck(data: String) -> Bool {
        if data.contains("TRUE") == true {
            return true
        } else if data.contains("FALSE") == true {
            return false
        } else {
            return false
        }
    }
}
