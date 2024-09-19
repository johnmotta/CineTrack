//
//  Movie.swift
//  CineTrack
//
//  Created by John on 19/09/24.
//

import Foundation

struct Movie: Codable {
    let id: Int
    let mediaType: String?
    let originalName: String?
    let originalTitle: String?
    let posterPath: String?
    let overview: String?
    let voteCount: Int?
    let releaseDate: String?
    let voteAverage: Double
    let genreIds: [Int]?

    init(
        id: Int = 0,
        mediaType: String? = nil,
        originalName: String? = nil,
        originalTitle: String? = nil,
        posterPath: String? = nil,
        overview: String? = nil,
        voteCount: Int? = nil,
        releaseDate: String? = nil,
        voteAverage: Double = 0.0,
        genreIds: [Int]? = nil
    ) {
        self.id = id
        self.mediaType = mediaType
        self.originalName = originalName
        self.originalTitle = originalTitle
        self.posterPath = posterPath
        self.overview = overview
        self.voteCount = voteCount
        self.releaseDate = releaseDate
        self.voteAverage = voteAverage
        self.genreIds = genreIds
    }

    enum CodingKeys: String, CodingKey {
        case id
        case mediaType = "media_type"
        case originalName = "original_name"
        case originalTitle = "original_title"
        case posterPath = "poster_path"
        case overview
        case voteCount = "vote_count"
        case releaseDate = "release_date"
        case voteAverage = "vote_average"
        case genreIds = "genre_ids"
    }
}
