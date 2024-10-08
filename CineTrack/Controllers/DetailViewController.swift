//
//  DetailViewController.swift
//  CineTrack
//
//  Created by John on 19/09/24.
//

import UIKit

class DetailViewController: UIViewController {
    var detailView = DetailScreen()
    
    override func loadView() {
        view = detailView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tabBarController?.tabBar.isHidden = true
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        tabBarController?.tabBar.isHidden = false
    }

    
    func configure(movie: Movie, cast: [Cast]) {
        detailView.configure(with: movie, cast: cast)
    }
}

