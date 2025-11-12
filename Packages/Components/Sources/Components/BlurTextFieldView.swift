//
//  BlurTextFieldView.swift
//  Components
//
//  Created by Betul Demirci Çelik on 9.11.2025.
//

import SwiftUI

public struct BlurTextFieldView: View {
    let text: String
    
    public init(text: String) {
        self.text = text
    }
    
    public var body: some View {
        Text(text)
            .foregroundColor(.orange)
            .fontWeight(.bold)
            .padding(5)
            .background(.gray.opacity(0.2),
                        in: RoundedRectangle(cornerRadius: 10.0, style: .continuous))
            .padding(5)
    }
}
