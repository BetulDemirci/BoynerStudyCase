//
//  SourceCellView.swift
//  BoynerStudyCase
//
//  Created by Betul Demirci Çelik on 9.11.2025.
//

import SwiftUI
import Components

struct SourceCellView: View {
    let source: NewSource
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                BlurTextFieldView(text: source.name.emptyIfNone)
                    .opacity(0.75)
                    
            }
            Text(source.description.emptyIfNone)
                .foregroundColor(.black)
                .font(.body)
                .padding(.horizontal, 8)
        }
        .cornerRadius(14)
        .padding(.leading, 8)
    }
}
