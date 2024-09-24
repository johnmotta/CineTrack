//
//  HomeViewModel.swift
//  CineTrack
//
//  Created by John on 19/09/24.
//

import UIKit

class HomeViewModel {
    var movies: [Movie] = []
    var favoriteMovies: [Movie] = []
    var section = Sections.upcoming
    
    func toggleFavorite(movie: Movie, indexPath: IndexPath) {
        let row = indexPath.row
        movies[row].isFavorite?.toggle()
        
        if movies[row].isFavorite == true {
            favoriteMovies.append(movies[row])
        }
        
        if movies[row].isFavorite == false {
            if let index = favoriteMovies.firstIndex(where: { $0.id == movies[row].id }) {
                favoriteMovies.remove(at: index)
            }
        }
    }
    
    func removeFavorite(indexPah: IndexPath) {
        favoriteMovies.remove(at: indexPah.row)
    }

    func isFavorite(movie: Movie) -> Bool {
        return favoriteMovies.contains { $0.id == movie.id }
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
            guard let self else { return }
            switch result {
            case .success(let movies):
                self.movies = movies.map {
                    var mutableMovie = $0
                    mutableMovie.isFavorite = self.isFavorite(movie: mutableMovie)
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
    
    func searchData(_ tableView: UITableView) {
        ServiceManager.shared.getDiscoverMovies { [weak self] result in
            guard let self else { return }
            switch result {
            case .success(let movies):
                self.movies = movies.map {
                    var mutableMovie = $0
                    mutableMovie.isFavorite = self.isFavorite(movie: mutableMovie)
                    return mutableMovie
                }
                DispatchQueue.main.async {
                    tableView.reloadData()
                }
            case .failure(let failure):
                print(failure)
            }
        }
    }
    
    func search(query: String) {
        ServiceManager.shared.search(with: query) { result in
            switch result {
            case .success(let movies):
                self.movies = movies.map {
                    var mutableMovie = $0
                    mutableMovie.isFavorite = self.isFavorite(movie: mutableMovie)
                    return mutableMovie
                }
            case .failure(let failure):
                print(failure)
            }
        }
    }
}
