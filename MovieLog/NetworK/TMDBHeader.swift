//
//  TMDBHeader.swift
//  MovieLog
//
//  Created by 최승범 on 6/26/24.
//

import Foundation

enum TMDBHeader {
    case Authorization
    case contentType
    
    var key: String {
        switch self {
        case .Authorization:
            return "Authorization"
        case .contentType:
            return "accept"
        }
    }
    
    var value: String {
        switch self {
        case .Authorization:
            return "Bearer \(APIKey.tmdb)"
        case .contentType:
            return "application/json"
            
        }
    }

}
