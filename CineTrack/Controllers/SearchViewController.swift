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
        
        discoverTable.delegate = self
        discoverTable.dataSource = self
        
        navigationItem.searchController = searchController
        navigationController?.navigationBar.tintColor = .label
        
        viewModel.searchData(discoverTable)
        
        searchController.searchResultsUpdater = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        discoverTable.reloadData()
    }

    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        discoverTable.frame = view.bounds
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
