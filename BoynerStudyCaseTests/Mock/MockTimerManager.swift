//
//  MockTimerManager.swift
//  BoynerStudyCase
//
//  Created by Betul Demirci Çelik on 11.11.2025.
//

import Foundation
@testable import BoynerStudyCase

@MainActor
final class MockTimerManager: TimerManageable {

    private(set) var startTimerCalled = false
    private(set) var stopTimerCalled = false
    private(set) var refreshInterval: TimeInterval?
    private var timerDelegate: MockTimerDelegate?

    func startTimer(delegate: TimerDelegate, interval: TimeInterval) {
        startTimerCalled = true
        timerDelegate = MockTimerDelegate()
        refreshInterval = interval
    }

    func stopTimer() {
        stopTimerCalled = true
    }

    func triggerTimer() {
        timerDelegate?.didRefreshTimer()
    }
}

// MARK: - TimerDelegate

final class MockTimerDelegate: TimerDelegate {
    
    var isCalledRefreshTimer = false
  
    func didRefreshTimer() {
        isCalledRefreshTimer = true
    }
}
