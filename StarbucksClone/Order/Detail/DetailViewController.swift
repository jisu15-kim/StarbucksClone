//
//  DetailViewController.swift
//  StarbucksClone
//
//  Created by 김지수 on 2022/11/29.
//

import UIKit

class DetailViewController: UIViewController {
    
    @IBOutlet weak var cartImageView: UIImageView!
    @IBOutlet weak var cartCountLabel: UILabel!
    @IBOutlet weak var detailCollectionView: UICollectionView!
    var selectedCategory: Category?
    var detailData: [Starbucks] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupData()
        setupCollectionView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        cartCountLabel.text = "\(CartDataManager.shared.getCartCount())"
    }
    
    private func setupData() {
        guard let selected = selectedCategory else { return }
        self.navigationItem.title = selected.rawValue
        
        // 카트 제스쳐 추가
        self.cartImageView.isUserInteractionEnabled = true
        let gesture = UITapGestureRecognizer(target: self, action: #selector(self.cartButtonTapped(_:)))
        self.cartImageView.addGestureRecognizer(gesture)
    }
    
    private func setupCollectionView() {
        if let layout = detailCollectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            layout.scrollDirection = .vertical
            layout.itemSize = CGSize(width: detailCollectionView.bounds.width, height: 120)
        }
        detailCollectionView.delegate = self
        detailCollectionView.dataSource = self
    }
    
    // 카트 그림 눌렸을 때
    @objc func cartButtonTapped(_ sender: UITapGestureRecognizer) {
        guard let vc = self.storyboard?.instantiateViewController(withIdentifier: "CartViewController") as? CartViewController else { return }
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

extension DetailViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return detailData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = detailCollectionView.dequeueReusableCell(withReuseIdentifier: "DetailCell", for: indexPath) as? DetailCell else { return UICollectionViewCell() }
        cell.item = detailData[indexPath.row]
        cell.setupCell()
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let vc = self.storyboard?.instantiateViewController(withIdentifier: "ProductViewController") as? ProductViewController else { return }
//        self.present(vc, animated: true)
        vc.product = detailData[indexPath.row]
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
