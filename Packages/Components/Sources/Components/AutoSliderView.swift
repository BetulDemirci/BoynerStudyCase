//
//  AutoSliderView.swift
//  Components
//
//  Created by Betul Demirci Çelik on 9.11.2025.
//

import SwiftUI
import Combine

public struct SliderItem {
    public let items: [SliderSubItem]  
    public let refreshTime: TimeInterval
   
    public init(items: [SliderSubItem], refreshTime: TimeInterval) {
        self.items = items
        self.refreshTime = refreshTime
    }
}

public struct SliderSubItem: Identifiable {
    public let id = UUID()
    public let iconURL: String
    public let title: String
    
    public init(iconURL: String, title: String) {
        self.iconURL = iconURL
        self.title = title
    }
}

public struct AutoSliderView: View {
    let slider: SliderItem
    @State private var timerSubscription: Cancellable? = nil
    @State private var currentIndex: Int = 0
    
    public init(slider: SliderItem, timerSubscription: Cancellable? = nil, currentIndex: Int) {
        self.slider = slider
        self.timerSubscription = timerSubscription
        self.currentIndex = currentIndex
    }
    
    public var body: some View {
        VStack(spacing: 16) {
            if let url = URL(string: slider.items[currentIndex].iconURL) {
                AsyncImage(url: url) { phase in
                    switch phase {
                    case .empty:
                        ProgressView()
                            .frame(height: 200)
                    case .success(let image):
                        image
                            .resizable()
                            .scaledToFit()
                            .frame(height: 200)
                            .cornerRadius(12)
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
            Text(slider.items[currentIndex].title)
                .font(.headline)
            HStack(spacing: 8) {
                ForEach(slider.items.indices, id: \.self) { index in
                    Circle()
                        .fill(index == currentIndex ? Color.blue : Color.gray.opacity(0.3))
                        .frame(width: 12, height: 12)
                }
            }
            .frame(maxWidth: .infinity, alignment: .center)
        }
        .onAppear {
            startTimer()
        }
        .onDisappear {
            stopTimer()
        }
    }

    private func startTimer() {
        stopTimer()
        timerSubscription = Timer.publish(every: slider.refreshTime, on: .main, in: .common)
            .autoconnect()
            .sink { _ in
                withAnimation {
                    currentIndex = (currentIndex + 1) % slider.items.count
                }
            }
    }
    
    private func stopTimer() {
        timerSubscription?.cancel()
        timerSubscription = nil
    }
}
