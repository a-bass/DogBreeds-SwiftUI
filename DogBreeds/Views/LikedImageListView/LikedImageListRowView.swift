//
//  LikedImageListRowView.swift
//  DogBreeds
//
//  Created by Anders Lindskog on 2024-05-28.
//

import SwiftUI

struct LikedImageListRowView: View {
    @StateObject var viewModel: ViewModel
    
    var body: some View {
        HStack(alignment: .center) {
            AsyncBreedImage(urlString: viewModel.imageUrl, accessibilityLabel: "")
                .frame(width: 60, height: 60)
                .clipShape(.rect(cornerRadius: 5))
                .overlay {
                    RoundedRectangle(cornerRadius: 5)
                        .stroke(Color("BorderColor"), lineWidth: 1)
                }
            
            VStack(alignment: .leading) {
                Text(viewModel.title)
                    .font(.headline)
                Text(viewModel.date)
                    .font(.subheadline)
            }
            
            Spacer()
            
            LikedLabel(isLiked: $viewModel.isLiked, accessibilityLabel: "")
        }
        .accessibilityElement()
        .accessibilityAddTraits(.isButton)
        .accessibilityLabel(viewModel.accessibilityLabel)
    }
}

#Preview {
    LikedImageListRowView(viewModel: LikedImageListRowView.ViewModel.preview)
}
