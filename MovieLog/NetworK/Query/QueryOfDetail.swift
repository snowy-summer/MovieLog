//
//  QueryOfDetail.swift
//  MovieLog
//
//  Created by 최승범 on 6/28/24.
//

import Foundation

struct QueryOfDetail {
    private let language: String?
    private let appendToResponse: String?
  
    init(language: String? = "ko-KR",
         appendToResponse: String? = nil) {
        
        self.language = language
        self.appendToResponse = appendToResponse
    }
    
    func queryItem() -> [URLQueryItem] {
        var queryItems = [URLQueryItem]()
        
        if let language = language {
            queryItems.append(URLQueryItem(name: "language",
                                           value: language))
        }
        
        if let appendToResponse = appendToResponse {
            queryItems.append(URLQueryItem(name: "append_to_response",
                                           value: appendToResponse))
        }
        
        return queryItems
        
    }
}
