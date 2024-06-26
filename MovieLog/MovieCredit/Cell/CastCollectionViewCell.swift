//
//  CastCollectionViewCell.swift
//  MovieLog
//
//  Created by 최승범 on 6/26/24.
//

import UIKit
import SnapKit
import Kingfisher

final class CastCollectionViewCell: UICollectionViewCell {
    
    private let profileImageView = UIImageView()
    private let nameLabel = UILabel()
    private let characterLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureHierarchy()
        configureUI()
        configureLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func updateContent(data: Cast) {
    
        if let profilePath = data.profilePath {
            profileImageView.kf.setImage(with: TMDBRequest.image(profilePath).url)
        }
        nameLabel.text = data.name
        characterLabel.text = data.character
    }
}

extension CastCollectionViewCell {
    
    private func configureHierarchy() {
        contentView.addSubview(profileImageView)
        contentView.addSubview(nameLabel)
        contentView.addSubview(characterLabel)
    }
    
    private func configureUI() {
     
        profileImageView.layer.cornerRadius = 8
        profileImageView.clipsToBounds = true
        profileImageView.backgroundColor = .gray
        
        characterLabel.font = .systemFont(ofSize: 12, weight: .bold)
        characterLabel.textColor = .black
        
        nameLabel.font = .systemFont(ofSize: 12, weight: .semibold)
        nameLabel.textColor = .lightGray
    }
    
    private func configureLayout() {
        
        profileImageView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.centerX.equalToSuperview()
            make.directionalHorizontalEdges.equalToSuperview()
            
        }
        
        characterLabel.snp.makeConstraints { make in
            make.top.equalTo(profileImageView.snp.bottom).offset(4)
            make.centerX.equalTo(profileImageView.snp.centerX)
            make.leading.equalTo(profileImageView.snp.leading)
            make.trailing.equalTo(profileImageView.snp.trailing)
        }
        
        nameLabel.snp.makeConstraints { make in
            make.top.equalTo(characterLabel.snp.bottom).offset(4)
            make.centerX.equalTo(profileImageView.snp.centerX)
            make.leading.equalTo(profileImageView.snp.leading)
            make.trailing.equalTo(profileImageView.snp.trailing)
            make.bottom.equalTo(contentView.snp.bottom)
        }
        
        
    }
}

