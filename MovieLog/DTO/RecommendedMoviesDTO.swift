//
//  RecommendedMoviesDTO.swift
//  MovieLog
//
//  Created by 최승범 on 6/26/24.
//

import Foundation

//MARK: - RecommendedMoviesDTO

struct RecommendedMoviesDTO: Codable {
    let page: Int
    let results: [RecommendResult]
    let totalPages, totalResults: Int
    
    enum CodingKeys: String, CodingKey {
        case page, results
        case totalPages = "total_pages"
        case totalResults = "total_results"
    }
}

// MARK: - Result

struct RecommendResult: Codable {
    let id: Int
    let backdropPath: String?
    let originalTitle, overview: String
    let posterPath: String?
    let adult: Bool
    let title: String
    let genreIDS: [Int]
    let popularity: Double
    let releaseDate: String
    let voteAverage: Double
    let voteCount: Int
    
    enum CodingKeys: String, CodingKey {
        case id
        case adult, title
        case overview
        case popularity
        case backdropPath = "backdrop_path"
        case originalTitle = "original_title"
        case posterPath = "poster_path"
        case genreIDS = "genre_ids"
        case releaseDate = "release_date"
        case voteAverage = "vote_average"
        case voteCount = "vote_count"
    }
}
