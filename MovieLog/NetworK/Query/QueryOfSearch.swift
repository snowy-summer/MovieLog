//
//  QueryOfSearch.swift
//  MovieLog
//
//  Created by 최승범 on 6/26/24.
//

import Foundation

struct QueryOfSearch {
    private let query: String
    private let includeAdult: Bool?
    private let language: String?
    private let primaryReleaseYear: String?
    private let page: Int?
    private let region: String?
    private let year: String?
    
    init(query: String,
         includeAdult: Bool? = nil,
         language: String? = nil,
         primaryReleaseYear: String? = nil,
         page: Int? = nil,
         region: String? = nil,
         year: String? = nil) {
        
        self.query = query
        self.includeAdult = includeAdult
        self.language = language
        self.primaryReleaseYear = primaryReleaseYear
        self.page = page
        self.region = region
        self.year = year
    }
    
    func queryItem() -> [URLQueryItem] {
        var queryItems = [URLQueryItem]()
        
        queryItems.append(URLQueryItem(name: "query",
                                       value: query))
        
        if let includeAdult = includeAdult {
            queryItems.append(URLQueryItem(name: "include_adult",
                                           value: String(includeAdult)))
        }
        
        if let language = language {
            queryItems.append(URLQueryItem(name: "language",
                                           value: language))
        }
        
        if let primaryReleaseYear  = primaryReleaseYear {
            queryItems.append(URLQueryItem(name: "primary_release_year",
                                           value: primaryReleaseYear))
        }
        
        if let page = page {
            queryItems.append(URLQueryItem(name: "page",
                                           value: String(page)))
        }
        
        if let region = region {
            queryItems.append(URLQueryItem(name: "region",
                                           value: region))
        }
        
        if let year = year {
            queryItems.append(URLQueryItem(name: "year",
                                           value: year))
        }
        
        return queryItems
        
    }
}
