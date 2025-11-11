//
//  Endpoint.swift
//  Networking
//
//  Created by Betul Demirci Çelik on 9.11.2025.
//

import Foundation

public protocol Endpoint {
    var baseURL: String { get }
    var path: String { get }
    var method: HTTPMethod { get }
    var query: [URLQueryItem] { get }
}

extension Endpoint {
    var apiKeyQuery: URLQueryItem {
        URLQueryItem(name: "apiKey", value: APIConfig.key)
    }
}

public enum Endpoints: Endpoint {
    case topHeadlines(source: String)
    case sources(language: String)
    
    public var baseURL: String { "https://newsapi.org" }
    
    public var path: String {
        switch self {
        case .topHeadlines:
            return "/v2/top-headlines"
        case .sources:
            return "/v2/sources"
        }
    }
    
    public var method: HTTPMethod {
        .get
    }
    
    public var query: [URLQueryItem] {
        switch self {
        case .topHeadlines(let source):
            [URLQueryItem(name: "sources", value: source), apiKeyQuery]
       case .sources(let language):
            [URLQueryItem(name: "language", value: language), apiKeyQuery]
        }
    }
}
