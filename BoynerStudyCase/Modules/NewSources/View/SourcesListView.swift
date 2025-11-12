//
//  SourcesListView.swift
//  BoynerStudyCase
//
//  Created by Betul Demirci Çelik on 9.11.2025.
//

import SwiftUI
import Components

struct SourcesListView<VM: SourceViewModelProtocol>: View {
    
    @StateObject private var viewModel: VM
    
    init(viewModel: VM) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }
    
    var body: some View {
        NavigationView {
            ZStack {
                VStack {
                    SelectedChipsView(items: Category.allCases,
                                      selectedItems: $viewModel.selectedCategories,
                                      title: { $0.rawValue.capitalized })
                        .padding(.vertical, 4)
                        .onChange(of: Array(viewModel.selectedCategories)) { _ in
                            viewModel.didTapChipsView()
                        }
                    List(viewModel.filteredSources) { source in
                        NavigationLink {
                            viewModel.coordinatorDelegate?.goToDetail(source.id.emptyIfNone)
                        } label: {
                            SourceCellView(source: source)
                        }
                        .listRowSeparator(.hidden)
                    }
                    .listStyle(PlainListStyle())
                }
                .opacity(viewModel.isLoading ? 0.5 : 1.0)

                if viewModel.isLoading {
                    ProgressView()
                        .progressViewStyle(CircularProgressViewStyle(tint: .gray))
                        .scaleEffect(1.5)
                }
            }
            .navigationTitle("Kaynaklar")
            .errorAlert(error: $viewModel.apiError)
            .task {
                await viewModel.viewIsReady()
            }
        }
    }
}
