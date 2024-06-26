//
//  SimilarMovieDTO.swift
//  MovieLog
//
//  Created by 최승범 on 6/26/24.
//

import Foundation

// MARK: - SimilarMovieDTO
struct SimilarMovieDTO: Decodable {
    let page: Int
    let results: [SimilarResult]
    let totalPages, totalResults: Int

    enum CodingKeys: String, CodingKey {
        case page, results
        case totalPages = "total_pages"
        case totalResults = "total_results"
    }
}

// MARK: - Result
struct SimilarResult: Decodable {
    let id: Int
    let adult: Bool?
    let genreIDS: [Int]
    let originalTitle, title: String
    let releaseDate, overview: String
    let posterPath, backdropPath: String?
    let popularity: Double
    let voteAverage: Double
    let voteCount: Int

    enum CodingKeys: String, CodingKey {
        case id
        case title
        case adult
        case overview
        case popularity
        case backdropPath = "backdrop_path"
        case genreIDS = "genre_ids"
        case originalTitle = "original_title"
        case posterPath = "poster_path"
        case releaseDate = "release_date"
        case voteAverage = "vote_average"
        case voteCount = "vote_count"
    }
}
