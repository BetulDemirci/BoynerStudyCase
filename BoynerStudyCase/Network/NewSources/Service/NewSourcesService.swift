//
//  NewSourcesService.swift
//  BoynerStudyCase
//
//  Created by Betul Demirci Çelik on 9.11.2025.
//

import Networking

protocol NewSourcesServiceProtocol {
    func fetchSources(language: String) async throws -> NewSourcesResponse
    func fetchTopHeadlines(source: String) async throws -> NewTopHeadlinesResponse
}

// MARK: - NewSourcesServiceProtocol

final class NewSourcesService: NewSourcesServiceProtocol {
    private let client: NetworkClient
    
    init(client: NetworkClient) {
        self.client = client
    }
    
    func fetchSources(language: String) async throws -> NewSourcesResponse {
        try await client.request(Endpoints.sources(language: language))
    }
    
    func fetchTopHeadlines(source: String) async throws -> NewTopHeadlinesResponse {
        try await client.request(Endpoints.topHeadlines(source: source))
    }
}
