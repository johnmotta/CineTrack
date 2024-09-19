//
//  HomeViewModel.swift
//  CineTrack
//
//  Created by John on 19/09/24.
//

import UIKit

class HomeViewModel {
    var movie: [Movie]?
    
    var section = Sections.upcoming
    var selectSegment = "Upcoming"
    
    private let upcomming = "upcoming"
    private let popular = "popular"
    private let topRated = "top_rated"
    
    func fetchData(_ collectionView: UICollectionView) {
        switch self.section {
        case .upcoming:
            serviceManager(collectionView, upcomming)
        case .popular:
            serviceManager(collectionView, popular)
        case .topRated:
            serviceManager(collectionView, topRated)
        }
    }
    
    private func serviceManager(_ collectionView: UICollectionView, _ segment: String) {
        ServiceManager.shared.getMovie(segment: segment) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let success):
                self.movie = success
                DispatchQueue.main.async {
                    collectionView.reloadData()
                }

            case .failure(let failure):
                print(failure)
            }
        }
    }
}

enum Sections: Int {
    case upcoming
    case popular
    case topRated
    
    var description: String {
        switch self {
        case .upcoming:
            return "Upcoming"
        case .popular:
            return "Popular"
        case .topRated:
            return "Top Rated"
        }
    }
}
