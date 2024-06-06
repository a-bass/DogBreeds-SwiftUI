//
//  AsyncView.swift
//  DogBreeds
//
//  Created by Anders Lindskog on 2024-05-27.
//

import SwiftUI

struct AsyncView<Source: LoadableViewModel, Content: View>: View {
    @StateObject var source: Source
    @State private var hasAppeared: Bool = false
    
    var content: (Source.Output) -> Content

    var body: some View {
        NavigationStack {
            switch source.state {
            case .loading:
                ProgressView()
            case .failed(let error):
                ErrorView(viewModel: ErrorView.ViewModel(error: error))
            case .loaded(let output):
                content(output)
            }
        }
        .task {
            if !hasAppeared {
                await source.load()
                hasAppeared = true
            }
        }
        .refreshable {
            Task {
                await source.load()
            }
        }
    }
}
