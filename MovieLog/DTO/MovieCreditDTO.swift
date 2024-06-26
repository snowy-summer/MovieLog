//
//  MovieCreditDTO.swift
//  MovieLog
//
//  Created by 최승범 on 6/26/24.
//

import Foundation

// MARK: - CreditDTO
struct MovieCreditDTO: Decodable {
    let id: Int
    let overview: String
    let posterPath: String?
    let backdropPath: String?
    var cast = [Cast]()
}

// MARK: - Casts
struct Casts: Decodable {
    let id: Int
    let cast: [Cast]
}

struct Cast: Decodable {
    let name: String?
    let character: String?
    let profilePath: String?
    
    enum CodingKeys: String, CodingKey {
        case name, character
        case profilePath = "profile_path"
    }
}
