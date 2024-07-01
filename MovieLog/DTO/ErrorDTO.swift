//
//  ErrorDTO.swift
//  MovieLog
//
//  Created by 최승범 on 6/30/24.
//

import Foundation

struct ErrorDTO: Decodable {
    let success: Bool
    let statusCode: Int
    let statusMessage: String
    
    enum CodingKeys: String, CodingKey {
        case success
        case statusCode = "status_code"
        case statusMessage = "status_message"
    }
}
