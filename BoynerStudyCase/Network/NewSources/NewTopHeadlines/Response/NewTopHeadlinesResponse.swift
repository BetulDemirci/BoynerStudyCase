//
//  NewTopHeadlinesResponse.swift
//  BoynerStudyCase
//
//  Created by Betul Demirci Çelik on 9.11.2025.
//

import Foundation

struct NewTopHeadlinesResponse: Codable, Sendable {
    let status: String?
    let totalResults: Int?
    let articles: [Article]?
}

struct Article: Codable, Identifiable {
    var id = UUID()
    let source: SourceIdentifier?
    let author, description: String?
    var title: String?
    let url: String?
    let urlToImage: String?
    let publishedAt: Date?
    let content: String?
    
    private enum CodingKeys: String, CodingKey {
        case source, author, title, description, url, urlToImage, publishedAt, content
    }
}

struct SourceIdentifier: Codable {
    let id: String?
    let name: String?
}

extension NewTopHeadlinesResponse {
    
    static func stub() -> NewTopHeadlinesResponse {
        NewTopHeadlinesResponse(
            status: "ok",
            totalResults: 1,
            articles: [Article.stub()]
        )
    }
}

extension Article {
    
    static func stub() -> Article {
        Article(
            source: SourceIdentifier(id: "abc-news", name: "ABC News"),
            author: "abc-news",
            description: "Your trusted source for breaking news, analysis, exclusive interviews, headlines, and videos at ABCNews.com.",
            url: "https://abcnews.go.com",
            urlToImage: "https://abcnews.go.com",
            publishedAt: Date(),
            content: ""
        )
    }
}
