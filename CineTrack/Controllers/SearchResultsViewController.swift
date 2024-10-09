//
//  SearchResultsViewController.swift
//  CineTrack
//
//  Created by John on 24/09/24.
//

import UIKit

protocol SearchResultsViewControllerDelegate: AnyObject {
    func searchResultsViewController(_ controller: SearchResultsViewController, didSelectMovie movie: Movie)
}


class SearchResultsViewController: UIViewController {
    
    var viewModel: HomeViewModel

    weak var delegate: SearchResultsViewControllerDelegate?

    
    public let searchScreen = MovieCollectionView()
    
    init(viewModel: HomeViewModel = HomeViewModel()) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        view.addSubview(searchScreen)
           
        self.reloadData()
        
        searchScreen.collectionView.delegate = self
        searchScreen.collectionView.dataSource = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        reloadData()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        searchScreen.frame = view.bounds
    }
    
    func reloadData() {
        DispatchQueue.main.async { [weak self] in
            self?.searchScreen.collectionView.reloadData()
        }
    }
}


extension SearchResultsViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.movies.count
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MovieCollectionViewCell.identifier, for: indexPath) as? MovieCollectionViewCell else {
            return UICollectionViewCell()
        }
        
        let movie = viewModel.movies[indexPath.row]
        let isFavorite = viewModel.isFavorite(movie: movie)
        cell.configure(with: movie, isFavorite: isFavorite)
        cell.onFavoriteTapped = { [weak self] in
            guard let self = self else { return }
            self.viewModel.toggleFavorite(movie: movie, indexPath: indexPath)
            searchScreen.collectionView.reloadItems(at: [indexPath])
        }
        return cell
    }
     
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let movie = viewModel.movies[indexPath.row]
        
        viewModel.fetchCast(movieId: movie.id) {
            DispatchQueue.main.async {
                self.delegate?.searchResultsViewController(self, didSelectMovie: movie)
            }
        }
    }
}
