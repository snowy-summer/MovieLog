//
//  DesignOfButton.swift
//  MovieLog
//
//  Created by 최승범 on 6/29/24.
//

import UIKit

enum DesignOfButton {
    case play
    case add
    case seeAll
    
    var title: String {
        switch self {
        case .play:
            return "재생"
        case .add:
            return "추가"
        case .seeAll:
            return "모두 보기"
        }
    }
    
    var imageName: String {
        switch self {
        case .play:
            return "play.fill"
        case .add:
            return "plus"
        case .seeAll:
            return ""
        }
    }
    
    var tintColor: UIColor {
        switch self {
        case .play:
            return .black
        case .add:
            return .white
        case .seeAll:
            return .gray
        }
    }
    
    var backGroundColor: UIColor {
        switch self {
        case .play:
            return .white
        case .add:
            return #colorLiteral(red: 0.1907704771, green: 0.20546031, blue: 0.2267445326, alpha: 1)
        case .seeAll:
            return .clear
        }
    }
}
