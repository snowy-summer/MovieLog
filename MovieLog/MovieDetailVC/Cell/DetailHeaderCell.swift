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
    private let titleLabel = UILabel()
    private let dateLabel = UILabel()
    private let genreLabel = UILabel()
    private let scoreStarImageView = UIImageView()
    private let voteAverageLabel = UILabel()
    private let playButton = UIButton()
    var showVideo: () -> () = {}
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureHierarchy()
        configureUI()
        configureLayout()
        configureGestureAndButtonActions()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

//MARK: - Method

extension DetailHeaderCell {
    
    func updateContent(data: MovieDetailDTO) {
        if let imagePath = data.backdropPath {
            thumbnailImageView.kf.setImage(with: TMDBRouter.image(imagePath).url)
        }
        if let voteAverage = data.voteAverage {
            voteAverageLabel.text = "\(round(voteAverage * 10) / 10)"
        } else {
            voteAverageLabel.text = "평가중"
        }
        
        titleLabel.text = data.title

        dateLabel.text = data.releaseDate?.split(separator: "-").map{ String($0) }[0]
        
        
        if let genres = data.genres {
            var genreText = ""
            genres.forEach { genre in
                genreText += "\(genre.name) "
            }
            genreLabel.text = genreText
        }
    }
    
    @objc private func playButtonClicked() {
        showVideo()
    }
}

//MARK: - Configuration

extension DetailHeaderCell {
    
    private func configureHierarchy() {
        
        contentView.addSubview(thumbnailImageView)
        contentView.addSubview(playButton)
        contentView.addSubview(titleLabel)
        contentView.addSubview(scoreStarImageView)
        contentView.addSubview(voteAverageLabel)
        contentView.addSubview(dateLabel)
        contentView.addSubview(genreLabel)
    }
    
    private func configureUI() {
        
        thumbnailImageView.layer.cornerRadius = 8
        thumbnailImageView.clipsToBounds = true
        thumbnailImageView.backgroundColor = .baseFont
        
        titleLabel.textColor = .baseFont
        
        scoreStarImageView.image = UIImage(systemName: "star.fill")
        scoreStarImageView.tintColor = #colorLiteral(red: 1, green: 0.8878700137, blue: 0.2636117339, alpha: 1)
        
        voteAverageLabel.font = .systemFont(ofSize: 14)
        voteAverageLabel.textColor = .lightGray
        
        dateLabel.font = .systemFont(ofSize: 14)
        dateLabel.textColor = .lightGray
        
        genreLabel.font = .systemFont(ofSize: 14)
        genreLabel.textColor = .lightGray
        
        playButton.buttonStyle(type: .play)
    }
    
    private func configureLayout() {
        
        playButton.snp.makeConstraints { make in
            make.bottom.equalToSuperview()
            make.directionalHorizontalEdges.equalTo(contentView.snp.directionalHorizontalEdges)
        }
        
        thumbnailImageView.snp.makeConstraints { make in
            make.top.directionalHorizontalEdges.equalTo(contentView)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.leading.equalTo(thumbnailImageView.snp.leading)
            make.top.equalTo(thumbnailImageView.snp.bottom).offset(8)
            make.height.equalTo(20)
        }
    
        scoreStarImageView.snp.makeConstraints { make in
            make.leading.equalTo(thumbnailImageView.snp.leading)
            make.top.equalTo(titleLabel.snp.bottom).offset(8)
            make.bottom.equalTo(playButton.snp.top).offset(-8)
            make.height.equalTo(20)
        }
        
        voteAverageLabel.snp.makeConstraints { make in
            make.leading.equalTo(scoreStarImageView.snp.trailing).offset(8)
            make.top.equalTo(titleLabel.snp.bottom).offset(8)
            make.bottom.equalTo(playButton.snp.top).offset(-8)
            make.height.equalTo(20)
        
        }
        
        dateLabel.snp.makeConstraints { make in
            make.leading.equalTo(voteAverageLabel.snp.trailing).offset(20)
            make.top.equalTo(titleLabel.snp.bottom).offset(8)
            make.bottom.equalTo(playButton.snp.top).offset(-8)
            make.height.equalTo(20)
        
        }
        
        genreLabel.snp.makeConstraints { make in
            make.leading.equalTo(dateLabel.snp.trailing).offset(20)
            make.top.equalTo(titleLabel.snp.bottom).offset(8)
            make.bottom.equalTo(playButton.snp.top).offset(-8)
            make.height.equalTo(20)
        
        }
    }
    
    private func configureGestureAndButtonActions() {
        playButton.addTarget(self,
                             action: #selector(playButtonClicked),
                             for: .touchUpInside)
        
    }
    
}
