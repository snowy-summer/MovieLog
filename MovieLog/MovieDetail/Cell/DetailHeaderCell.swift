//
//  DetailHeaderCell.swift
//  MovieLog
//
//  Created by 최승범 on 6/26/24.
//

import UIKit
import SnapKit

final class DetailHeaderCell: UICollectionViewCell {
    
    private let thumbnailImageView = UIImageView()
    private let dateLabel = UILabel()
    private let genreLabel = UILabel()
    private let scoreStarImageView = UIImageView()
    private let voteAverageLabel = UILabel()
    
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

extension DetailHeaderCell {
    
    func updateContent(imageString: String) {
        
        thumbnailImageView.kf.setImage(with: TMDBRequest.image(imageString).url)
    }
}

//MARK: - Configuration

extension DetailHeaderCell {
    
    private func configureHierarchy() {
        
        contentView.addSubview(thumbnailImageView)
        contentView.addSubview(scoreStarImageView)
        contentView.addSubview(voteAverageLabel)
        contentView.addSubview(dateLabel)
        contentView.addSubview(genreLabel)
    }
    
    private func configureUI() {
        
        thumbnailImageView.layer.cornerRadius = 8
        thumbnailImageView.clipsToBounds = true
        thumbnailImageView.backgroundColor = .baseFont
        
        scoreStarImageView.image = UIImage(systemName: "star.fill")
        scoreStarImageView.tintColor = #colorLiteral(red: 1, green: 0.8878700137, blue: 0.2636117339, alpha: 1)
        
        voteAverageLabel.font = .systemFont(ofSize: 12)
        voteAverageLabel.text = "8.9"
    }
    
    private func configureLayout() {
        
        thumbnailImageView.snp.makeConstraints { make in
            make.top.directionalHorizontalEdges.equalTo(contentView)
            make.height.equalTo(contentView.snp.height).multipliedBy(0.75)
        }
        
        scoreStarImageView.snp.makeConstraints { make in
            make.leading.equalTo(thumbnailImageView.snp.leading)
            make.top.equalTo(thumbnailImageView.snp.bottom).offset(8)
        }
        
        voteAverageLabel.snp.makeConstraints { make in
            make.leading.equalTo(scoreStarImageView.snp.trailing)
            make.top.equalTo(thumbnailImageView.snp.bottom).offset(8)
        }
    }
}
