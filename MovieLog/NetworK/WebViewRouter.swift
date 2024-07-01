//
//  WebViewRouter.swift
//  MovieLog
//
//  Created by 최승범 on 7/1/24.
//

import Foundation

enum WebViewRouter{
   case youtube(String)
    
    var scheme: String {
        switch self {
        default:
            return "https"
        }
    }
    
    var host: String {
        switch self {
        case .youtube:
            return "www.youtube.com"
        }
    }
    
    var path: String {
        switch self {
        case .youtube:
            return "/watch"
        }
        
    }
 
    var parameter: [URLQueryItem] {
        
        switch self {
        case .youtube(let key):
            return QueryOfYoutube(v: key).queryItem()
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
    
    var request: URLRequest {
        switch self {
        case .youtube:
            return URLRequest(url: url!)
        }
    }
    
}
