//
//  BreedListSectionView.swift
//  DogBreeds
//
//  Created by Anders Lindskog on 2024-06-02.
//

import SwiftUI

struct BreedListSectionView: View {
    @StateObject var viewModel: ViewModel
    
    var body: some View {
        Section(header: Text(viewModel.indexCharacter)) {
            ForEach(viewModel.rowViewModels) { rowViewModel in
                NavigationLink(destination: BreedImagesGridView(viewModel: rowViewModel.gridViewModel())) {
                    BreedListRowView(viewModel: rowViewModel)
                }
            }
        }
    }
}

#Preview {
    BreedListSectionView(viewModel: BreedListSectionView.ViewModel.preview)
}
