//
//  ServiceManager.swift
//  CineTrack
//
//  Created by John on 19/09/24.
//

import Foundation

class ServiceManager {
    
    static let shared = ServiceManager()
    
    func getUpcommingMovie(completion: @escaping (Result<[Movie], NetworkError>) -> Void) {
        let urlString = "\(Constants.baseURL)/3/movie/upcoming?api_key=\(Constants.API)&language=en-US&page=1"
        
        guard let url = URL(string: urlString) else {
            completion(.failure(.invalidURL(urlString)))
            return
        }
        
        let session = URLSession.shared
        
        let task = session.dataTask(with: url) { data, _, error in
            if let error {
                completion(.failure(.networkFailure(error)))
                return
            }
            
            guard let data else {
                completion(.failure(.noData))
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let result = try decoder.decode(MoviesResponse.self, from: data)
                completion(.success(result.results))
            } catch {
                completion(.failure(.decodingError(error)))
            }
        }
        task.resume()
    }
    
    func getPopularMovie(completion: @escaping (Result<[Movie], NetworkError>) -> Void) {
        let urlString = "\(Constants.baseURL)/3/movie/popular?api_key=\(Constants.API)&language=en-US&page=1"

        guard let url = URL(string: urlString) else {
            completion(.failure(.invalidURL(urlString)))
            return
        }
        
        let session = URLSession.shared
        
        let task = session.dataTask(with: url) { data, _, error in
            if let error {
                completion(.failure(.networkFailure(error)))
                return
            }
            
            guard let data else {
                completion(.failure(.noData))
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let result = try decoder.decode(MoviesResponse.self, from: data)
                completion(.success(result.results))
            } catch {
                completion(.failure(.decodingError(error)))
            }
        }
        task.resume()
    }
}
