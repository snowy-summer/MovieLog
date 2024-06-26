//
//  BaseViewController.swift
//  MovieLog
//
//  Created by 최승범 on 6/25/24.
//

import UIKit

class BaseViewController: UIViewController {
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureNavigationBar()
        configureHierarchy()
        configureUI()
        configureLayout()
        configureGestureAndButtonActions()
    }
    
    @available(*,unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureNavigationBar() { }
    func configureHierarchy() { }
    
    func configureUI() {
        view.backgroundColor = .white
    }
    
    func configureGestureAndButtonActions() { }
    func configureLayout() { }
}

class BaseView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    @available(*,unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureNavigationBar() { }
    func configureHierarchy() { }
    func configureUI() { }
    func configureGestureAndButtonActions() { }
    func configureLayout() { }
}
