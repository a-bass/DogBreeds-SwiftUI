//
//  BreedImagesGridItemView.swift
//  DogBreeds
//
//  Created by Anders Lindskog on 2024-05-21.
//

import SwiftUI

struct BreedImagesGridItemView: View {
    @StateObject var viewModel: ViewModel
    
    var body: some View {
        ZStack() {
            AsyncBreedImage(urlString: viewModel.imageUrl, accessibilityLabel: "")
        }
        .frame(width: 150, height: 150)
        .overlay(alignment: .bottomTrailing) {
            Image(systemName: "ellipsis")
                            .padding(5)
                            .background(Color("BorderColor"))
        }
        .overlay {
            RoundedRectangle(cornerRadius: 5)
                .stroke(Color("BorderColor"), lineWidth: 1)
        }
        .clipShape(.rect(cornerRadius: 5))
        .overlay(alignment: .topTrailing) {
            LikedLabel(isLiked: $viewModel.isLiked, accessibilityLabel: "")
                .padding(5)
        }
        .accessibilityElement()
        .accessibilityAddTraits(.isButton)
        .accessibilityLabel(viewModel.accessibilityLabel)
    }
}

#Preview {
    BreedImagesGridItemView(viewModel: BreedImagesGridItemView.ViewModel.preview)
}
