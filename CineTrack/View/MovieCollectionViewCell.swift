//
//  MovieCollectionViewCell.swift
//  CineTrack
//
//  Created by John on 19/09/24.
//

import UIKit
import SDWebImage

class MovieCollectionViewCell: UICollectionViewCell {
    
    var isFavorited = false
    
    static let identifier: String = String(describing: MovieCollectionViewCell.self)
    
    private let imageView = ImageDefault()
    
    private let favoriteButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(systemName: "star"), for: .normal)
        button.tintColor = .systemGray
        button.addTarget(self, action: #selector(favoriteTapped), for: .touchUpInside)
        return button
    }()
    
    private let nameLabel = LabelDefault(fontSize: 12, fontWeight: .regular, numberOfLines: 2)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addElements()
        configConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func addElements() {
        contentView.addSubview(imageView)
        contentView.addSubview(favoriteButton)
        contentView.addSubview(nameLabel)
    }
    
    private func configConstraints() {
        let imageViewConstraints = [
            imageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            imageView.heightAnchor.constraint(equalToConstant: 120)
        ]
        
        let favoriteButtonConstraints = [
            favoriteButton.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 4),
            favoriteButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -4),
            favoriteButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ]
        
        let nameLabelConstraints = [
            nameLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 4),
            nameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            nameLabel.trailingAnchor.constraint(equalTo: favoriteButton.leadingAnchor),
            nameLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ]
        
        NSLayoutConstraint.activate(imageViewConstraints)
        NSLayoutConstraint.activate(favoriteButtonConstraints)
        NSLayoutConstraint.activate(nameLabelConstraints)
    }
    
    func configure(with movie: Movie) {
        if let posterPath = movie.posterPath {
            guard let url = URL(string: "https://image.tmdb.org/t/p/w500/\(posterPath)") else {
                imageView.image = UIImage(systemName: "photo")
                return
            }
            imageView.sd_setImage(with: url)
        } else {
            imageView.image = UIImage(systemName: "photo")
        }
        
        
        if let originalName = movie.originalName {
            nameLabel.text = originalName
            
        } else if let titleName = movie.originalTitle {
            nameLabel.text = titleName
        } else {
            nameLabel.text = "None"
        }
    }
    
    @objc func favoriteTapped() {
        isFavorited.toggle()
        
        let imageName = isFavorited ? "star.fill" : "star"
        let tintColor = isFavorited ? UIColor.systemYellow : UIColor.gray
        
        favoriteButton.setImage(UIImage(systemName: imageName), for: .normal)
        favoriteButton.tintColor = tintColor
    }
}
