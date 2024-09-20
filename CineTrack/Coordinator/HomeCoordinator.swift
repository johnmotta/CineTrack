//
//  HomeCoordinator.swift
//  CineTrack
//
//  Created by John on 19/09/24.
//

import UIKit

class HomeCoordinator: Coordinator {
    var navigationController: UINavigationController
    
    required init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let homeViewController = HomeViewController()
        homeViewController.title = "Home"
        homeViewController.tabBarItem.image = UIImage(systemName: "house")
        navigationController.setViewControllers([homeViewController], animated: false)
    }
}
