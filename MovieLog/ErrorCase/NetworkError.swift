//
//  NetworkError.swift
//  MovieLog
//
//  Created by 최승범 on 6/26/24.
//

import Foundation

enum NetworkError: Error, CustomStringConvertible {
    
    case invaildURL
    case network(statusCode: Int, message: String)
    case decoding
    
    var description: String {
        switch self {
        case .invaildURL:
            return "잘못된 URL입니다."
        case .network(let statusCode, let message):
            return "네트워크 에러\ncode: \(statusCode)\n메시지: \(message)"
        case .decoding:
            return "디코딩 에러"
        }
    }
    
    
}
