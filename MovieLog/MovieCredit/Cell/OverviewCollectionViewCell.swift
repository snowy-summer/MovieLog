//
//  OverviewCollectionViewCell.swift
//  MovieLog
//
//  Created by 최승범 on 6/26/24.
//

import UIKit
import SnapKit

final class OverviewCollectionViewCell: UICollectionViewCell {
    //TODO: - moreButton 수정
    private let overviewLabel = UILabel()
    private let moreImageView = UIImageView()
    private var isExpand = false
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureHierarchy()
        configureUI()
        configureLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func updateContent(data: String) {
        overviewLabel.text = data
    }
    
    func changeCellHeight() {
        isExpand.toggle()
        if isExpand {
            moreImageView.image = UIImage(systemName: "chevron.up")
            overviewLabel.numberOfLines = .zero
        } else {
            moreImageView.image = UIImage(systemName: "chevron.down")
            overviewLabel.numberOfLines = 3
        }
    }
    
}

extension OverviewCollectionViewCell {
    
    private func configureHierarchy() {
        
        contentView.addSubview(overviewLabel)
        contentView.addSubview(moreImageView)
    }
    
    private func configureUI() {
        moreImageView.image = UIImage(systemName: "chevron.down")
        moreImageView.tintColor = .black
        
        overviewLabel.numberOfLines = 3
    }
    
    private func configureLayout() {
        
        overviewLabel.snp.makeConstraints { make in
            make.top.equalTo(contentView.snp.top)
            make.leading.equalTo(contentView.snp.leading)
            make.trailing.equalTo(contentView.snp.trailing)
        }
        
        moreImageView.snp.makeConstraints { make in
            make.top.equalTo(overviewLabel.snp.bottom).offset(4)
            make.bottom.equalTo(contentView.snp.bottom)
            make.centerX.equalTo(contentView.snp.centerX)
            make.width.equalTo(20)
            make.height.equalTo(20)
        }
    }
    
}
