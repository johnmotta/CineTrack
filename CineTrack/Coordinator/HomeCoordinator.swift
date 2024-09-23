//
//  HomeCoordinator.swift
//  CineTrack
//
//  Created by John on 19/09/24.
//

import UIKit

class HomeCoordinator {
    var navigationController: UINavigationController
    var viewModel: HomeViewModel
    
    required init(navigationController: UINavigationController, viewModel: HomeViewModel) {
        self.navigationController = navigationController
        self.viewModel = viewModel
    }
    
    func start() {
        let homeViewController = HomeViewController(viewModel: viewModel)
        homeViewController.title = "Home"
        homeViewController.tabBarItem.image = UIImage(systemName: "house")
        navigationController.setViewControllers([homeViewController], animated: false)
    }
}
