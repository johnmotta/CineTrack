//
//  SearchCoordinator.swift
//  CineTrack
//
//  Created by John on 24/09/24.
//

import UIKit

class SearchCoordinator: Coordinator  {
    var navigationController: UINavigationController
    var viewModel: HomeViewModel
    
    required init(navigationController: UINavigationController, viewModel: HomeViewModel) {
        self.navigationController = navigationController
        self.viewModel = viewModel
    }
    
    func start() {
        let viewController = SearchViewController(viewModel: viewModel)
        viewController.title = "Search"
        viewController.tabBarItem.image = UIImage(systemName: "magnifyingglass")
        navigationController.setViewControllers([viewController], animated: false)

    }
}
