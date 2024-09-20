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
    
    func fetchData(_ collectionView: UICollectionView) {
        switch self.section {
        case .upcoming:
            serviceManager(collectionView, section.segmentName)
        case .popular:
            serviceManager(collectionView, section.segmentName)
        case .topRated:
            serviceManager(collectionView, section.segmentName)
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
