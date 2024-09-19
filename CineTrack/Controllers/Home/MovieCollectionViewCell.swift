//
//  MovieCollectionViewCell.swift
//  CineTrack
//
//  Created by John on 19/09/24.
//

import UIKit
import SDWebImage

class MovieCollectionViewCell: UICollectionViewCell {
    
    static let identifier: String = String(describing: MovieCollectionViewCell.self)
    
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.image = UIImage(systemName: "photo")?.withRenderingMode(.alwaysTemplate)
        imageView.tintColor = .label
        return imageView
    }()
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 12, weight: .regular)
        label.textAlignment = .natural
        label.numberOfLines = 2
        label.text = "John Doe"
        label.textColor = .label
        return label
    }()
    
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
        contentView.addSubview(nameLabel)
    }
    
    private func configConstraints() {
        let imageViewConstraints = [
            imageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            imageView.heightAnchor.constraint(equalToConstant: 120)
        ]
        
        let nameLabelConstraints = [
            nameLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 4),
            nameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            nameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            nameLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ]
        
        NSLayoutConstraint.activate(imageViewConstraints)
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

}
