//
//  NetworkClient.swift
//  Networking
//
//  Created by Betul Demirci Çelik on 9.11.2025.
//

import Foundation

public protocol NetworkClient {
    func request<T: Decodable>(_ endpoint: Endpoint) async throws -> T
}
