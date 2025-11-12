//
//  URLSessionNetworkClient.swift
//  Networking
//
//  Created by Betul Demirci Çelik on 9.11.2025.
//

import Foundation

public final class URLSessionNetworkClient: NetworkClient {
    
    public init() {}
    
    /// Performs a network request to the specified endpoint and decodes the response into a Decodable type.
        /// - Parameter endpoint: The API endpoint to request.
        /// - Returns: Decoded response of type `T`.
        /// - Throws: APIError in case of invalid URL, server error, or decoding failure.
    public func request<T: Decodable>(_ endpoint: Endpoint) async throws -> T {
        
        guard var components = URLComponents(string: endpoint.baseURL + endpoint.path) else {
            throw APIError.invalidURL
        }
        
        components.queryItems = endpoint.query
        
        guard let url = components.url else {
            throw APIError.invalidURL
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = endpoint.method.rawValue
        
        do {
            let (data, response) = try await URLSession.shared.data(for: request)
            
            // Check HTTP status code
            if let httpRes = response as? HTTPURLResponse,
               !(200...299).contains(httpRes.statusCode) {
                throw APIError.serverError(code: httpRes.statusCode)
            }
            
            // Decode the JSON response into the requested type
            let decoder = JSONDecoder()
            let formatter = ISO8601DateFormatter()
            formatter.formatOptions = [.withInternetDateTime, .withFractionalSeconds]

            // Custom decoding strategy for date strin
            decoder.dateDecodingStrategy = .custom { decoder in
                let container = try decoder.singleValueContainer()
                let dateStr = try container.decode(String.self)
                
                if let date = formatter.date(from: dateStr) {
                    return date
                }
                
                let fallbackFormatter = ISO8601DateFormatter()
                fallbackFormatter.formatOptions = [.withInternetDateTime]
                if let date = fallbackFormatter.date(from: dateStr) {
                    return date
                }
                
                throw DecodingError.dataCorruptedError(
                    in: container,
                    debugDescription: "Cannot decode date string \(dateStr)"
                )
            }
            return try decoder.decode(T.self, from: data)
        } catch {
            throw APIError.decodingError
        }
    }
}
