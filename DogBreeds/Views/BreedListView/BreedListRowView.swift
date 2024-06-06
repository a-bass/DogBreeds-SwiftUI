//
//  BreedListRowView.swift
//  DogBreeds
//
//  Created by Anders Lindskog on 2024-05-17.
//

import SwiftUI

struct BreedListRowView: View {
    @StateObject var viewModel: ViewModel
    @State private var hasAppeared: Bool = false
    
    var body: some View {
        HStack(alignment: .center) {
            Text(viewModel.title)
                .font(!viewModel.isSubItem ? .headline : .subheadline)
                .padding(.leading, !viewModel.isSubItem ? 0 : 20)
            
            Spacer()
            
            LikedLabel(isLiked: $viewModel.hasLikedImages, accessibilityLabel: "")
                .padding(5)
            
            AsyncBreedImage(urlString: viewModel.imageUrl, accessibilityLabel: "")
                .frame(width: 60, height: 60)
                .clipShape(.rect(cornerRadius: 5))
                .overlay {
                    RoundedRectangle(cornerRadius: 5)
                        .stroke(Color("BorderColor"), lineWidth: 1)
                }
        }
        .onAppear() {
            if hasAppeared {
                viewModel.update()
            }
            hasAppeared = true
        }
        .accessibilityElement()
        .accessibilityAddTraits(.isButton)
        .accessibilityLabel(viewModel.accessibilityLabel)
    }
}

#Preview {
    BreedListRowView(viewModel: BreedListRowView.ViewModel.preview)
}
