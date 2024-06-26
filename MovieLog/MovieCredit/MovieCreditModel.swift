//
//  MovieCreditModel.swift
//  MovieLog
//
//  Created by 최승범 on 6/26/24.
//

import Foundation

struct MovieCreditModel {
    let movieId: String
    let overview: String?
    let posterPath: String?
    let backdropPath: String?
    var movieCast: Casts?
    var similarMovies: SimilarMoviesDTO?
    var recommendedMovies: RecommendedMoviesDTO?
}
