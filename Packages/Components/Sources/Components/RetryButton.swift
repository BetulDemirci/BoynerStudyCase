//
//  RetryButton.swift
//  Components
//
//  Created by Betul Demirci Çelik on 9.11.2025.
//

import SwiftUI

public struct RetryButton: View {
    let action: () -> Void
    let title: String
    
    public init(action: @escaping () -> Void, title: String) {
        self.action = action
        self.title = title
    }
    
    public var body: some View {
        Button(action: action) {
            Text(title)
                .font(.body)
                .foregroundColor(.blue)
                .padding(.vertical, 8)
                .padding(.horizontal, 16)
                .overlay(
                    RoundedRectangle(cornerRadius: 8)
                        .stroke(Color.blue, lineWidth: 1)
                )
        }
    }
}
