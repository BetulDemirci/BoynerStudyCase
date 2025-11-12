//
//  APIError.swift
//  Networking
//
//  Created by Betul Demirci Çelik on 9.11.2025.
//

import Foundation

public enum APIError: Error {
    case invalidURL
    case decodingError
    case serverError(code: Int)
    case unknown
}
