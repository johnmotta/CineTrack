//
//  SearchViewController.swift
//  CineTrack
//
//  Created by John on 24/09/24.
//

import UIKit

class SearchViewController: UIViewController {
    
    private let discoverTable: UITableView = {
        let table = UITableView()
        table.register(FavoriteTableViewCell.self, forCellReuseIdentifier: FavoriteTableViewCell.identifier)
        return table
    }()
    
    var viewModel: HomeViewModel
    
    
    init(viewModel: HomeViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    private let searchController: UISearchController = {
        let controller = UISearchController(searchResultsController: SearchResultsViewController())
        controller.searchBar.placeholder = "Search for a movie"
        controller.searchBar.searchBarStyle = .minimal
        return controller
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        
        view.addSubview(discoverTable)
        
        self.reloadData()
        
        discoverTable.delegate = self
        discoverTable.dataSource = self
        
        navigationItem.searchController = searchController
        navigationController?.navigationBar.tintColor = .label
                
        searchController.searchResultsUpdater = self
        
        if let searchResultsController = searchController.searchResultsController as? SearchResultsViewController {
            searchResultsController.delegate = self
        }

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        reloadData()
    }

    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        discoverTable.frame = view.bounds
    }
    
    private func reloadData() {
        DispatchQueue.main.async { [weak self] in
            self?.discoverTable.reloadData()
        }
    }
}


extension SearchViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.movies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: FavoriteTableViewCell.identifier) as? FavoriteTableViewCell else {
            return UITableViewCell()
        }
        
        let movie = viewModel.movies[indexPath.row]
        let isFavorite = viewModel.isFavorite(movie: movie)
        cell.configure(with: movie, isFavorite: isFavorite)
        cell.onFavoriteTapped = { [weak self] in
            guard let self = self else { return }
            self.viewModel.toggleFavorite(movie: movie, indexPath: indexPath)
            tableView.reloadData()
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let movie = viewModel.movies[indexPath.row]
        
        viewModel.fetchCast(movieId: movie.id) {
            DispatchQueue.main.async {
                let detailCoordinator = DetailCoordinator(navigationController: self.navigationController ?? UINavigationController(), viewModel: self.viewModel)
                detailCoordinator.setMovie(movie)
                detailCoordinator.start()
            }
        }
    }
}

extension SearchViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        let searchBar = searchController.searchBar
        guard let query = searchBar.text,
              !query.trimmingCharacters(in: .whitespaces).isEmpty,
              query.trimmingCharacters(in: .whitespaces).count >= 3,
              let resultsController = searchController.searchResultsController as? SearchResultsViewController else {
            return
        }
        
        viewModel.search(query: query)
        resultsController.viewModel = viewModel
        DispatchQueue.main.async {
            resultsController.searchScreen.collectionView.reloadData()
        }
    }
}

extension SearchViewController: SearchResultsViewControllerDelegate {
    func searchResultsViewController(_ controller: SearchResultsViewController, didSelectMovie movie: Movie) {
        viewModel.fetchCast(movieId: movie.id) {
            DispatchQueue.main.async {
                guard let navigationController = self.navigationController else {
                    print("NavigationController is nil")
                    return
                }
                let detailCoordinator = DetailCoordinator(navigationController: navigationController, viewModel: self.viewModel)
                detailCoordinator.setMovie(movie)
                detailCoordinator.start()
            }
        }
    }
}
