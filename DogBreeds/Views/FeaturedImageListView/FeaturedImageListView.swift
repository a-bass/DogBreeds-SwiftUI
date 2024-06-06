//
//  FeaturedImageListView.swift
//  DogBreeds
//
//  Created by Anders Lindskog on 2024-05-26.
//

import SwiftUI

struct FeaturedImageListView: View {
    @StateObject var viewModel: ViewModel
    
    var body: some View {
        AsyncView(source: viewModel) { rowViewModels in
            ScrollView {
                ForEach(rowViewModels) { rowViewModel in
                    FeaturedImageListRowView(viewModel: rowViewModel)
                        .padding(.leading)
                        .padding(.trailing)
                        .padding(.bottom)
                }
            }
            .navigationTitle(viewModel.title)
            .toolbar {
                ToolbarItem {
                    Button {
                        Task {
                            await viewModel.load()
                        }
                    } label: {
                        Label(viewModel.refreshButtonAccessibilityLabel, systemImage: "arrow.clockwise")
                            .labelStyle(.iconOnly)
                    }
                }
            }
        }
    }
}

#Preview {
    FeaturedImageListView(viewModel: FeaturedImageListView.ViewModel.preview)
}

