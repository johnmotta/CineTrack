//
//  HomeViewModel.swift
//  CineTrack
//
//  Created by John on 19/09/24.
//

import Foundation

enum Sections: Int {
    case Upcomming
    case Popular
    
    var description: String {
        switch self {
        case .Upcomming:
            return "Upcomming"
        case .Popular:
            return "Popular"
        }
    }
}

class HomeViewModel {
    var section = Sections.Upcomming
    var selectSegment = "Upcomming"
}
