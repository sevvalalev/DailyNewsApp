//
//  CoinModel.swift
//  DailyNews
//
//  Created by Şevval Alev on 18.05.2023.
//

import Foundation

struct CoinModel: Codable {
    let success: Bool?
    let terms, privacy: String?
    let timestamp: Int?
    let target: String?
    let rates: [String: Double]?
}
