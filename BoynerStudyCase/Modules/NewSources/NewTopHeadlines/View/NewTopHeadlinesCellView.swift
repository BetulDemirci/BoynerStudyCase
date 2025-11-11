//
//  NewTopHeadlinesCellView.swift
//  BoynerStudyCase
//
//  Created by Betul Demirci Çelik on 9.11.2025.
//

import SwiftUI
import Components

struct NewTopHeadlinesCellView: View {
    let article: Article
    var isFavorite: Bool
    let buttonAction: () -> Void
    
    var body: some View {
        HStack(spacing: 12) {
            if let url = URL(string: article.urlToImage.emptyIfNone) {
                AsyncImage(url: url) { phase in
                    switch phase {
                    case .empty:
                        ProgressView()
                            .frame(width: 60, height: 60)
                    case .success(let image):
                        image
                            .resizable()
                            .scaledToFill()
                            .frame(width: 60, height: 60)
                            .clipShape(RoundedRectangle(cornerRadius: 8))
                    case .failure:
                        Image(systemName: "photo")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 60, height: 60)
                            .foregroundColor(.gray)
                    @unknown default:
                        EmptyView()
                    }
                }
            } else {
                Image(systemName: "photo")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 60, height: 60)
                    .foregroundColor(.gray)
            }
            Text(article.title.emptyIfNone)
                .font(.body)
                .foregroundColor(.black)
                .multilineTextAlignment(.leading)
            Spacer()
            Button(action: buttonAction) {
                Image(systemName: isFavorite ? "heart.fill" : "heart")
                    .resizable()
                    .frame(width: 20, height: 20)
                    .foregroundColor(.orange)
            }
        }
        .padding(8)
        .background(Color.white)
        .cornerRadius(14)
        .shadow(color: Color.black.opacity(0.05), radius: 4, x: 0, y: 2)
        .padding(.horizontal, 8)
    }
}
