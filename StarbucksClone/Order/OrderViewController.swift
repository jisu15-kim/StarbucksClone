//
//  OrderViewController.swift
//  StarbucksClone
//
//  Created by 김지수 on 2022/11/28.
//

import UIKit

class OrderViewController: UIViewController {
    
    @IBOutlet weak var cartCountLabel: UILabel!
    @IBOutlet weak var menuCollectionView: UICollectionView!
    @IBOutlet weak var cartImageView: UIImageView!
    
    let dataManager = DataManager.shard
    var starbucksModels: [Starbucks] = []

    var filterdData: [Category:[Starbucks]] = [
        .ColdBrew:[],
        .Blended:[],
        .Espresso:[],
        .Fizzio:[],
        .Frappuccino:[],
        .Refresher:[],
        .Teavana:[],
    ]
    
    var categoryData: [Starbucks] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupDatas()
        setupCollectionView()
        navigationItem.largeTitleDisplayMode = .automatic
        
        // 카트 제스쳐 추가
        self.cartImageView.isUserInteractionEnabled = true
        let gesture = UITapGestureRecognizer(target: self, action: #selector(self.cartButtonTapped(_:)))
        self.cartImageView.addGestureRecognizer(gesture)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        cartCountLabel.text = "\(CartDataManager.shared.getCartCount())"
    }
    
    private func setupDatas() {
        starbucksModels = dataManager.getModelDatas()
        
        var coldBrew: [Starbucks] = []
        var blended: [Starbucks] = []
        var espresso: [Starbucks] = []
        var fizzio: [Starbucks] = []
        var frappuccino: [Starbucks] = []
        var refresher: [Starbucks] = []
        var teavana: [Starbucks] = []
        var error: [Starbucks] = []
        
        starbucksModels.forEach { item in
            switch item.category {
            case .ColdBrew:
                coldBrew.append(item)
            case .Blended:
                blended.append(item)
            case .Espresso:
                espresso.append(item)
            case .Fizzio:
                fizzio.append(item)
            case .Frappuccino:
                frappuccino.append(item)
            case .Refresher:
                refresher.append(item)
            case .Teavana:
                teavana.append(item)
            default:
                error.append(item)
            }
        }
        
        filterdData.updateValue(coldBrew, forKey: .ColdBrew)
        filterdData.updateValue(blended, forKey: .Blended)
        filterdData.updateValue(espresso, forKey: .Espresso)
        filterdData.updateValue(fizzio, forKey: .Fizzio)
        filterdData.updateValue(frappuccino, forKey: .Frappuccino)
        filterdData.updateValue(refresher, forKey: .Refresher)
        filterdData.updateValue(teavana, forKey: .Teavana)
        
        categoryData.append(filterdData[.Blended]![0])
        categoryData.append(filterdData[.Espresso]![0])
        categoryData.append(filterdData[.Fizzio]![0])
        categoryData.append(filterdData[.Frappuccino]![0])
        categoryData.append(filterdData[.Refresher]![0])
        categoryData.append(filterdData[.Teavana]![0])
        categoryData.append(filterdData[.ColdBrew]![0])
    }
    
    private func setupCollectionView() {
        if let layout = menuCollectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            layout.scrollDirection = .vertical
            layout.itemSize = CGSize(width: menuCollectionView.bounds.width, height: 100)
        }
        menuCollectionView.delegate = self
        menuCollectionView.dataSource = self
    }
    
    // 카트 그림 눌렸을 때
    @objc func cartButtonTapped(_ sender: UITapGestureRecognizer) {
        guard let vc = self.storyboard?.instantiateViewController(withIdentifier: "CartViewController") as? CartViewController else { return }
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

extension OrderViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return filterdData.keys.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = menuCollectionView.dequeueReusableCell(withReuseIdentifier: "MenuCell", for: indexPath) as? MenuCell else { return UICollectionViewCell() }
        cell.item = categoryData[indexPath.row]
        cell.setupCell()
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let selectedCategory = self.categoryData[indexPath.row].category
        guard let vc = storyboard?.instantiateViewController(withIdentifier: "DetailViewController") as? DetailViewController else { return }
        vc.selectedCategory = selectedCategory
        vc.detailData = self.starbucksModels.filter({ data in
            data.category == selectedCategory
        })
        navigationController?.pushViewController(vc, animated: true)
    }
}
