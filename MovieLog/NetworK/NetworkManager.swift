//
//  NetworkManager.swift
//  MovieLog
//
//  Created by 최승범 on 6/25/24.
//

import Foundation
import Alamofire

final class NetworkManager {
    
    static let shared = NetworkManager()
    
    private init() { }
    
    func fetchData<T: Decodable>(_ object: T.Type,
                                 router: TMDBRequest,
                                 completionHandler: @escaping (Result<T,Error>) -> Void) {
        
        AF.request(router)
            .validate(statusCode: 200..<300)
            .responseDecodable(of: T.self) { response in
                switch response.result {
                case .success(let data):
                    completionHandler(.success(data))
                case .failure(let error):
                    if let data = response.data {
                        do {
                            
                            let failResult = try JSONDecoder().decode(ErrorData.self,
                                                                      from: data)
                            completionHandler(.failure(NetworkError.network(statusCode: failResult.statusCode,
                                                                            message: failResult.statusMessage)))
                        } catch {
                            completionHandler(.failure(NetworkError.decoding))
                        }
                    } else {
                        completionHandler(.failure(error))
                    }
                }
            }
    }
}

struct ErrorData: Decodable {
    let success: Bool
    let statusCode: Int
    let statusMessage: String
    
    enum CodingKeys: String, CodingKey {
        case success
        case statusCode = "status_code"
        case statusMessage = "status_message"
    }
}

