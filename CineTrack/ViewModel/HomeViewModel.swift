//
//  HomeViewModel.swift
//  CineTrack
//
//  Created by John on 19/09/24.
//

import UIKit

class HomeViewModel {
    var movie: [Movie]?
    
    var section = Sections.upcomming
    var selectSegment = "Upcomming"
    
    func fetchData(_ collectionView: UICollectionView) {
        switch self.section {
        case .upcomming:
            ServiceManager.shared.getUpcommingMovie { [weak self] result in
                guard let self = self else { return }
                switch result {
                case .success(let success):
                    self.movie = success
                    self.reload(collectionView)
                case .failure(let failure):
                    print(failure)
                }
                DispatchQueue.main.async {
                    collectionView.reloadData()
                }
                
            }
        case .popular: break
        case .topRated: break
        }
    }
    
    private func reload(_ collectionView: UICollectionView) {
        DispatchQueue.main.async {
            collectionView.reloadData()
        }
        
    }
}

enum Sections: Int {
    case upcomming
    case popular
    case topRated
    
    var description: String {
        switch self {
        case .upcomming:
            return "Upcomming"
        case .popular:
            return "Popular"
        case .topRated:
            return "Top Rated"
        }
    }
}
