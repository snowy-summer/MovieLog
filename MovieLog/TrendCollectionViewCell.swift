//
//  TrendCollectionViewCell.swift
//  MovieLog
//
//  Created by 최승범 on 6/26/24.
//

import UIKit
import SnapKit
import Kingfisher

final class TrendCollectionViewCell: UICollectionViewCell {
    
    private let dateLabel = UILabel()
    
    private let trendContainerView = UIView()
    private let thumbnailImageView = UIImageView()
    private let scoreStarImageView = UIImageView()
    private let scoreNumLabel = UILabel()
    private let nameLabel = UILabel()
    private let overviewLabel = UILabel()
    private let lineView = UIView()
    private let moreTextLabel = UILabel()
    private let moreImageView = UIImageView()
    
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

extension TrendCollectionViewCell {
    
    func updateContent(data: TrendResult) {
        dateLabel.text = data.releaseDate
        nameLabel.text = data.title
        overviewLabel.text = data.overview
        scoreNumLabel.text = "\(round(data.voteAverage * 10) / 10)"
        if let backdropPath = data.backdropPath {
            thumbnailImageView.kf.setImage(with: TMDBRequest.image(backdropPath).url)
        }
    }
    
}
extension TrendCollectionViewCell {
    
    private func configureHierarchy() {
        contentView.addSubview(dateLabel)
        
        contentView.addSubview(trendContainerView)
        
        trendContainerView.addSubview(thumbnailImageView)
        trendContainerView.addSubview(scoreStarImageView)
        trendContainerView.addSubview(scoreNumLabel)
        trendContainerView.addSubview(nameLabel)
        trendContainerView.addSubview(overviewLabel)
        trendContainerView.addSubview(lineView)
        trendContainerView.addSubview(moreTextLabel)
        trendContainerView.addSubview(moreImageView)
    }
    
    private func configureUI() {
        
        dateLabel.textColor = .lightGray
        dateLabel.font = .systemFont(ofSize: 14, weight: .regular)
        
        trendContainerView.backgroundColor = .white
        trendContainerView.layer.cornerRadius = 12
        trendContainerView.layer.shadowOpacity = 0.4
        trendContainerView.layer.shadowRadius = 12
        trendContainerView.layer.shadowOffset = CGSize(width: 4,
                                               height: 4)
  
        thumbnailImageView.contentMode = .scaleAspectFill
        thumbnailImageView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        thumbnailImageView.layer.cornerRadius = 12
        thumbnailImageView.clipsToBounds = true
        
        lineView.backgroundColor = .darkGray
        
        overviewLabel.textColor = .lightGray
        overviewLabel.font = .systemFont(ofSize: 14, weight: .regular)
        
        nameLabel.font = .systemFont(ofSize: 17, weight: .medium)
        
        moreTextLabel.text = "자세히 보기"
        moreTextLabel.font = .systemFont(ofSize: 12, weight: .medium)
        
        scoreStarImageView.image = UIImage(systemName: "star.fill")
        scoreStarImageView.tintColor = #colorLiteral(red: 1, green: 0.8878700137, blue: 0.2636117339, alpha: 1)
        
        scoreNumLabel.font = .systemFont(ofSize: 12)

        moreImageView.image = UIImage(systemName: "chevron.forward")
        moreImageView.tintColor = .black
    }
    
    private func configureLayout() {
        
        dateLabel.snp.makeConstraints { make in
            make.top.equalTo(contentView.snp.top)
            make.trailing.equalToSuperview().inset(20)
            make.height.equalTo(20)
        }
        
        trendContainerView.snp.makeConstraints { make in
            make.top.equalTo(dateLabel.snp.bottom).offset(8)
            make.directionalHorizontalEdges.equalToSuperview().inset(20)
        }
        
        thumbnailImageView.snp.makeConstraints { make in
            make.top.equalTo(trendContainerView.snp.top)
            make.leading.equalTo(trendContainerView.snp.leading)
            make.trailing.equalTo(trendContainerView.snp.trailing)
            make.height.equalTo(trendContainerView.snp.width).multipliedBy(0.6)
        }
        
        nameLabel.snp.makeConstraints { make in
            make.top.equalTo(thumbnailImageView.snp.bottom).offset(8)
            make.leading.equalTo(trendContainerView.snp.leading).inset(16)
            make.height.equalTo(20)
        }
        
        scoreStarImageView.snp.makeConstraints { make in
            make.centerY.equalTo(nameLabel.snp.centerY)
            make.leading.equalTo(nameLabel.snp.trailing).offset(16)
            make.size.equalTo(16)
        }
        
        scoreNumLabel.snp.makeConstraints { make in
            make.centerY.equalTo(scoreStarImageView.snp.centerY)
            make.leading.equalTo(scoreStarImageView.snp.trailing).offset(4)
            make.trailing.equalTo(trendContainerView.snp.trailing).inset(16)
            make.height.equalTo(16)
        }
        
        overviewLabel.snp.makeConstraints { make in
            make.top.equalTo(nameLabel.snp.bottom).offset(4)
            make.leading.equalTo(trendContainerView.snp.leading).inset(16)
            make.trailing.equalTo(trendContainerView.snp.trailing).inset(16)
            make.height.equalTo(20)
        }

        lineView.snp.makeConstraints { make in
            make.top.equalTo(overviewLabel.snp.bottom).offset(16)
            make.height.equalTo(1)
            make.leading.equalTo(trendContainerView.snp.leading).inset(16)
            make.trailing.equalTo(trendContainerView.snp.trailing).inset(16)
        }

        moreTextLabel.snp.makeConstraints { make in
            make.top.equalTo(lineView.snp.bottom).offset(8)
            make.leading.equalTo(trendContainerView.snp.leading).inset(16)
            make.bottom.equalTo(trendContainerView.snp.bottom).inset(8)
        }

        moreImageView.snp.makeConstraints { make in
            make.size.equalTo(14)
            make.centerY.equalTo(moreTextLabel.snp.centerY)
            make.trailing.equalTo(trendContainerView.snp.trailing).inset(16)
        }
    }
}
