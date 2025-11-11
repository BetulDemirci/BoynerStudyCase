//
//  SourcesCoordinator+Contracts.swift
//  BoynerStudyCase
//
//  Created by Betul Demirci Çelik on 9.11.2025.
//

import Foundation
import SwiftUI

@MainActor
protocol SourcesCoordinatorProtocol: AnyObject {
    func goToDetail(_ source: String) -> AnyView
}

