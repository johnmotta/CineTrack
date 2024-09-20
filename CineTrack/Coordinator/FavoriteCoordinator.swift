//
//  FavoriteCoordinator.swift
//  CineTrack
//
//  Created by John on 20/09/24.
//

import UIKit

class FavoriteCoordinator: Coordinator {
    var navigationController: UINavigationController
    
    required init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let favoriteViewController = FavoriteViewController()
        favoriteViewController.title = "Favorite"
        favoriteViewController.tabBarItem.image = UIImage(systemName: "heart")
        navigationController.setViewControllers([favoriteViewController], animated: false)
    }
}
