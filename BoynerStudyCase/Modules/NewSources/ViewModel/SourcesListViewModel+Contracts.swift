//
//  SourcesListViewModel+Contracts.swift
//  BoynerStudyCase
//
//  Created by Betul Demirci Çelik on 9.11.2025.
//

import Foundation
import Common

@MainActor
protocol SourceViewModelProtocol: ObservableObject {
    var coordinatorDelegate: (any SourcesCoordinatorProtocol)? { get }
    var filteredSources: [NewSource] { get }
    var apiError: Error? { get set }
    var isLoading: Bool { get set }
    var selectedCategories: Set<Category> { get set }
    
    func viewIsReady() async
    func didTapChipsView()
}
