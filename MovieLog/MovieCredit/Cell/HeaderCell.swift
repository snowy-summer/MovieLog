//
//  HeaderCell.swift
//  MovieLog
//
//  Created by 최승범 on 6/26/24.
//

import UIKit
import SnapKit

final class HeaderCell: UICollectionViewCell {
    
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

extension HeaderCell {
    
    func updateContent(imageString: String) {
        
        
        thumbnailImageView.kf.setImage(with: TMDBRequest.image(imageString).url)
    }
}

//MARK: - Configuration

extension HeaderCell {
    
    private func configureHierarchy() {
        
        contentView.addSubview(thumbnailImageView)
    }
    
    private func configureUI() {
        
        thumbnailImageView.layer.cornerRadius = 8
        thumbnailImageView.clipsToBounds = true
        thumbnailImageView.backgroundColor = .black
    }
    
    private func configureLayout() {
        
        thumbnailImageView.snp.makeConstraints { make in
            make.directionalEdges.equalToSuperview()
        }
    }
}
