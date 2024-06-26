//
//  QueryOfCredit.swift
//  MovieLog
//
//  Created by 최승범 on 6/26/24.
//

import Foundation

struct QueryOfCredit {
    private let movieId: String
    private let language: String?
  
    init(movieId: String,
         language: String? = "ko-KR") {
        
        self.movieId = movieId
        self.language = language
    }
    
    func queryItem() -> [URLQueryItem] {
        var queryItems = [URLQueryItem]()
        
        queryItems.append(URLQueryItem(name: "movie_id",
                                       value: movieId))
        
        if let language = language {
            queryItems.append(URLQueryItem(name: "language",
                                           value: language))
        }
        
        return queryItems
        
    }
}
