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
    let title: String?
    let posterPath: String?
    let backdropPath: String?
    let overview: String?
    let voteCount: Int?
    let releaseDate: String?
    let voteAverage: Double
    let genres: [Genre]?
    let runtime: Int?
    var isFavorite: Bool?
    let credits: Credits?
    
    init(empty: Bool = true) {
        self.id = 0
        self.mediaType = nil
        self.originalName = nil
        self.originalTitle = nil
        self.title = nil
        self.posterPath = nil
        self.backdropPath = nil
        self.overview = nil
        self.voteCount = nil
        self.releaseDate = nil
        self.voteAverage = 0.0
        self.genres = nil
        self.runtime = nil
        self.isFavorite = false
        self.credits = nil
    }


    enum CodingKeys: String, CodingKey {
        case id, title, overview, genres, runtime, credits
        case mediaType = "media_type"
        case originalName = "original_name"
        case originalTitle = "original_title"
        case posterPath = "poster_path"
        case backdropPath = "backdrop_path"
        case voteCount = "vote_count"
        case releaseDate = "release_date"
        case voteAverage = "vote_average"
        case isFavorite
    }
}
