//
//  NewTopHeadlinesListViewModel.swift
//  BoynerStudyCase
//
//  Created by Betul Demirci Çelik on 9.11.2025.
//

import Components
import Common
import Foundation
import CoreData

@MainActor
final class NewTopHeadlinesListViewModel: AsyncBaseViewModel {
    
    // MARK: - Constants
    
    private enum Constants {
        static let sliderRefreshInterval: TimeInterval = 5
        static let refreshInterval: TimeInterval = 60
        static let sliderItemLimit = 3
    }
    
    // MARK: - Services
    
    private let service: NewSourcesServiceProtocol
    
    // MARK: - Delegates
    
    weak var coordinatorDelegate: (any SourcesCoordinatorProtocol)?
    
    // MARK: - Properties
    
    @Published var articles: [Article] = []
    @Published var sliderItems: SliderItem?
    @Published var apiError: Error?
    @Published var isLoading: Bool = false
    @Published var favorites: [FavoriteNewSource] = []
    
    let timerManager: TimerManageable
    private let favoriteSourceManager: FavoriteNewSourceManageableProtocol
    private let source: String
    
    // MARK: - Init
    
    init(
        service: NewSourcesServiceProtocol,
        source: String,
        favoriteSourceManager: FavoriteNewSourceManageableProtocol,
        timerManager: TimerManageable
    ) {
        self.service = service
        self.source = source
        self.favoriteSourceManager = favoriteSourceManager
        self.timerManager = timerManager
        super.init()
    }
}

// MARK: - NewTopHeadlinesListViewModelProtocol

extension NewTopHeadlinesListViewModel: NewTopHeadlinesListViewModelProtocol {
    
    func viewIsReady() async {
        await refreshFavorites()
        await fetchTopHeadlines()
    }
    
    func isFavoriteSource(_ source: Article) -> Bool {
        favorites.contains(where: { $0.title == source.title })
    }
    
    func didPullToRefresh() {
        let task = Task {
            await callRetrieve()
        }
        store(task)
    }
    
    func didTapRetryButton() {
        refreshAllItems()
    }
    
    func viewTapCellButton(_ source: Article) {
        toggleFavorite(source)
    }
    
    func didRefreshTimer() {
        refreshAllItems()
    }
}

private extension NewTopHeadlinesListViewModel {
    
    func fetchTopHeadlines() async {
        isLoading = true
        defer { isLoading = false }
        await callRetrieve()
    }
    
    func callRetrieve() async {
        do {
            let response = try await service.fetchTopHeadlines(source: source)
            articles = (response.articles ?? [])
                .compactMap { article -> Article? in
                    guard let title = article.title?.htmlDecoded, !title.isEmpty else { return nil }
                    var updated = article
                    updated.title = title
                    return updated
                }
                .sorted { ($0.publishedAt ?? Date()) > ($1.publishedAt ?? Date()) }
            let subItems: [SliderSubItem] = Array(articles.prefix(Constants.sliderItemLimit)).map { article in
                SliderSubItem(iconURL: article.urlToImage.emptyIfNone, title: article.title.emptyIfNone)
            }
            sliderItems = SliderItem(items: subItems, refreshTime: Constants.sliderRefreshInterval)
            timerManager.startTimer(delegate: self, interval: Constants.refreshInterval)
        } catch {
            apiError = error
        }
    }
    
    func toggleFavorite(_ source: Article) {
        let task = Task {
            if await favoriteSourceManager.isFavorite(title: source.title.emptyIfNone) {
                await favoriteSourceManager.removeFavorite(title: source.title.emptyIfNone)
            } else {
                await favoriteSourceManager.addFavorite(
                    id: (source.source?.id).emptyIfNone,
                    title: source.title.emptyIfNone,
                    url: source.url
                )
            }
            await refreshFavorites()
        }
        store(task)
    }
    
    func refreshFavorites() async {
        favorites = await favoriteSourceManager.getFavorites()
    }
    
    func refreshAllItems() {
        let task = Task {
            await refreshFavorites()
            await fetchTopHeadlines()
        }
        store(task)
    }
}
