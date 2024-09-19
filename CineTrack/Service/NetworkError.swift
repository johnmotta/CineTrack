//
//  NetworkError.swift
//  CineTrack
//
//  Created by John on 19/09/24.
//

import Foundation

enum NetworkError: Error {
    case invalidURL(String)
    case noData
    case invalidResponse
    case decodingError(Error)
    case networkFailure(Error)
    
    var errorDescription: String? {
        switch self {
        case .invalidURL(let url):
            return "URL inválida -> \(url)."
        case .noData:
            return "Dados não recebidos da API."
        case .invalidResponse:
            return "Resposta inválida da API."
        case .decodingError(let error):
            return "Decodificação falhou: \(error.localizedDescription)"
        case .networkFailure(let error):
            return "Falha na rede: \(error.localizedDescription)"
        }
    }
}
