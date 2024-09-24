//
//  ServiceManager.swift
//  CineTrack
//
//  Created by John on 19/09/24.
//

import Foundation

class ServiceManager: MovieService {
    
    static let shared = ServiceManager()
    
    func getMovie(segment: String, completion: @escaping (Result<[Movie], NetworkError>) -> Void) {
        let deviceLanguage = Locale.preferredLanguages.first ?? "en-US"
        let urlString = "\(Constants.baseURL)/3/movie/\(segment)?api_key=\(Constants.API)&language=\(deviceLanguage)&page=1"
        
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
    
    func getDiscoverMovies(completion: @escaping (Result<[Movie], NetworkError>) -> Void) {
        let deviceLanguage = Locale.preferredLanguages.first ?? "en-US"
        let urlString = "\(Constants.baseURL)/3/discover/movie?api_key=\(Constants.API)&language=\(deviceLanguage)&sort_by=popularity.desc&include_adult=false&include_video=false&page=1&with_watch_monetization_types=flatrate"
        
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
    
    func search(with query: String, completion: @escaping (Result<[Movie], NetworkError>) -> Void) {
        guard let query = query.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) else { return }
        
        let urlString = "\(Constants.baseURL)/3/search/movie?api_key=\(Constants.API)&query=\(query)"
        
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
