//
//  SourcesListViewModelTests.swift
//  BoynerStudyCase
//
//  Created by Betul Demirci Çelik on 11.11.2025.
//

import XCTest
import Combine
@testable import BoynerStudyCase

@MainActor
final class SourcesListViewModelTests: XCTestCase {
    
    private var sut: SourcesListViewModel!
    private var serviceFactory: MockSourcesService!

    override func setUp() async throws {
        try await super.setUp()
        serviceFactory = MockSourcesService()
        sut = SourcesListViewModel(service: serviceFactory)
    }

    override func tearDown() async throws {
        sut = nil
        serviceFactory = nil
        try await super.tearDown()
    }
    
    func testWhenViewIsReadyThenShouldFetchSourcesSuccess() async {
        // When
        await sut.viewIsReady()
        
        // Then
        XCTAssertFalse(sut.filteredSources.isEmpty)
        XCTAssertEqual(sut.filteredSources.count, 2)
        XCTAssertTrue(serviceFactory.fetchedSources)
        XCTAssertNil(sut.apiError)
        XCTAssertFalse(sut.isLoading)
    }
    
    func testWhenViewIsReadyThenShouldFetchSourcesFailure() async {
        // Given
        serviceFactory.sourcesResult = .failure(MockAPIError.decodingError)
        
        // When
        await sut.viewIsReady()
        
        // Then
        XCTAssertTrue(sut.filteredSources.isEmpty)
        XCTAssertNotNil(sut.apiError)
        XCTAssertFalse(sut.isLoading)
    }
    
    func testWhenTapChipsViewThenApplyFilter() async {
        // Given
        await sut.viewIsReady()
        
        // When
        sut.selectedCategories = [.general]
        sut.didTapChipsView()
        
        // Then
        XCTAssertEqual(sut.filteredSources.count, 2)
        XCTAssertEqual(sut.filteredSources.first?.name, "ABC News")
    }
}


