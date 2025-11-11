//
//  BoynerStudyCaseApp.swift
//  BoynerStudyCase
//
//  Created by Betul Demirci Çelik on 9.11.2025.
//

import SwiftUI

@main
struct BoynerStudyCaseApp: App {
    
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    
    var body: some Scene {
        WindowGroup {
            appDelegate.sourcesCoordinator.start()
        }
    }
}
