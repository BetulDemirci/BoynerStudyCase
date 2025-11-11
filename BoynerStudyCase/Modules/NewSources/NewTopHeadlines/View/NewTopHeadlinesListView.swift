//
//  NewTopHeadlinesListView.swift
//  BoynerStudyCase
//
//  Created by Betul Demirci Çelik on 9.11.2025.
//


import SwiftUI
import Components

struct NewTopHeadlinesListView<VM: NewTopHeadlinesListViewModelProtocol>: View {
    
    @StateObject private var viewModel: VM
    
    init(viewModel: VM) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }
    
    var body: some View {
        NavigationView {
            ZStack {
                VStack {
                    if let items = viewModel.sliderItems, !items.items.isEmpty {
                        List {
                            Section {
                                ForEach(viewModel.articles) { article in
                                    NewTopHeadlinesCellView(
                                        article: article,
                                        isFavorite: viewModel.isFavoriteSource(article),
                                        buttonAction: {
                                            viewModel.viewTapCellButton(article)
                                        })
                                    .listRowSeparator(.hidden)
                                }
                            } header: {
                                AutoSliderView(slider: items, currentIndex: .zero)
                            }
                        }
                        .refreshable(action: {
                            viewModel.didPullToRefresh()
                        })
                        .listStyle(PlainListStyle())
                    }  else {
                        if !viewModel.isLoading {
                            RetryButton(action: {
                                viewModel.didTapRetryButton()
                            }, title: "Tekrar Dene")
                        }
                    }
                }
                .opacity(viewModel.isLoading ? 0.5 : 1.0)
                if viewModel.isLoading {
                    ProgressView()
                        .progressViewStyle(CircularProgressViewStyle(tint: .gray))
                        .scaleEffect(1.5)
                }
            }
            .navigationTitle((viewModel.articles.first?.source?.name).emptyIfNone)
            .navigationBarTitleDisplayMode(.inline)
            .errorAlert(error: $viewModel.apiError)
            .task {
                await viewModel.viewIsReady()
            }
            .onDisappear {
                viewModel.viewDidRemove()
                viewModel.timerManager.stopTimer()
            }
        }
    }
}
