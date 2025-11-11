//
//  SourcesCoordinator.swift
//  BoynerStudyCase
//
//  Created by Betul Demirci Çelik on 9.11.2025.
//

import Networking
import SwiftUICore

@MainActor
final class SourcesCoordinator {
    
    private let client: NetworkClient
    
    init(client: NetworkClient = URLSessionNetworkClient()) {
        self.client = client
    }
    
    func start() -> some View {
        let service = NewSourcesService(client: client)
        let viewModel = SourcesListViewModel(service: service)
        viewModel.coordinatorDelegate = self
        return SourcesListView(viewModel: viewModel)
    }
}

// MARK: - SourcesCoordinatorProtocol
@MainActor
extension SourcesCoordinator: SourcesCoordinatorProtocol {
   
    func goToDetail(_ source: String) -> AnyView {
        let service = NewSourcesService(client: client)
        let favoriteSourceManager = FavoriteNewSourceManager()
        let viewModel = NewTopHeadlinesListViewModel(
            service: service,
            source: source,
            favoriteSourceManager: favoriteSourceManager,
            timerManager: TimerManager()
        )
        viewModel.coordinatorDelegate = self
        return AnyView(NewTopHeadlinesListView(viewModel: viewModel))
    }
}
