//
//  SourcesListViewModel.swift
//  BoynerStudyCase
//
//  Created by Betul Demirci Çelik on 9.11.2025.
//

import Foundation
import Common

@MainActor
final class SourcesListViewModel {
    
    // MARK: - Constants
    
    private enum Constants {
        static let language = "en"
    }
    
    // MARK: - Services
    
    private let service: NewSourcesServiceProtocol
    
    // MARK: - Delegates
    
    weak var coordinatorDelegate: (any SourcesCoordinatorProtocol)?
    
    // MARK: - Properties
    
    @Published var filteredSources: [NewSource] = []
    @Published var apiError: Error?
    @Published var isLoading: Bool = false
    @Published var selectedCategories: Set<Category> = []
    
    private var allSources: [NewSource] = []
    
    // MARK: - Init
    
    init(service: NewSourcesServiceProtocol) {
        self.service = service
    }
}

// MARK: - SourceViewModelProtocol

extension SourcesListViewModel: SourceViewModelProtocol {
    
    func viewIsReady() async {
        await fetchSources()
    }
    
    func didTapChipsView() {
        applyFilter()
    }
}

private extension SourcesListViewModel {
  
    func fetchSources() async {
        isLoading = true
        defer { isLoading = false }
        
        do {
            let response = try await service.fetchSources(language: Constants.language)
            selectedCategories = []
            allSources = response.sources ?? []
            filteredSources = allSources
        } catch {
            print(error)
            apiError = error
        }
    }
    
    func applyFilter() {
        filteredSources = selectedCategories.isEmpty
            ? allSources
        : allSources.filter { selectedCategories.contains($0.category ?? .general) }
    }
}
