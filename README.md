# Utilities

# BoynerStudyCase

- An iOS application built with Swift and UIKit that lists news sources and their headlines. 
- Favorite news sources are persisted using Core Data, data flows are managed with Combine and async/await.


## Features

- **News Sources List**: Lists news sources fetched from the API.
- **Category Filtering**: Users can filter sources based on selected categories.
- **News Headlines**: Displays the latest headlines for each source.
- **Favorite Sources**: Core Data stores and manages favorite sources.
- **Slider View**: Highlights top news in a slider at the top.
- **Pull-to-Refresh**: Refresh the list by pulling down.
- **Retry Button**: Retry fetching data in case of API errors.
- **Timer**: Automatic refresh for slider and news updates.


## Architecture

- **MVVM**: Clear separation of View and ViewModel.
- **Combine & Async/Await**: Modern Swift concurrency for data and user actions.
- **Core Data**: Persistent storage for favorite sources.
- **Protocols & Dependency Injection**: Improves testability and decoupling.
- **SwiftUI Components**: Slider and custom views implemented in SwiftUI.


## Features Requirements and Technologies

- iOS 15+
- Xcode 15+
- Swift 5+
- Async/Await
- Combine
- Core Data


## Tests

- Unit tests are implemented using XCTest.
- Mock services and managers are used for dependency isolation.
- ViewModels and Core Data handling are fully tested.


## Installation

Clone repo:
```bash
git clone https://github.com/BetulDemirci/BoynerStudyCase.git
