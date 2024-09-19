//
//  HomeViewModel.swift
//  CineTrack
//
//  Created by John on 19/09/24.
//

import Foundation

enum Sections: Int {
    case upcomming
    case popular
    case topRated
    
    var description: String {
        switch self {
        case .upcomming:
            return "Upcomming"
        case .popular:
            return "Popular"
        case .topRated:
            return "Top Rated"
        }
    }
}

class HomeViewModel {
    var section = Sections.upcomming
    var selectSegment = "Upcomming"
}
