//
//  AllNewsCellViewModel.swift
//  DailyNews
//
//  Created by Şevval Alev on 20.05.2023.
//

import Foundation

class AllNewsCellViewModel {
    
    var author: String
    var title: String
    var publishDate: String
    var imageUrl: String?
    

    init(allNewsData: News) {
        self.title = allNewsData.title ?? ""
        self.publishDate = allNewsData.publishDate ?? "0"
        self.author = allNewsData.author ?? ""
        self.imageUrl = allNewsData.image 
    }

}

