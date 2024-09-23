//
//  FavoriteCoordinator.swift
//  CineTrack
//
//  Created by John on 20/09/24.
//

import UIKit

class FavoriteCoordinator {
    var navigationController: UINavigationController
    var viewModel: HomeViewModel
    
    required init(navigationController: UINavigationController, viewModel: HomeViewModel) {
        self.navigationController = navigationController
        self.viewModel = viewModel
    }

    func start() {
        let favoriteViewController = FavoriteViewController(viewModel: viewModel)
        favoriteViewController.title = "Favorite"
        favoriteViewController.tabBarItem.image = UIImage(systemName: "heart")
        navigationController.setViewControllers([favoriteViewController], animated: false)
    }
}
