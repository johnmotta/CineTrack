//
//  HomeViewController.swift
//  CineTrack
//
//  Created by John on 19/09/24.
//

import UIKit

class HomeViewController: UIViewController {
    
    var movieCollectionView = MovieCollectionView()
    var viewModel: HomeViewModel
    
    init(viewModel: HomeViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        self.view = movieCollectionView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        navigationItem.title = "Upcoming"
        configureNavBar()
        
        self.reloadData()
        
        movieCollectionView.collectionView.delegate = self
        movieCollectionView.collectionView.dataSource = self
        
        viewModel.fetchData(movieCollectionView.collectionView)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.movies = viewModel.movies.map { movie in
            var mutableMovie = movie
            mutableMovie.isFavorite = viewModel.isFavorite(movie: mutableMovie)
            return mutableMovie
        }
        reloadData()
    }
    
    func reloadData() {
        DispatchQueue.main.async { [weak self] in
            self?.movieCollectionView.collectionView.reloadData()
        }
    }
    
    private func configureNavBar() {
        let segmentedControl = UISegmentedControl(items: [Sections.upcoming.description, Sections.popular.description, Sections.topRated.description])
        segmentedControl.selectedSegmentTintColor = .white
        segmentedControl.setTitleTextAttributes([.foregroundColor: UIColor.black], for: .selected)
        segmentedControl.setTitleTextAttributes([.foregroundColor: UIColor.white], for: .normal)
        segmentedControl.backgroundColor = .black
        segmentedControl.layer.borderColor = UIColor.white.cgColor
        segmentedControl.layer.borderWidth = 1.0
        segmentedControl.addTarget(self, action: #selector(segmentChanged(_:)), for: .valueChanged)
        segmentedControl.selectedSegmentIndex = 0
        navigationItem.titleView = segmentedControl
    }
    
    @objc func segmentChanged(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case Sections.upcoming.rawValue:
            viewModel.section = Sections.upcoming
        case Sections.popular.rawValue:
            viewModel.section = Sections.popular
        case Sections.topRated.rawValue:
            viewModel.section = Sections.topRated
        default:
            print(#function)
        }
        
        configureViewController(viewModel.section.description)
        viewModel.fetchData(movieCollectionView.collectionView)
    }
    
    private func configureViewController(_ text: String = "Upcoming") {
        navigationItem.title = text
    }
    
}

extension HomeViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
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
            collectionView.reloadItems(at: [indexPath])
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let movie = viewModel.movies[indexPath.row]
        let detailCoordinator = DetailCoordinator(navigationController: navigationController ?? UINavigationController(), viewModel: viewModel)
        detailCoordinator.setMovie(movie)
        detailCoordinator.start()
    }
}
