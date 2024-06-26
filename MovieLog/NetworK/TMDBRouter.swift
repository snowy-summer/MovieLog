//
//  UrlList.swift
//  MovieLog
//
//  Created by 최승범 on 6/25/24.
//

import Foundation
import Alamofire

enum TMDBRequest: URLRequestConvertible {
    
    case search(String)
    case trend
    case credit(String)
    case similarMovie(String)
    case recommendMovie(String)
    case image(String)
    
    var scheme: String {
        switch self {
        default:
            return "https"
        }
    }
    
    var host: String {
        switch self {
        case .image:
            return "image.tmdb.org"
            
        default:
            return "api.themoviedb.org"
        }
    }
    
    var path: String {
        switch self {
        case .search:
            return "/3/search/movie"
        case .trend:
            return "/3/trending/all/day"
        case .credit(let movieId):
            return "/3/movie/\(movieId)/credits"
        case .similarMovie(let movieId):
            return "/3/movie/\(movieId)/similar"
        case .recommendMovie(let movieId):
            return "/3/movie/\(movieId)/recommendations"
        case.image(let posterPath):
            return "/t/p/w500" + posterPath
        }
        
    }
    
    var parameter: [URLQueryItem] {
        
        switch self {
        case .search(let movie):
            return QueryOfSearch(query: movie).queryItem()

        default:
            return [URLQueryItem]()
        }
    }
    
    var url: URL? {
        switch self {
            
        default:
            var components = URLComponents()
            components.scheme = scheme
            components.host = host
            components.path = path
            components.queryItems = parameter
            
            return components.url
            
        }
    }
    
    var headers: HTTPHeaders {
        
        var headers: HTTPHeaders
        
        switch self {
        case .image:
            return []
       
        default:
            headers = [
                TMDBHeader.Authorization.key : TMDBHeader.Authorization.value,
                TMDBHeader.contentType.key : TMDBHeader.contentType.value
            ]
        }
        
        return headers
    }
    
    var method: HTTPMethod {
        switch self {
        default:
            return .get
        }
    }
    
    func asURLRequest() throws -> URLRequest {
        guard let url = self.url else { throw NetworkError.invaildURL }
        let urlRequest = try URLRequest(url: url,
                                    method: self.method,
                                    headers: self.headers)
        
        return urlRequest
    }
    
}
