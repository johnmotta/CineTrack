//
//  DetailCoordinator.swift
//  CineTrack
//
//  Created by John on 19/09/24.
//

import UIKit

class DetailCoordinator: Coordinator {
    var navigationController: UINavigationController
    private var movie = Movie()
    var viewModel: HomeViewModel
    
    required init(navigationController: UINavigationController, viewModel: HomeViewModel) {
        self.navigationController = navigationController
        self.viewModel = viewModel
    }
    
    func start() {
        let detailVC = DetailViewController()
        detailVC.configure(movie: movie, cast: viewModel.cast)
        navigationController.pushViewController(detailVC, animated: true)
    }
    
    func setMovie(_ movie: Movie) {
        self.movie = movie
    }
}
