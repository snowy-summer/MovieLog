//
//  HomeCollectionViewSections.swift
//  MovieLog
//
//  Created by 최승범 on 6/27/24.
//

import UIKit

enum HomeCollectionViewSections: Int, CaseIterable {
    case main
    case trend
    
    var title: String? {
        switch self {
            
        case .trend:
            return "인기있는 영화"
            
        default:
            return nil
        }
    }
    
    var layoutSection: NSCollectionLayoutSection {
        switch self {
        case .main:
            let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                                  heightDimension: .fractionalHeight(1.0))
            let item = NSCollectionLayoutItem(layoutSize: itemSize)
            
            let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                                   heightDimension: .fractionalWidth(1.3))
            let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize,
                                                           subitems: [item])
            
            group.contentInsets = .init(top: 16,
                                        leading: 8,
                                        bottom: 0,
                                        trailing: 8)
            
            let section = NSCollectionLayoutSection(group: group)
            section.contentInsets = .init(top: 0,
                                          leading: 16,
                                          bottom: 16,
                                          trailing: 16)
            
            return section
            
        case .trend:
            let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                                  heightDimension: .fractionalHeight(1.0))
            let item = NSCollectionLayoutItem(layoutSize: itemSize)
            
            let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.4),
                                                   heightDimension: .fractionalWidth(0.52))
            let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize,
                                                           subitems: [item])
            
            
            let section = NSCollectionLayoutSection(group: group)
            section.interGroupSpacing = 8
            section.orthogonalScrollingBehavior = .continuous
            section.contentInsets = .init(top: 0,
                                          leading: 16,
                                          bottom: 16,
                                          trailing: 16)
            
            let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                                    heightDimension: .absolute(44))
            let header = NSCollectionLayoutBoundarySupplementaryItem(
                layoutSize: headerSize,
                elementKind: UICollectionView.elementKindSectionHeader,
                alignment: .top
            )
            
            section.boundarySupplementaryItems = [header]
            
            return section
        }
    }
}
