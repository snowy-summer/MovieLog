//
//  UrlList.swift
//  MovieLog
//
//  Created by 최승범 on 6/25/24.
//

import Foundation
import Alamofire

enum TMDBRouter: URLRequestConvertible {
    
    case search(keyword: String, page: Int)
    case trend(TimeWindow)
    case credit(String)
    case similarMovies(String)
    case recommendedMovies(String)
    case detail(String)
    case image(String)
    case video(String)
    
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
        case .trend(let time):
            return "/3/trending/movie/\(time.rawValue)"
        case .credit(let movieId):
            return "/3/movie/\(movieId)/credits"
        case .similarMovies(let movieId):
            return "/3/movie/\(movieId)/similar"
        case .recommendedMovies(let movieId):
            return "/3/movie/\(movieId)/recommendations"
        case .detail(let movieId):
            return "/3/movie/\(movieId)"
        case.image(let posterPath):
            return "/t/p/w500" + posterPath
        case .video(let movieId):
            return "/3/movie/\(movieId)/videos"
        }
        
    }
 
    var parameter: [URLQueryItem] {
        
        switch self {
        case .search(let movie, let page):
            return QueryOfSearch(query: movie,page: page).queryItem()
            
        case .trend:
            return QueryOfTrend().queryItem()
            
        case .credit(let movieId):
            return QueryOfCredit(movieId: movieId).queryItem()
            
        case .similarMovies(let movieId):
            return QueryOfSimilarAndRecommendations(movieId: movieId).queryItem()
            
        case .recommendedMovies(let movieId):
            return QueryOfSimilarAndRecommendations(movieId: movieId).queryItem()
            
        case .video:
            return QueryOfVideo().queryItem()
            
        case .detail:
            return QueryOfDetail().queryItem()
        
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
