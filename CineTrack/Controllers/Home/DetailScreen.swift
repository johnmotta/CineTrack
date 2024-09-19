//
//  DetailScreen.swift
//  CineTrack
//
//  Created by John on 19/09/24.
//

import UIKit
import SDWebImage

class DetailScreen: UIView {
    
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 16, weight: .bold)
        label.textAlignment = .left
        label.textColor = .label
        return label
    }()
    
    private let yearReleaseLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 16, weight: .light)
        label.textAlignment = .left
        label.textColor = .label
        label.alpha = 0.8
        return label
    }()
    
    private let durationLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 16, weight: .light)
        label.textAlignment = .left
        label.textColor = .label
        label.alpha = 0.8
        return label
    }()
    
    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 16, weight: .light)
        label.textAlignment = .left
        label.numberOfLines = 20
        label.textColor = .label
        label.alpha = 0.8
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .systemBackground
        addElements()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func addElements() {
        addSubview(imageView)
        addSubview(titleLabel)
        addSubview(yearReleaseLabel)
        addSubview(durationLabel)
        addSubview(descriptionLabel)
    }
    
    private func setConstraints() {
        let padding: CGFloat = 8
        
        
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: topAnchor),
            imageView.centerXAnchor.constraint(equalTo: centerXAnchor),
            imageView.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.4),
            imageView.widthAnchor.constraint(equalTo: widthAnchor),
            
            titleLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: padding * 2),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: padding),

            yearReleaseLabel.topAnchor.constraint(equalTo: titleLabel.topAnchor),
            yearReleaseLabel.leadingAnchor.constraint(equalTo: titleLabel.trailingAnchor, constant: padding),
            
            durationLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: padding * 2),
            durationLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
                        
            descriptionLabel.topAnchor.constraint(equalTo: durationLabel.bottomAnchor, constant: padding * 2),
            descriptionLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            descriptionLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -padding),
        ])
    }
    
    func configure(with movie: Movie) {
        if let posterPath = movie.posterPath {
            let urlString = "https://image.tmdb.org/t/p/w500/\(posterPath)"
            if let url = URL(string: urlString) {
                imageView.sd_setImage(with: url)
            } else {
                imageView.image = UIImage(systemName: "photo")
            }
        } else {
            imageView.image = UIImage(systemName: "photo")
        }
        
        titleLabel.text = movie.originalTitle
        yearReleaseLabel.text = dateFormatter(dateString: movie.releaseDate ?? "")
        descriptionLabel.text = movie.overview
    }
    
    func dateFormatter(dateString: String) -> String? {
        let dateString = dateString
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"

        if let date = dateFormatter.date(from: dateString) {
            let calendar = Calendar.current
            let year = calendar.component(.year, from: date)
            return String(year)
        }
        return nil
    }
}

