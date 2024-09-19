//
//  HomeScreen.swift
//  CineTrack
//
//  Created by John on 19/09/24.
//

import UIKit

class HomeScreen: UIView {
    
    lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: self.createThreeColumnFlowLayout())
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .systemBackground
        collectionView.register(MovieCollectionViewCell.self, forCellWithReuseIdentifier: MovieCollectionViewCell.identifier)
        return collectionView
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupCollectionView()
        setupConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupCollectionView() {
        addSubview(collectionView)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: self.topAnchor),
            collectionView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            collectionView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: self.trailingAnchor)
        ])
    }
    
    private func createThreeColumnFlowLayout() -> UICollectionViewFlowLayout {
        let width = UIScreen.main.bounds.width
        let padding: CGFloat = 16
        let minimumItemSpacing: CGFloat = 10
        let availableWidth = width - (padding * 2) - (minimumItemSpacing * 2)
        let itemWidth = availableWidth / 3
        
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.sectionInset = UIEdgeInsets(top: padding * 2, left: 0, bottom: padding, right: 0)
        flowLayout.minimumInteritemSpacing = minimumItemSpacing
        flowLayout.itemSize = CGSize(width: itemWidth + 10, height: 210)
        
        return flowLayout
    }
}
