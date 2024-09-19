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
    
    func configure(movie: Movie) {
        detailView.configure(with: movie)
    }
}

