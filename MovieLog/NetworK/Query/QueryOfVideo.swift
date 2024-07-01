//
//  QueryOfVideo.swift
//  MovieLog
//
//  Created by 최승범 on 7/1/24.
//

import Foundation

struct QueryOfVideo {
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
