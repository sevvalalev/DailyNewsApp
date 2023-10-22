//
//  NewsModel.swift
//  DailyNews
//
//  Created by Şevval Alev on 11.05.2023.
//

import Foundation

struct NewsModel: Codable {
    let status: String?
    let totalResults: Int?
    let news: [News]
    
    enum CodingKeys: String, CodingKey {
        case status
        case totalResults
        case news = "articles"
    }
}

struct News: Codable {
    let source: Source?
    let author: String?
    let title, description: String?
    let url: String?
    let image: String?
    let publishDate: String?
    let content: String?
    
    enum CodingKeys: String, CodingKey {
        case author, title, description, url, source, content
        case publishDate = "publishedAt"
        case image = "urlToImage"
    }
}

struct Source: Codable {
    let id: String?
    let name: String?
}
