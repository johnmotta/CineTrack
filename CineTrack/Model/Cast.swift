//
//  Cast.swift
//  CineTrack
//
//  Created by John Motta on 08/10/24.
//

import Foundation

struct Credits: Codable {
    let cast: [Cast]
}

struct Cast: Codable {
    let id: Int
    let name: String
    let character: String
    let profilePath: String?

    enum CodingKeys: String, CodingKey {
        case id, name, character
        case profilePath = "profile_path"
    }
}
