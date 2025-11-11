//
//  SelectedChipsView.swift
//  Components
//
//  Created by Betul Demirci Çelik on 9.11.2025.
//

import SwiftUI

public struct SelectedChipsView<Item: Hashable>: View {
    public let items: [Item]
    public let title: ((Item) -> String)
    @Binding public var selectedItems: Set<Item>
    
    public init(items: [Item],
                selectedItems: Binding<Set<Item>>,
                title: @escaping (Item) -> String) {
        self.items = items
        self._selectedItems = selectedItems
        self.title = title
    }
    
    public var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 8) {
                ForEach(items, id: \.self) { item in
                    Button(action: {
                        toggle(item)
                    }) {
                        Text(title(item))
                            .font(.subheadline)
                            .padding(.vertical, 6)
                            .padding(.horizontal, 12)
                            .background(
                                selectedItems.contains(item) ?
                                Color.orange.opacity(0.8) :
                                Color.gray.opacity(0.3)
                            )
                            .foregroundColor(selectedItems.contains(item) ? .white : .primary)
                            .clipShape(Capsule())
                    }
                    .buttonStyle(PlainButtonStyle())
                }
            }
            .padding(.horizontal)
        }
        .frame(height: 40)
    }
    
    private func toggle(_ item: Item) {
        if selectedItems.contains(item) {
            selectedItems.remove(item)
        } else {
            selectedItems.insert(item)
        }
    }
}
