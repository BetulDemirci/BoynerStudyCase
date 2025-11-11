//
//  NewTopHeadlinesListViewModel+Contracts.swift
//  BoynerStudyCase
//
//  Created by Betul Demirci Çelik on 9.11.2025.
//

import Components
import Common
import Combine

@MainActor
protocol NewTopHeadlinesListViewModelProtocol: ObservableObject, AsyncBaseViewModelable, TimerDelegate {
    var timerManager: TimerManageable { get }
    var articles: [Article] { get }
    var sliderItems: SliderItem? { get }
    var apiError: Error? { get set }
    var isLoading: Bool { get set }
    
    func viewIsReady() async
    func isFavoriteSource(_ source: Article) -> Bool
    func viewTapCellButton(_ source: Article)
    func didPullToRefresh()
    func didTapRetryButton()
}
