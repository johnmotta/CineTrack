//
//  MainTabBarCoordinator.swift
//  CineTrack
//
//  Created by John on 20/09/24.
//

import UIKit

class MainTabBarCoordinator: Coordinator {
    var navigationController: UINavigationController

    let viewModel:  HomeViewModel
    
    required init(navigationController: UINavigationController, viewModel: HomeViewModel) {
        self.navigationController = navigationController
        self.viewModel = viewModel
    }
    
    func start() {
        let tabBarController = MainTabViewController()
        
        let homeCoordinator = HomeCoordinator(navigationController: UINavigationController(), viewModel: viewModel)
        homeCoordinator.start()
        
        let searchCoordinator = SearchCoordinator(navigationController: UINavigationController(), viewModel: viewModel)
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
