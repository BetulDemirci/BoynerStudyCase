//
//  MockFavoriteNewSourceManager.swift
//  BoynerStudyCase
//
//  Created by Betul Demirci Çelik on 11.11.2025.
//

import Foundation
@testable import BoynerStudyCase

@MainActor
final class MockFavoriteNewSourceManager: FavoriteNewSourceManageableProtocol {
    
    var favorites: [MockFavoriteNewSource] = []
    var shouldReturnError: Bool = false
    
    func isFavorite(title: String) async -> Bool {
        if shouldReturnError { return false }
        return favorites.contains { $0.title == title }
    }
    
    func addFavorite(id: String, title: String, url: String?) async {
        if shouldReturnError { return }
        let item = MockFavoriteNewSource(id: id, title: title, url: url)
        favorites.append(item)
    }
    
    func removeFavorite(title: String) async {
        if shouldReturnError { return }
        favorites.removeAll { $0.title == title }
    }
    
    func getFavorites() async -> [BoynerStudyCase.FavoriteNewSource] {
        []
    }
}

struct MockFavoriteNewSource: Identifiable {
    let id: String
    let title: String
    let url: String?
}
