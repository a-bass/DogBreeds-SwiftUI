//
//  BreedListView.swift
//  DogBreeds
//
//  Created by Anders Lindskog on 2024-05-05.
//

import SwiftUI

struct BreedListView: View {
    @StateObject var viewModel: ViewModel
    
    var body: some View {
        AsyncView(source: viewModel) { sectionViewModels in
            List {
                ForEach(sectionViewModels) { sectionViewModel in
                    BreedListSectionView(viewModel: sectionViewModel)
                }
            }
            .listStyle(InsetListStyle())
            .headerProminence(.increased)
            .toolbar {
                ToolbarItem {
                    SortButton(sortAscending: $viewModel.sortAscending, accessibilityLabel: viewModel.sortButtonAccessibilityLabel)
                }
                ToolbarItem {
                    Menu {
                        Toggle(isOn: $viewModel.showSubBreeds) {
                            Text(viewModel.showSubBreedsLabel)
                        }
                        Picker(viewModel.filterOptionsAccessibilityLabel, selection: $viewModel.selectedFilterOption.title) {
                            ForEach(viewModel.filterOptions, id: \.value) { item in
                                Text(item.title)
                            }
                        }
                    } label: {
                        Label(viewModel.filterMenuAccessibilityLabel, systemImage: "slider.horizontal.3")
                    }
                }
            }
            .navigationTitle(viewModel.title)
        }
    }
}

#Preview {
    BreedListView(viewModel: BreedListView.ViewModel.preview)
}
