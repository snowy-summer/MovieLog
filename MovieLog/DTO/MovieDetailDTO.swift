//
//  MovieDetailDTO.swift
//  MovieLog
//
//  Created by 최승범 on 6/28/24.
//

import Foundation

//MARK: - MovieDetailDTO
struct MovieDetailDTO: Decodable {
    let id: Int
    let adult: Bool
    let genres: [Genre]?
    let overview: String?
    let backdropPath: String?
    let imdbID: String?
    let originalTitle: String?
    let popularity: Double?
    let posterPath: String?
    let releaseDate: String?
    let revenue, runtime: Int?
    let status, tagline, title: String?
    let video: Bool?
    let voteAverage: Double?
    let voteCount: Int?

    enum CodingKeys: String, CodingKey {
        case id, adult
        case genres
        case overview, popularity
        case revenue, runtime
        case status, tagline, title, video
        case backdropPath = "backdrop_path"
        case imdbID = "imdb_id"
        case originalTitle = "original_title"
        case posterPath = "poster_path"
        case releaseDate = "release_date"
        case voteAverage = "vote_average"
        case voteCount = "vote_count"
    }
}

// MARK: - Genre
struct Genre: Decodable {
    let id: Int
    let name: String
}

// MARK: - SpokenLanguage
struct SpokenLanguage: Decodable {
    let englishName, iso639_1, name: String

    enum CodingKeys: String, CodingKey {
        case englishName = "english_name"
        case iso639_1 = "iso_639_1"
        case name
    }
}
