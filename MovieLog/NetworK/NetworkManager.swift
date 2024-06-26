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
            .validate(statusCode: 200..<500)
            .responseDecodable(of: T.self) { response in
                switch response.result {
                case .success(let data):
                    completionHandler(.success(data))
                case .failure(let error):
                    completionHandler(.failure(error))
                }
            }
    }
}
