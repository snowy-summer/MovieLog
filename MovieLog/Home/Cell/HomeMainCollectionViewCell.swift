//
//  HomeMainCollectionViewCell.swift
//  MovieLog
//
//  Created by 최승범 on 6/27/24.
//

import UIKit
import SnapKit

final class HomeMainCollectionViewCell: UICollectionViewCell {
    
    private let thumbnailImageView = UIImageView()
    private let buttonStackView = UIStackView()
    private let playButton = UIButton()
    private let addButton = UIButton()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureHierarchy()
        configureUI()
        configureLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func updateContent(imageString: String) {
        thumbnailImageView.kf.setImage(with: TMDBRequest.image(imageString).url)
    }
}

extension HomeMainCollectionViewCell {
    
    private func configureHierarchy() {
        
        contentView.addSubview(thumbnailImageView)
        contentView.addSubview(buttonStackView)
        buttonStackView.addArrangedSubview(playButton)
        buttonStackView.addArrangedSubview(addButton)
    }
    
    private func configureUI() {
        
        thumbnailImageView.layer.cornerRadius = 12
        thumbnailImageView.clipsToBounds = true
        
        playButton.buttonStyle(type: .play)
        addButton.buttonStyle(type: .add)
        
        buttonStackView.axis = .horizontal
        buttonStackView.spacing = 8
        
    }
    
    private func configureLayout() {
        
        thumbnailImageView.snp.makeConstraints { make in
            make.directionalEdges.equalTo(contentView)
        }
        
        buttonStackView.snp.makeConstraints { make in
            make.bottom.equalTo(thumbnailImageView.snp.bottom).inset(12)
            make.centerX.equalTo(contentView.snp.centerX)
            make.width.equalTo(contentView.snp.width).inset(8)
        }
    }
}
