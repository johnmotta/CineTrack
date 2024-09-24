//
//  MainTabBarCoordinator.swift
//  CineTrack
//
//  Created by John on 20/09/24.
//

import UIKit

class MainTabBarCoordinator: Coordinator {
    var navigationController: UINavigationController

    let viewModel = HomeViewModel()
    
    required init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let tabBarController = MainTabViewController()
        
        let homeCoordinator = HomeCoordinator(navigationController: UINavigationController(), viewModel: viewModel)
        homeCoordinator.start()
        
        let searchCoordinator = SearchCoordinator(navigationController: UINavigationController())
        searchCoordinator.start()
        
        let favoriteCoordinator = FavoriteCoordinator(navigationController: UINavigationController(), viewModel: viewModel)
        favoriteCoordinator.start()
        
        tabBarController.viewControllers = [
            homeCoordinator.navigationController,
            searchCoordinator.navigationController,
            favoriteCoordinator.navigationController
        ]
        
        navigationController.pushViewController(tabBarController, animated: true)
    }
}
