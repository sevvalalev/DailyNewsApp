//
//  CategoryCellViewModel.swift
//  DailyNews
//
//  Created by Şevval Alev on 11.05.2023.
//

import Foundation

enum Category: CaseIterable {
    case general
    case business
    case entertainment
    case health
    case science
    case sports
    case technology
    
    var name: String {
        switch self {
        case .general:
            return "General"
        case .business:
            return "Business"
        case .entertainment:
            return "Entertainment"
        case .health:
            return "Health"
        case .science:
            return "Science"
        case .sports:
            return "Sports"
        case .technology:
            return "Technology"
        }
    }
}

class CategoryCellViewModel {
    
    var categories: [Category] = Category.allCases
    
    func getItem(for indexPath: IndexPath) -> Category {
        return categories[indexPath.row]
    }
    
    func numberOfItemsInSection() -> Int {
        return categories.count
    }
    
    static func getDataByCategory(category: Category, completionHandler: @escaping (_ result: Result<NewsModel,NetworkError>) -> Void ) {
        
        let urlString = "https://newsapi.org/v2/top-headlines?country=us&apiKey={your_api_key}&category=\(category.name)"
        
        guard let url = URL(string: urlString) else {
            completionHandler(.failure(.urlError))
            return
        }
        
        URLSession.shared.dataTask(with: url) { dataResponse, urlResponse, error in
            if error == nil,
               let data = dataResponse {
                do {
                    let resultData = try JSONDecoder().decode(NewsModel.self, from: data)
                    completionHandler(.success(resultData))
                } catch let error {
                    print("Error while parsing data \(error)")
                    completionHandler(.failure(.canNotParseData))
                }
            } else {
                completionHandler(.failure(.canNotParseData))
            }
        }.resume()
    }
}
