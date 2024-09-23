//
//  HomeViewModel.swift
//  CineTrack
//
//  Created by John on 19/09/24.
//

import UIKit

class HomeViewModel {
    var movies: [Movie]?
    var favoriteMovies: [Movie]?
    var section = Sections.upcoming

    func toggleFavorite(movie: Movie) {
        if let index = movies?.firstIndex(where: { $0.id == movie.id }) {
            movies?[index].isFavorite?.toggle()
            favoriteMovies = movies?.filter { $0.isFavorite == true }
        }
    }
    
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
            case .success(let movies):
                self.movies = movies.map {
                    var mutableMovie = $0
                    mutableMovie.isFavorite = false
                    return mutableMovie
                }
                DispatchQueue.main.async {
                    collectionView.reloadData()
                }
            case .failure(let failure):
                print(failure)
            }
        }
    }
}
