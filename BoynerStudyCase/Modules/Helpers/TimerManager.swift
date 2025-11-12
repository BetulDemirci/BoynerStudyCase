//
//  TimerManager.swift
//  BoynerStudyCase
//
//  Created by Betul Demirci Çelik on 10.11.2025.
//

import Foundation

@MainActor
protocol TimerDelegate: AnyObject {
    /// Called every time the timer fires
    func didRefreshTimer()
}

/// Protocol defining a timer manager's interface
@MainActor
protocol TimerManageable: AnyObject {
    func startTimer(delegate: (any TimerDelegate), interval: TimeInterval)
    func stopTimer()
}

@MainActor
class TimerManager: TimerManageable {
    
    private var timer: Timer?
    private var refreshInterval: TimeInterval = 1.0
    private weak var delegate: TimerDelegate?
    private var isTimerEnabled: Bool = false
    
    /// Starts the timer
    func startTimer(delegate: TimerDelegate, interval: TimeInterval) {
        self.delegate = delegate
        self.refreshInterval = interval
        self.isTimerEnabled = true
       
        // Invalidate previous timer if it exists
        timer?.invalidate()
        timer = Timer.scheduledTimer(withTimeInterval: interval, repeats: true) { [weak self] _ in
            // Notify the delegate on main actor asynchronously
            Task { @MainActor in
                await self?.checkAndFireTimer()
            }
        }
    }
    
    /// Stops the timer and cleans up resources
    func stopTimer() {
        isTimerEnabled = false
        timer?.invalidate()
        timer = nil
    }
    
    /// Internal method called on each timer tick to notify the delegate
    private func checkAndFireTimer() async {
        guard isTimerEnabled else { return }
        
        delegate?.didRefreshTimer()
    }
}
