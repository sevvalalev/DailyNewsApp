//
//  CoinCell.swift
//  DailyNews
//
//  Created by Şevval Alev on 10.05.2023.
//

import UIKit

class CoinCell: UITableViewCell {

    var spacing: CGFloat = 10
    
    @IBOutlet weak var coinCollectionView: UICollectionView!
    
    
    public static var identifier: String {
        get {
            return "CoinCell"
        }
    }
    
    private var viewModel: CoinCellViewModel?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        customNibs()
        setupCollectionView()
    }

    func setupCollectionView() {
        coinCollectionView.delegate = self
        coinCollectionView.dataSource = self
    }
    
    func configure(viewModel: CoinCellViewModel?) {
        self.viewModel = viewModel
        coinCollectionView.reloadData()
    }

    
    func customNibs() {
        let customCellNib: UINib = UINib(nibName: "CoinCollectionViewCell", bundle: nil)
        coinCollectionView.register(customCellNib, forCellWithReuseIdentifier: CoinCollectionViewCell.identifier)
    }
    
}

extension CoinCell: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel?.numberOfItemsInSection() ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = coinCollectionView.dequeueReusableCell(withReuseIdentifier: CoinCollectionViewCell.identifier, for: indexPath) as? CoinCollectionViewCell {
            let data = viewModel?.getItem(for: indexPath.row)
            cell.configureCell(with: data?.0 ?? "", value: data?.1 ?? 0.0)
            return cell
        }
        return UICollectionViewCell()
    }
    
}

extension CoinCell: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
            let numberOfItemsPerRow:CGFloat = 4.2
            let spacingBetweenCells:CGFloat = 10
            let totalSpacing = (2 * self.spacing) + ((numberOfItemsPerRow - 1) * spacingBetweenCells)
            if let collection = self.coinCollectionView{
                let width = (collection.bounds.width - totalSpacing)/numberOfItemsPerRow
                let height = (collectionView.bounds.width - totalSpacing)/1.7
                return CGSize(width: width, height: height)
            }else{
                return CGSize(width: 0, height: 0)
            }
    }
}
