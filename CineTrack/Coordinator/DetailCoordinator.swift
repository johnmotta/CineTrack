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
    
    required init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let detailVC = DetailViewController()
        detailVC.configure(movie: movie)
        navigationController.pushViewController(detailVC, animated: true)
    }
    
    func setMovie(_ movie: Movie) {
//        self.movie = movie
    }
}
