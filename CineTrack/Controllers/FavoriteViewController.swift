//
//  FavoriteViewController.swift
//  CineTrack
//
//  Created by John on 20/09/24.
//

import UIKit

class FavoriteViewController: UIViewController {
    
    var viewModel: HomeViewModel
    
    private let favoriteFeedTable: UITableView = {
        let table = UITableView()
        table.register(FavoriteTableViewCell.self, forCellReuseIdentifier: FavoriteTableViewCell.identifier)
        return table
    }()
    
    
    init(viewModel: HomeViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(favoriteFeedTable)
        favoriteFeedTable.delegate = self
        favoriteFeedTable.dataSource = self
        
        reloadFavorites()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        reloadFavorites()
    }
    
    private func reloadFavorites() {
        DispatchQueue.main.async {
            self.favoriteFeedTable.reloadData()
        }
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        favoriteFeedTable.frame = view.bounds
    }
}

extension FavoriteViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.favoriteMovies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: FavoriteTableViewCell.identifier, for: indexPath) as? FavoriteTableViewCell else {
            return UITableViewCell()
        }
        let movie = viewModel.favoriteMovies[indexPath.row]
        let isFavorite = viewModel.isFavorite(movie: movie)
        cell.configure(with: movie, isFavorite: isFavorite)
        cell.onFavoriteTapped = { [weak self] in
            guard let self = self else { return }
            self.viewModel.removeFavorite(indexPah: indexPath)
            print("Atualizando favoritos...")
            self.reloadFavorites()
        }
        cell.selectionStyle = .none
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
