//
//  MainTabBarCoordinator.swift
//  CineTrack
//
//  Created by John on 20/09/24.
//

import UIKit

class MainTabBarCoordinator: Coordinator {
    var navigationController: UINavigationController
    
    required init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let tabBarController = MainTabViewController()
        
        let homeCoordinator = HomeCoordinator(navigationController: UINavigationController())
        homeCoordinator.start()
        
        let favoriteCoordinator = FavoriteCoordinator(navigationController: UINavigationController())
        favoriteCoordinator.start()
        
        tabBarController.viewControllers = [
            homeCoordinator.navigationController,
            favoriteCoordinator.navigationController
        ]
        
        navigationController.pushViewController(tabBarController, animated: true)
    }
}
