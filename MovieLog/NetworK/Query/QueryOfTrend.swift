//
//  QueryOfTrend.swift
//  MovieLog
//
//  Created by 최승범 on 6/26/24.
//

import Foundation

struct QueryOfTrend {
    private let timeWindow: TimeWindow
    private let language: String?
    
    enum TimeWindow: String {
        case day
        case week
    }
    
    init(timeWindow: TimeWindow,
         language: String? = "ko-KR") {
        
        self.timeWindow = timeWindow
        self.language = language
    }
    
    func queryItem() -> [URLQueryItem] {
        var queryItems = [URLQueryItem]()
        
        queryItems.append(URLQueryItem(name: "time_window",
                                       value: timeWindow.rawValue))
        
       
        if let language = language {
            queryItems.append(URLQueryItem(name: "language",
                                           value: language))
        }
      
        return queryItems
        
    }
}
