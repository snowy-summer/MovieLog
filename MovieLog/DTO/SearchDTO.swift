//
//  SearchDTO.swift
//  MovieLog
//
//  Created by 최승범 on 6/26/24.
//

import Foundation

// MARK: - SearchDTO
struct SearchDTO: Decodable {
    let page: Int
    var results: [MovieSearchResult]
    let totalPages, totalResults: Int

    enum CodingKeys: String, CodingKey {
        case page, results
        case totalPages = "total_pages"
        case totalResults = "total_results"
    }
}

// MARK: - Result
struct MovieSearchResult: Decodable {
    let id: Int
    let name, title: String?
    let backdropPath: String?
    let posterPath: String?
    
    enum CodingKeys: String, CodingKey {
        case id
        case name, title
        case backdropPath = "backdrop_path"
        case posterPath = "poster_path"
    }
}
