//
//  UserTabBarController.swift
//  MovieLog
//
//  Created by 최승범 on 6/27/24.
//

import UIKit

final class UserTabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureTabBar()
        configureTabBarItem()
        
    }
    
    private func configureTabBar() {
        
        tabBar.tintColor = .baseFont
        tabBar.unselectedItemTintColor = .lightGray
    }
    
    private func configureTabBarItem() {
        
        let homeViewController = HomeViewController()
        let homeNavigationController = UINavigationController(rootViewController: homeViewController)
        homeNavigationController.tabBarItem = UITabBarItem(title: "홈",
                                                           image: UIImage(systemName: "house"),
                                                           tag: 0)
        
        setViewControllers([homeNavigationController],
                           animated: false)
    }
}
