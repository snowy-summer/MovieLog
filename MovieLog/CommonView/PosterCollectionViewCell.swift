//
//  PosterCollectionViewCell.swift
//  MovieLog
//
//  Created by 최승범 on 6/26/24.
//

import UIKit
import SnapKit

final class PosterCollectionViewCell: UICollectionViewCell {
    
    private let thumbnailImageView = UIImageView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureHierarchy()
        configureUI()
        configureLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

//MARK: - Method

extension PosterCollectionViewCell {
    
    func updateContent(imageString: String) {

        thumbnailImageView.kf.indicatorType = .activity
        thumbnailImageView.kf.setImage(with: TMDBRouter.image(imageString).url)
    }
}

//MARK: - Configuration

extension PosterCollectionViewCell {
    
    private func configureHierarchy() {
        
        contentView.addSubview(thumbnailImageView)
    }
    
    private func configureUI() {
        
        thumbnailImageView.layer.cornerRadius = 8
        thumbnailImageView.clipsToBounds = true
    }
    
    private func configureLayout() {
        
        thumbnailImageView.snp.makeConstraints { make in
            make.directionalEdges.equalToSuperview()
        }
    }
}
