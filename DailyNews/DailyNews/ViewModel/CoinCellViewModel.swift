//
//  CoinCellViewModel.swift
//  DailyNews
//
//  Created by Şevval Alev on 11.05.2023.
//

import Foundation
import UIKit

class CoinCellViewModel {
    
    private var coinData: CoinModel
    private var coinArray: [String: Double] = [:]
    private let selectedKeys = ["BTC", "ADA", "ALT", "ANT", "BCD", "BTC"]
    
    init(coinData: CoinModel) {
        self.coinData = coinData
        filterCoinData()
    }
    
    func numberOfItemsInSection() -> Int{
        return coinArray.count ?? 0
    }
    
    func getItem(for index: Int) -> (String, Double) {
        return (selectedKeys[index], coinArray[selectedKeys[index]] ?? 0.0)
    }
    
    private func filterCoinData() {
        selectedKeys.forEach { key in
            self.coinArray[key] = coinData.rates?[key]
        }
    }
}
