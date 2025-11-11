//
//  FavoriteNewSourceManagerTests.swift
//  BoynerStudyCase
//
//  Created by Betul Demirci Çelik on 11.11.2025.
//

import XCTest
import CoreData
@testable import BoynerStudyCase

@MainActor
final class MockFavoriteNewSourceManagerTests: XCTestCase {
    
    var sut: MockFavoriteNewSourceManager!

    override func setUp() async throws {
        try await super.setUp()
        sut = MockFavoriteNewSourceManager()
    }

    override func tearDown() async throws  {
        sut = nil
        try await super.tearDown()
    }
    
    func testIsFavorite() async {
        // Given
        let title = "FavoriteTest"
        await sut.addFavorite(id: "42", title: title, url: nil)
        
        // When
        let resultTrue = await sut.isFavorite(title: title)
        let resultFalse = await sut.isFavorite(title: "NonExistent")
        
        // Then
        XCTAssertTrue(resultTrue)
        XCTAssertFalse(resultFalse)
    }
    
    func testGetFavoritesEmpty() async {
        // When
        let favorites = await sut.getFavorites()
        
        // Then
        XCTAssertTrue(favorites.isEmpty)
    }
    
    func testErrorSimulation() async {
        // Given
        sut.shouldReturnError = true
        
        // When
        let isFav = await sut.isFavorite(title: "Anything")
        let favorites = await sut.getFavorites()
        
        // Then
        XCTAssertFalse(isFav)
        XCTAssertTrue(favorites.isEmpty)
    }
}
