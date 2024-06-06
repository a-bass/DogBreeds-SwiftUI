//
//  FeaturedImageListRowView.swift
//  DogBreeds
//
//  Created by Anders Lindskog on 2024-06-01.
//

import SwiftUI

struct FeaturedImageListRowView: View {
    @StateObject var viewModel: ViewModel
    
    var body: some View {
        ZStack() {
            AsyncBreedImage(urlString: viewModel.imageUrl, accessibilityLabel: "")
                .scaledToFit()
        }
        .frame(maxWidth: .infinity, minHeight: 120)
        .overlay {
            RoundedRectangle(cornerRadius: 5)
                .stroke(Color("BorderColor"), lineWidth: 1)
        }
        .clipShape(.rect(cornerRadius: 5))
        .overlay(alignment: .topTrailing) {
            LikedLabel(isLiked: .constant(viewModel.isLiked), accessibilityLabel: "")
                .padding()
        }
        .accessibilityElement()
        .accessibilityAddTraits(.isImage)
        .accessibilityLabel(viewModel.accessibilityLabel)
    }
}

#Preview {
    FeaturedImageListRowView(viewModel: FeaturedImageListRowView.ViewModel.preview)
}
