//
//  HomeViewController.swift
//  CineTrack
//
//  Created by John on 19/09/24.
//

import UIKit

class HomeViewController: UIViewController {
    
    var homeScreen = HomeScreen()
    var viewModel = HomeViewModel()
    
    override func loadView() {
        self.view = homeScreen
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        
        configureNavBar()
        
        self.reloadData()
        
        homeScreen.collectionView.delegate = self
        homeScreen.collectionView.dataSource = self
        
        viewModel.fetchData(homeScreen.collectionView)
    }
    
    func reloadData() {
        DispatchQueue.main.async { [weak self] in
            self?.homeScreen.collectionView.reloadData()
        }
    }
    
    private func configureNavBar() {
        let segmentedControl = UISegmentedControl(items: [Sections.upcomming.description, Sections.popular.description, Sections.topRated.description])
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
        case Sections.upcomming.rawValue:
            viewModel.selectSegment = Sections.upcomming.description
            viewModel.section = Sections.upcomming
        case Sections.popular.rawValue:
            viewModel.selectSegment = Sections.popular.description
            viewModel.section = Sections.popular
        case Sections.topRated.rawValue:
            viewModel.selectSegment = Sections.topRated.description
            viewModel.section = Sections.topRated
        default:
            print(#function)
        }
        
        configureViewController(viewModel.selectSegment)
        viewModel.fetchData(homeScreen.collectionView)
    }
    
    private func configureViewController(_ text: String = "Upcomming") {
        navigationItem.title = text
    }

}

extension HomeViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.movie?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MovieCollectionViewCell.identifier, for: indexPath) as? MovieCollectionViewCell else {
            return UICollectionViewCell()
        }
        
        if let movie = viewModel.movie?[indexPath.row] {
            cell.configure(with: movie)
        }
        
        return cell
    }
}
