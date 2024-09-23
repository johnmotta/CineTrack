//
//  HomeViewController.swift
//  CineTrack
//
//  Created by John on 19/09/24.
//

import UIKit

class HomeViewController: UIViewController {
    
    var homeScreen = HomeScreen()
    var viewModel: HomeViewModel
    
    init(viewModel: HomeViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        self.view = homeScreen
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        navigationItem.title = "Upcoming"
        configureNavBar()
        
        self.reloadData()
        
        homeScreen.collectionView.delegate = self
        homeScreen.collectionView.dataSource = self
        
        viewModel.fetchData(homeScreen.collectionView)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        reloadData()
    }
    
    func reloadData() {
        DispatchQueue.main.async { [weak self] in
            self?.homeScreen.collectionView.reloadData()
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
        viewModel.fetchData(homeScreen.collectionView)
    }
    
    private func configureViewController(_ text: String = "Upcoming") {
        navigationItem.title = text
    }
    
}

extension HomeViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.movies?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MovieCollectionViewCell.identifier, for: indexPath) as? MovieCollectionViewCell else {
            return UICollectionViewCell()
        }
        
        if let movie = viewModel.movies?[indexPath.row] {
            cell.configure(with: movie)
            cell.onFavoriteTapped = { [weak self] in
                guard let self = self else { return }
                self.viewModel.toggleFavorite(movie: movie)
                collectionView.reloadItems(at: [indexPath])
            }
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let movie = viewModel.movies?[indexPath.row] {
            let detailCoordinator = DetailCoordinator(navigationController: navigationController ?? UINavigationController())
            detailCoordinator.setMovie(movie)
            detailCoordinator.start()
        }
    }
}
