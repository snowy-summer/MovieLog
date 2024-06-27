//
//  BaseView.swift
//  MovieLog
//
//  Created by 최승범 on 6/27/24.
//

import UIKit

class BaseView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)

        configureHierarchy()
        configureUI()
        configureGestureAndButtonActions()
        configureCollectionView()
        configureLayout()
        
    }
    
    @available(*,unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

    func configureHierarchy() { }
    func configureUI() { }
    func configureGestureAndButtonActions() { }
    func configureCollectionView() { }
    func configureLayout() { }
}
