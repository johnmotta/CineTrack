//
//  SearchCoordinator.swift
//  CineTrack
//
//  Created by John on 24/09/24.
//

import UIKit

class SearchCoordinator: Coordinator {
    var navigationController: UINavigationController
    
    required init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let viewController = SearchViewController()
        viewController.title = "Search"
        viewController.tabBarItem.image = UIImage(systemName: "magnifyingglass")
        navigationController.setViewControllers([viewController], animated: false)

    }
}
