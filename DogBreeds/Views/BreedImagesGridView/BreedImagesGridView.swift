//
//  BreedImagesGridView.swift
//  DogBreeds
//
//  Created by Anders Lindskog on 2024-05-17.
//

import SwiftUI

struct BreedImagesGridView: View {
    @StateObject var viewModel: ViewModel
    @State private var hasAppeared: Bool = false
    
    private let gridItemLayout = [
        GridItem(.adaptive(minimum: 150))
    ]
    
    var body: some View {
        AsyncView(source: viewModel) { itemViewModels in
            ScrollView{
                LazyVGrid(columns: gridItemLayout, spacing: 20) {
                    ForEach(itemViewModels) { itemViewModel in
                        NavigationLink(destination: BreedImageView(viewModel: itemViewModel.breedImageViewModel())) {
                            BreedImagesGridItemView(viewModel: itemViewModel)
                        }
                    }
                }
            } 
            .padding()
            .onAppear {
                if hasAppeared {
                    viewModel.update()
                }
                hasAppeared = true
            }
            .navigationTitle(viewModel.title)
            .toolbar {
                if viewModel.hasLikedImages {
                    ToolbarItem {
                        Button {
                            viewModel.filterBylikedImages.toggle()
                        } label: {
                            Label(viewModel.filterButtonAccessibilityLabel, systemImage: viewModel.filterBylikedImages ? "heart.fill" : "heart")
                                .labelStyle(.iconOnly)
                        }
                    }
                }
            }
        }
    }
}

#Preview {
    BreedImagesGridView(viewModel: BreedImagesGridView.ViewModel.preview)
}
