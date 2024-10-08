//
//  CastCollectionViewCell.swift
//  CineTrack
//
//  Created by John Motta on 08/10/24.
//

import UIKit

class CastCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "CastCollectionViewCell"
    
    private let imageView = UIImageView()
    private let nameLabel = UILabel()
    private let characterLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(imageView)
        contentView.addSubview(nameLabel)
        contentView.addSubview(characterLabel)
        
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        
        nameLabel.font = UIFont.systemFont(ofSize: 14, weight: .bold)
        nameLabel.textAlignment = .center
        nameLabel.numberOfLines = 2
        
        characterLabel.font = UIFont.systemFont(ofSize: 12, weight: .light)
        characterLabel.textAlignment = .center
        characterLabel.textColor = .gray
        characterLabel.numberOfLines = 2
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        characterLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            imageView.heightAnchor.constraint(equalToConstant: 100),
            
            nameLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 4),
            nameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            nameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            
            characterLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 2),
            characterLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            characterLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
        ])
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func configure(with cast: Cast) {
        let urlString = "https://image.tmdb.org/t/p/w500/\(cast.profilePath ?? "")"
        imageView.sd_setImage(with: URL(string: urlString), placeholderImage: UIImage(systemName: "person.circle"))
        nameLabel.text = cast.name
        characterLabel.text = cast.character
    }
}
