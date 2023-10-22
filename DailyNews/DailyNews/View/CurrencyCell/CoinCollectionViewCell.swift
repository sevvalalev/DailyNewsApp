//
//  CoinCollectionViewCell.swift
//  DailyNews
//
//  Created by Şevval Alev on 10.05.2023.
//

import UIKit

class CoinCollectionViewCell: UICollectionViewCell {

    public static var identifier: String {
        get {
            return "CoinCollectionViewCell"
        }
    }

    // MARK: IBOutlets
    @IBOutlet weak var coinNameLabel: UILabel!
    @IBOutlet weak var coinRateLabel: UILabel!
    @IBOutlet weak var coinView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        coinView.layer.cornerRadius = 10
        coinNameLabel.setSameFont(fontSize: 16)
        coinRateLabel.setSameFont(fontSize: 16)
    }
    
    func configureCell(with coinName: String, value: Double) {
       
        coinNameLabel.text = coinName
        coinRateLabel.text = "\(value)"
        
        
    }

}
