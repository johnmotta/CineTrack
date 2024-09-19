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
        
        homeScreen.collectionView.delegate = self
        homeScreen.collectionView.dataSource = self
    }
    
    func reloadData() {
        DispatchQueue.main.async { [weak self] in
            self?.homeScreen.collectionView.reloadData()
        }
    }
    
    private func configureNavBar() {
        let segmentedControl = UISegmentedControl(items: [Sections.Upcomming.description, Sections.Popular.description])
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
        case Sections.Upcomming.rawValue:
            viewModel.selectSegment = Sections.Upcomming.description
            viewModel.section = Sections.Upcomming
        case Sections.Popular.rawValue:
            viewModel.selectSegment = Sections.Popular.description
            viewModel.section = Sections.Popular
        default:
            print(#function)
        }
        
        configureViewController(viewModel.selectSegment)
    }
    
    private func configureViewController(_ text: String = "Upcomming") {
        navigationItem.title = text
    }

}

extension HomeViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 20
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MovieCollectionViewCell.identifier, for: indexPath) as? MovieCollectionViewCell else {
            return UICollectionViewCell()
        }
        
        return cell
    }    
}
