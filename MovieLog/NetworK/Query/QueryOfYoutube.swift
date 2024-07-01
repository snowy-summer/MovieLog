//
//  QueryOfYoutube.swift
//  MovieLog
//
//  Created by 최승범 on 7/1/24.
//

import Foundation

struct QueryOfYoutube {
    private let v: String?
    
    init(v: String?) {
        self.v = v
    }
    
    func queryItem() -> [URLQueryItem] {
        var queryItems = [URLQueryItem]()
       
        if let v = v {
            queryItems.append(URLQueryItem(name: "v",
                                           value: v))
        }
      
        return queryItems
        
    }
}
