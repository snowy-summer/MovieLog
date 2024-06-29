//
//  TitleHeaderView.swift
//  MovieLog
//
//  Created by 최승범 on 6/26/24.
//

import UIKit
import SnapKit

final class TitleHeaderView: UICollectionReusableView {
    
    private let titleLabel = UILabel()
    private let seeAllButton = UIButton()
    
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

extension TitleHeaderView {
    
    func updateContent(title: String) {
        titleLabel.text = title
    }
    
}

//MARK: - Configuration

extension TitleHeaderView {
    
    private func configureHierarchy() {
        
        addSubview(titleLabel)
        addSubview(seeAllButton)
    }
    
    private func configureUI() {
        
        titleLabel.font = .systemFont(ofSize: 18,
                                      weight: .bold)
        
        seeAllButton.buttonStyle(type: .seeAll)
    }
    
    private func configureLayout() {
        
        titleLabel.snp.makeConstraints { make in
            make.leading.equalTo(self.snp.leading)
            make.verticalEdges.equalTo(self.snp.verticalEdges)
        }
        
        seeAllButton.snp.makeConstraints { make in
            make.trailing.equalTo(self.snp.trailing)
            make.verticalEdges.equalTo(self.snp.verticalEdges)
        }
    }
}

