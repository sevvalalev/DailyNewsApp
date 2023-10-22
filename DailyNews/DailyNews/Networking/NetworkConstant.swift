//
//  NetworkConstant.swift
//  DailyNews
//
//  Created by Şevval Alev on 15.05.2023.
//

import Foundation

class NetworkConstant {
    
    public static var shared: NetworkConstant = NetworkConstant()
    
    private init() {
        //singletone
    }
    
    public var allNewsAddress: String {
        get {
            return "https://newsapi.org/v2/top-headlines?country=us&apiKey={your_api_key}"
        }
    }
    
    public var coinApi: String {
        get{
            return "http://api.coinlayer.com/live?access_key={your_api_key}"
           
        }
    }
}
