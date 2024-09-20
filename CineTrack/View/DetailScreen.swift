//
//  DetailScreen.swift
//  CineTrack
//
//  Created by John on 19/09/24.
//

import UIKit
import SDWebImage

class DetailScreen: UIView {
    
    private let imageView = ImageDefault(clipsToBounds: true)
    
    private let titleLabel = LabelDefault(fontSize: 16, fontWeight: .bold)
    private let yearReleaseLabel = LabelDefault(fontSize: 16, fontWeight: .light, opacity: 0.8)
    private let durationLabel = LabelDefault(fontSize: 16, fontWeight: .light, opacity: 0.8)
    private let descriptionLabel = LabelDefault(fontSize: 16, fontWeight: .light, opacity: 0.8)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .systemBackground
        addElements()
        configConstraints()
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
    
    private func configConstraints() {
        let padding: CGFloat = 8
        
        let imageViewConstraints = [
            imageView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            imageView.centerXAnchor.constraint(equalTo: centerXAnchor),
            imageView.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.4),
            imageView.widthAnchor.constraint(equalTo: widthAnchor),
        ]
        
        let titleLabelConstraints = [
            titleLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: padding),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: padding),
        ]
        
        let yearReleaseLabelConstraints = [
            yearReleaseLabel.topAnchor.constraint(equalTo: titleLabel.topAnchor),
            yearReleaseLabel.leadingAnchor.constraint(equalTo: titleLabel.trailingAnchor, constant: padding),
        ]
        
        let durationLabelConstraints = [
            durationLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: padding),
            durationLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
        ]
        
        let descriptionLabelConstraints = [
            descriptionLabel.topAnchor.constraint(equalTo: durationLabel.bottomAnchor, constant: padding),
            descriptionLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            descriptionLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -padding),
        ]
        
        NSLayoutConstraint.activate(imageViewConstraints)
        NSLayoutConstraint.activate(titleLabelConstraints)
        NSLayoutConstraint.activate(yearReleaseLabelConstraints)
        NSLayoutConstraint.activate(durationLabelConstraints)
        NSLayoutConstraint.activate(descriptionLabelConstraints)
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

