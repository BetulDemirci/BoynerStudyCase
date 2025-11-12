//
//  NewSourcesResponse.swift
//  BoynerStudyCase
//
//  Created by Betul Demirci Çelik on 9.11.2025.
//

import Foundation

struct NewSourcesResponse: Codable, Sendable {
    let status: String?
    let sources: [NewSource]?
}

struct NewSource: Codable, Identifiable {
    let id, name, description: String?
    let url: String?
    let category: Category?
    let country: String?
}

extension NewSource {
    
    static func stub() -> NewSource {
        NewSource(
            id: "abc-news",
            name: "ABC News",
            description: "Your trusted source for breaking news, analysis, exclusive interviews, headlines, and videos at ABCNews.com.",
            url: "https://abcnews.go.com",
            category: .general,
            country: "us"
        )
    }
}

extension NewSourcesResponse {
    
    static func stub() -> NewSourcesResponse {
        NewSourcesResponse(
            status: "ok",
            sources: [NewSource.stub(), NewSource.stub()]
        )
    }
}
