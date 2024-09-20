//
//  Sections.swift
//  CineTrack
//
//  Created by John on 20/09/24.
//

import Foundation

enum Sections: Int {
    case upcoming
    case popular
    case topRated
    
    var description: String {
        switch self {
        case .upcoming:
            return "Upcoming"
        case .popular:
            return "Popular"
        case .topRated:
            return "Top Rated"
        }
    }
    
    var segmentName: String {
        switch self {
        case .upcoming:
            return "upcoming"
        case .popular:
            return "popular"
        case .topRated:
            return "top_rated"
        }
    }
}
