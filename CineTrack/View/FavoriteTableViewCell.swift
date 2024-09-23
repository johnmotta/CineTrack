//
//  FavoriteTableViewCell.swift
//  CineTrack
//
//  Created by John on 23/09/24.
//

import UIKit

class FavoriteTableViewCell: UITableViewCell {
    
    static let identifier = String(describing: FavoriteTableViewCell.self)
    
    let image = ImageDefault(clipsToBounds: true)
    let titleLabel = LabelDefault(fontSize: 14, fontWeight: .bold)
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        addElements()
        configConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func addElements() {
        contentView.addSubview(image)
        contentView.addSubview(titleLabel)
    }
    
    private func configConstraints() {
        image.contentMode = .scaleAspectFit
        let imageConstraints = [
            image.topAnchor.constraint(equalTo: topAnchor),
            image.leadingAnchor.constraint(equalTo: leadingAnchor),
            image.bottomAnchor.constraint(equalTo: bottomAnchor),
            image.heightAnchor.constraint(equalToConstant: 150),
            image.widthAnchor.constraint(equalToConstant: 100)
        ]
        
        let titleLabelConstraints = [
            titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            titleLabel.leadingAnchor.constraint(equalTo: image.trailingAnchor, constant: 20),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
            titleLabel.bottomAnchor.constraint(equalTo: bottomAnchor)
        ]
        
        NSLayoutConstraint.activate(imageConstraints)
        NSLayoutConstraint.activate(titleLabelConstraints)
    }
    
    func configure(with movie: Movie) {
        if let posterPath = movie.posterPath {
            guard let url = URL(string: "https://image.tmdb.org/t/p/w500/\(posterPath)") else {
                image.image = UIImage(systemName: "photo")
                return
            }
            image.sd_setImage(with: url)
        } else {
            image.image = UIImage(systemName: "photo")
        }
        
        
        if let originalName = movie.originalName {
            titleLabel.text = originalName
            
        } else if let titleName = movie.originalTitle {
            titleLabel.text = titleName
        } else {
            titleLabel.text = "None"
        }
    }
}
