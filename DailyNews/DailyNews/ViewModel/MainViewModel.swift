//
//  MainViewModel.swift
//  DailyNews
//
//  Created by Şevval Alev on 10.05.2023.
//

import Foundation
import UIKit

class MainViewModel {
    
    var isLoading: Observable<Bool> = Observable(false)
    var isDataLoaded: Observable<Bool> = Observable(false)
    var newsDataSource: NewsModel?
    var coinDataSource: CoinModel?
    var selectedTab: Category? = .general
    var businessDataSource: NewsModel?
        
    private var dispatchGroup = DispatchGroup()
    
    func numberOfSections() -> Int {
        return 3
    }
    
    func numberOfRows(in section: Int) -> Int {
        if section == 2 {
            return newsDataSource?.news.count ?? 0
        } else {
            return 1
        }
    }
    
    func heightForRowAt(indexPath: IndexPath) -> Int {
        if indexPath.section == 0 {
            return 60
        } else if indexPath.section == 1 {
            return 60
        }else if indexPath.section == 2{
            return 230
        }
        return 200
    }
    
    func loadNewsData(for category: Category) {
        self.selectedTab = category
        CategoryCellViewModel.getDataByCategory(category: category) { [weak self] result in
            switch result {
            case .success(let newsData):
                self?.newsDataSource = newsData
                self?.isDataLoaded.value = true
            case .failure(let error):
                print("Error loading news data: \(error)")
                self?.isDataLoaded.value = false
            }
        }
    }
    
    
    func loadInitialData() {
        dispatchGroup.enter()
        getAllData { result in
            switch result {
            case .success(let success):
                self.newsDataSource = success
            case .failure(let error):
                print("ERR: While fetching all news -> \(error.localizedDescription)")
            }
            self.dispatchGroup.leave()
        }
        
        dispatchGroup.enter()
        getAllCoin { result in
            switch result {
            case .success(let success):
                self.coinDataSource = success
            case .failure(let error):
                print("ERR: While fetching all coins -> \(error.localizedDescription)")
            }
            self.dispatchGroup.leave()
        }
        
        
        dispatchGroup.notify(queue: .main) { [weak self] in
            self?.isDataLoaded.value = true
        }
        
    }
}


// MARK: - LOAD DATA
private
extension MainViewModel {
    func getAllData(completion: @escaping(Result<NewsModel, Error>)->Void) {
        APICaller.getAllNews { result in
            switch result {
            case .success(let data):
                completion(.success(data))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func getAllCoin(completion: @escaping(Result<CoinModel, Error>)->Void) {
        APICaller.getCoinData { result in
            switch result {
            case .success(let data):
                completion(.success(data))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
     
}
