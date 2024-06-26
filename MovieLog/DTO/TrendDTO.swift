//
//  TrendDTO.swift
//  MovieLog
//
//  Created by 최승범 on 6/26/24.
//

import Foundation

// MARK: - TrendDTO
struct TrendDTO: Decodable {
    let page: Int
    let results: [TrendResult]
    let totalPages, totalResults: Int

    enum CodingKeys: String, CodingKey {
        case page, results
        case totalPages = "total_pages"
        case totalResults = "total_results"
    }
}

// MARK: - TrendResult
struct TrendResult: Decodable {
    let id: Int
    let originalTitle, title: String?
    let backdropPath, posterPath: String?
    let overview: String?
    let genreIDS: [Int]
    let popularity: Double?
    let releaseDate: String?
    let voteAverage: Double?
    let voteCount: Int?

    enum CodingKeys: String, CodingKey {
        case id
        case title
        case overview
        case popularity
        case originalTitle = "original_title"
        case posterPath = "poster_path"
        case backdropPath = "backdrop_path"
        case genreIDS = "genre_ids"
        case releaseDate = "release_date"
        case voteAverage = "vote_average"
        case voteCount = "vote_count"
    }
}
