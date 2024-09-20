//
//  MovieService.swift
//  CineTrack
//
//  Created by John on 20/09/24.
//

import Foundation

protocol MovieService {
    func getMovie(segment: String, completion: @escaping (Result<[Movie], NetworkError>) -> Void)
}
