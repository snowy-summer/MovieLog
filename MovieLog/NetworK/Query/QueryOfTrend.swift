//
//  QueryOfTrend.swift
//  MovieLog
//
//  Created by 최승범 on 6/26/24.
//

import Foundation

struct QueryOfTrend {
    private let language: String?
    
    init(language: String? = "ko-KR") {
        self.language = language
    }
    
    func queryItem() -> [URLQueryItem] {
        var queryItems = [URLQueryItem]()
       
        if let language = language {
            queryItems.append(URLQueryItem(name: "language",
                                           value: language))
        }
      
        return queryItems
        
    }
}

enum TimeWindow: String {
    case day
    case week
}
