//
//  MockSourcesService.swift
//  BoynerStudyCase
//
//  Created by Betul Demirci Çelik on 11.11.2025.
//

@testable import BoynerStudyCase
import XCTest

enum MockAPIError: Error, Equatable {
    case invalidURL
    case decodingError
    case unknown
}

final class MockSourcesService: NewSourcesServiceProtocol {

    enum ServiceResult<Value> {
        case success(Value)
        case failure(Error)
    }

    var requestExpectation: XCTestExpectation?
    var sourcesResult: ServiceResult<NewSourcesResponse> = .success(NewSourcesResponse.stub())
    var headlinesResult: ServiceResult<NewTopHeadlinesResponse> = .success(NewTopHeadlinesResponse.stub())
    var fetchedSources = false
    var fetchedTopHeadlines = false
    
    func fetchSources(language: String) async throws -> NewSourcesResponse {
        defer {
            fetchedSources = true
        }

        switch sourcesResult {
        case .success(let response):
            return response
        case .failure(let error):
            throw error
        }
    }

    func fetchTopHeadlines(source: String) async throws -> NewTopHeadlinesResponse {
        defer {
            fetchedTopHeadlines = true
            requestExpectation?.fulfill()
        }

        switch headlinesResult {
        case .success(let response):
            return response
        case .failure(let error):
            throw error
        }
    }
}
