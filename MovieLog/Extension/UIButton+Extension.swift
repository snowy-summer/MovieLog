//
//  UIButton+Extension.swift
//  MovieLog
//
//  Created by 최승범 on 6/27/24.
//

import UIKit

extension UIButton {
    
    func buttonStyle(type: DesignOfButton) {
        var configuration = UIButton.Configuration.filled()
        
        configuration.title = type.title
        configuration.titleAlignment = .center
        configuration.baseBackgroundColor = type.backGroundColor
        configuration.baseForegroundColor = type.tintColor
        configuration.cornerStyle = .small
        configuration.image = UIImage(systemName: type.imageName)
        configuration.imagePlacement = .leading
        configuration.imagePadding = 8
        configuration.preferredSymbolConfigurationForImage = UIImage.SymbolConfiguration(pointSize: 14)
        
        self.configuration = configuration
    }
}

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
