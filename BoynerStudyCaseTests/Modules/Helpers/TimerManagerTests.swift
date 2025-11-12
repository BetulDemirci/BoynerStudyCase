//
//  TimerManagerTests.swift
//  BoynerStudyCase
//
//  Created by Betul Demirci Çelik on 11.11.2025.
//

import XCTest
@testable import BoynerStudyCase

@MainActor
final class TimerManagerTests: XCTestCase {
    
    private var sut: TimerManager!
    private var delegate: MockTimerDelegate!
    
    override func setUp() async throws {
        try await super.setUp()
        sut = TimerManager()
        delegate = MockTimerDelegate()
    }

    override func tearDown() async throws  {
        sut = nil
        delegate = nil
        try await super.tearDown()
    }
    
    func testStartTimer_setsDelegateAndInterval() async {
        // Given
        let interval: TimeInterval = 0.1
        
        // When
        sut.startTimer(delegate: delegate, interval: interval)
        
        // Then
        try? await Task.sleep(nanoseconds: UInt64(interval * 1_000_000_000))
        XCTAssertTrue(delegate.isCalledRefreshTimer)
    }
    
    func testStopTimer_invalidatesTimer() async {
        // Given
        let interval: TimeInterval = 0.1
        sut.startTimer(delegate: delegate, interval: interval)

        // When
        sut.stopTimer()
        delegate.isCalledRefreshTimer = false

        // Then
        try? await Task.sleep(nanoseconds: UInt64(interval * 1_000_000_000))
        XCTAssertFalse(delegate.isCalledRefreshTimer)
    }
}
