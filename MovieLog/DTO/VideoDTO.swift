//
//  VideoDTO.swift
//  MovieLog
//
//  Created by 최승범 on 7/1/24.
//

import Foundation

struct VideoDTO: Decodable {
    let id: Int
    let results: [VideoResult]
    
}

struct VideoResult: Decodable {
    let key: String
    let size: Int
    let name: String
    let type: String
}
