//
//  QueryOfSimilarAndRecommendations.swift
//  MovieLog
//
//  Created by 최승범 on 6/26/24.
//

import Foundation

struct QueryOfSimilarAndRecommendations {
    private let movieId: String
    private let language: String?
    private let page: Int?
  
    
    init(movieId: String,
         language: String? = "ko-KR",
         page: Int? = nil) {
        
        self.movieId = movieId
        self.language = language
        self.page = page
    }
    
    func queryItem() -> [URLQueryItem] {
        var queryItems = [URLQueryItem]()
        
        queryItems.append(URLQueryItem(name: "movie_id",
                                       value: movieId))
        
        if let language = language {
            queryItems.append(URLQueryItem(name: "language",
                                           value: language))
        }
        
        if let page = page {
            queryItems.append(URLQueryItem(name: "page",
                                           value: String(page)))
        }
        
        return queryItems
        
    }
}
