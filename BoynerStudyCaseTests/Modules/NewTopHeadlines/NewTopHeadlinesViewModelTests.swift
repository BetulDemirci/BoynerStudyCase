//
//  NewTopHeadlinesViewModelTests.swift
//  BoynerStudyCase
//
//  Created by Betul Demirci Çelik on 11.11.2025.
//

import XCTest
import Combine
@testable import BoynerStudyCase

@MainActor
final class NewTopHeadlinesViewModelTests: XCTestCase {
    
    private var sut:  NewTopHeadlinesListViewModel!
    private var serviceFactory: MockSourcesService!
    private var timerManager: MockTimerManager!
    private var favoriteSourceManager: FavoriteNewSourceManager!

    override func setUp() async throws {
        try await super.setUp()
        serviceFactory = MockSourcesService()
        favoriteSourceManager = FavoriteNewSourceManager()
        timerManager = MockTimerManager()
        sut = NewTopHeadlinesListViewModel(
            service: serviceFactory,
            source: NewSource.stub().id.emptyIfNone,
            favoriteSourceManager: favoriteSourceManager,
            timerManager: timerManager
        )
    }

    override func tearDown() async throws {
        sut = nil
        serviceFactory = nil
        favoriteSourceManager = nil
        timerManager = nil
        try await super.tearDown()
    }
    
    func testWhenViewIsReadyThenShouldFetchNewTopHeadlinesSuccess() async {
        // Given
        let requestExpectation = XCTestExpectation(description: #function)
        serviceFactory.requestExpectation = requestExpectation
        
        // When
        sut.didPullToRefresh()
        
        // Then
        await fulfillment(of: [requestExpectation], timeout: 1)
        XCTAssertNil(sut.apiError)
        XCTAssertFalse(sut.isLoading)
        XCTAssertTrue(serviceFactory.fetchedTopHeadlines)
        XCTAssertTrue(timerManager.startTimerCalled)
    }
    
    func testWhenViewIsReadyThenShouldFetchNewTopHeadlinesFailure() async {
        // Given
        serviceFactory.headlinesResult = .failure(MockAPIError.decodingError)
        
        // When
        await sut.viewIsReady()
        
        // Then
        XCTAssertTrue(sut.articles.isEmpty)
        XCTAssertNotNil(sut.apiError)
        XCTAssertFalse(sut.isLoading)
    }
    
    func testDidRefreshTimer_refreshesAllItems() async {
        // Given
        let requestExpectation = XCTestExpectation(description: #function)
        serviceFactory.requestExpectation = requestExpectation
        
        // When
        sut.didPullToRefresh()
        
        // Then
        await fulfillment(of: [requestExpectation], timeout: 1)
        XCTAssertTrue(serviceFactory.fetchedTopHeadlines)
    }
}


