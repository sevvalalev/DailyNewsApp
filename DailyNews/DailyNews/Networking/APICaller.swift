//
//  APICaller.swift
//  DailyNews
//
//  Created by Şevval Alev on 11.05.2023.
//

import Foundation

enum NetworkError: Error {
    case urlError
    case canNotParseData
}

class APICaller {
    
    static func getAllNews(completionHandler: @escaping (_ result: Result<NewsModel,NetworkError>) -> Void ) {
        let urlString = NetworkConstant.shared.allNewsAddress
        
        guard let url = URL(string: urlString) else {
            completionHandler(.failure(.urlError))
            return
        }
        
        URLSession.shared.dataTask(with: url) { dataResponse, urlResponse, error in
            if error == nil,
               let data = dataResponse,
               let resultData = try? JSONDecoder().decode(NewsModel.self, from: data) {
                completionHandler(.success(resultData))
            } else {
                completionHandler(.failure(.canNotParseData))
            }
        }.resume()
        
    }
    
    static func getCoinData(completionHandler: @escaping (_ result: Result<CoinModel,NetworkError>) -> Void ) {
        let urlString = NetworkConstant.shared.coinApi
        
        guard let url = URL(string: urlString) else {
            completionHandler(.failure(.urlError))
            return
        }
        
        URLSession.shared.dataTask(with: url) { dataResponse, urlResponse, error in
            if error == nil,
               let data = dataResponse,
               let resultData = try? JSONDecoder().decode(CoinModel.self, from: data) {
                completionHandler(.success(resultData))
            } else {
                completionHandler(.failure(.canNotParseData))
            }
        }.resume()
        
    }
    
}
