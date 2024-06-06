//
//  BreedImageView.swift
//  DogBreeds
//
//  Created by Anders Lindskog on 2024-05-23.
//

import SwiftUI

struct BreedImageView: View {
    @StateObject var viewModel: ViewModel
    
    var body: some View {
        AsyncView(source: viewModel) { url in
            ScrollView {
                VStack {
                    LikedButton(isLiked: $viewModel.isLiked, accessibilityLabel: viewModel.likedButtonAccessibilityLabel)
                    
                    AsyncBreedImage(urlString: url, accessibilityLabel: viewModel.title)
                        .frame(maxWidth: .infinity, minHeight: 150)
                        .scaledToFit()
                        .border(Color("BorderColor"), width: 1)
                        
                    Text(viewModel.imageName)
                        .font(.subheadline)
                        .accessibilityLabel(viewModel.fileNameTextAccessibilityLabel)
                }
                Spacer()
            }
            .navigationTitle(viewModel.title)
            .toolbar {
                if let url = URL(string: url) {
                    ToolbarItem(placement: .topBarTrailing) {
                        ShareLink(item: url)
                    }
                }
            }
            .toolbar(.hidden, for: .tabBar)
            .alert(isPresented: $viewModel.showRemoveAlert) {
                Alert(
                    title: Text(viewModel.removeAlertTitle),
                    message: Text(viewModel.removeAlertMessage),
                    primaryButton: .destructive(Text(viewModel.removeAlertDeleteButtonText)) {
                        viewModel.removeLike()
                    },
                    secondaryButton: .cancel() {
                        viewModel.cancelRemoveLike()
                    }
                )
            }
        }
    }
}

#Preview {
    BreedImageView(viewModel: BreedImageView.ViewModel.preview)
}
