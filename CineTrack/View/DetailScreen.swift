//
//  DetailScreen.swift
//  CineTrack
//
//  Created by John on 19/09/24.
//

import UIKit

class DetailScreen: UIView {
    
    private let scrollView = UIScrollView()
    private let contentView = UIView()
    
    private let imageView = ImageDefault(clipsToBounds: true)
    
    private let titleStack = UIStackView()
    private let titleLabel = LabelDefault(fontSize: 20, fontWeight: .bold)
    private let yearReleaseLabel = LabelDefault(fontSize: 16, fontWeight: .light, opacity: 0.8)
    
    private let infoStack = UIStackView()
    private let durationLabel = LabelDefault(fontSize: 16, fontWeight: .light, opacity: 0.8)
    private let genreLabel = LabelDefault(fontSize: 16, fontWeight: .light, opacity: 0.8)
    
    private let descriptionLabel = LabelDefault(fontSize: 16, fontWeight: .light, opacity: 0.8)
    
    private let trailerButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Assista o trailer do filme", for: .normal)
        button.backgroundColor = .black
        button.layer.cornerRadius = 8
        button.titleLabel?.font = .systemFont(ofSize: 16)
        button.addTarget(self, action: #selector(trailerButtonTapped), for: .touchUpInside)
        return button
    }()

    private let castCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 16
        layout.itemSize = CGSize(width: 120, height: 160)

        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.showsHorizontalScrollIndicator = false
        cv.backgroundColor = .clear
        return cv
    }()
    
    private var cast: [Cast] = []

    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .systemBackground

        setupLayout()
        configConstraints()

        castCollectionView.delegate = self
        castCollectionView.dataSource = self
        castCollectionView.register(CastCollectionViewCell.self, forCellWithReuseIdentifier: CastCollectionViewCell.identifier)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupLayout() {
        addSubview(scrollView)
        scrollView.addSubview(contentView)

        titleStack.axis = .horizontal
        titleStack.spacing = 8
        titleStack.addArrangedSubview(titleLabel)
        titleStack.addArrangedSubview(yearReleaseLabel)
        
        infoStack.axis = .horizontal
        infoStack.spacing = 8
        infoStack.addArrangedSubview(durationLabel)
        infoStack.addArrangedSubview(genreLabel)
        
        contentView.addSubview(imageView)
        contentView.addSubview(titleStack)
        contentView.addSubview(infoStack)
        contentView.addSubview(descriptionLabel)
        contentView.addSubview(trailerButton)

        contentView.addSubview(castCollectionView)
    }

    private func configConstraints() {
        let padding: CGFloat = 8

        scrollView.translatesAutoresizingMaskIntoConstraints = false
        contentView.translatesAutoresizingMaskIntoConstraints = false
        titleStack.translatesAutoresizingMaskIntoConstraints = false
        infoStack.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: bottomAnchor),

            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),

            imageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            imageView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            imageView.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 0.4),
            imageView.widthAnchor.constraint(equalTo: contentView.widthAnchor),

            titleStack.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: padding),
            titleStack.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: padding),

            infoStack.topAnchor.constraint(equalTo: titleStack.bottomAnchor, constant: padding),
            infoStack.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: padding),
            infoStack.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -padding),

            descriptionLabel.topAnchor.constraint(equalTo: infoStack.bottomAnchor, constant: padding),
            descriptionLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: padding),
            descriptionLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -padding),

            trailerButton.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: padding),
            trailerButton.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            trailerButton.widthAnchor.constraint(equalToConstant: 200),
            trailerButton.heightAnchor.constraint(equalToConstant: 40),

            castCollectionView.topAnchor.constraint(equalTo: trailerButton.bottomAnchor, constant: padding),
            castCollectionView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            castCollectionView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            castCollectionView.heightAnchor.constraint(equalToConstant: 160),

            castCollectionView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -padding)
        ])
    }

    func configure(with movie: Movie, cast: [Cast]) {
        if let posterPath = movie.backdropPath {
            let urlString = "https://image.tmdb.org/t/p/w500/\(posterPath)"
            imageView.sd_setImage(with: URL(string: urlString))
        } else {
            imageView.image = UIImage(systemName: "photo")
        }
        
        titleLabel.text = movie.originalTitle
        yearReleaseLabel.text = dateFormatter(dateString: movie.releaseDate ?? "")
        durationLabel.text = formatDuration(minutes: movie.runtime ?? 0)
        genreLabel.text = formatGenres(genres: movie.genres ?? [])
        descriptionLabel.text = movie.overview
        
        self.cast = cast
        castCollectionView.reloadData()
    }
    
    private func formatDuration(minutes: Int) -> String {
        let hours = minutes / 60
        let remainingMinutes = minutes % 60
        return "\(hours)h \(remainingMinutes)m"
    }

    private func formatGenres(genres: [Genre]) -> String {
        return genres.map { $0.name }.joined(separator: ", ")
    }
    
    @objc private func trailerButtonTapped() {}
    
    func dateFormatter(dateString: String) -> String? {
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

extension DetailScreen: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return cast.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CastCollectionViewCell.identifier, for: indexPath) as? CastCollectionViewCell else {
            return UICollectionViewCell()
        }
        cell.configure(with: cast[indexPath.row])
        return cell
    }
}
