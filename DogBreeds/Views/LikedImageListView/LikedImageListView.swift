//
//  LikedImageListView.swift
//  DogBreeds
//
//  Created by Anders Lindskog on 2024-05-28.
//

import SwiftUI

struct LikedImageListView: View {
    @StateObject var viewModel: ViewModel
    @State private var hasAppeared: Bool = false
    @State private var showRemoveAlert = false
    
    var body: some View {
        AsyncView(source: viewModel) { filteredRowViewModels in
            List {
                ForEach(filteredRowViewModels) { rowViewModel in
                    NavigationLink(destination: BreedImageView(viewModel: rowViewModel.breedImageViewModel())) {
                        LikedImageListRowView(viewModel: rowViewModel)
                    }
                }
                .onDelete(perform: { indexSet in
                    viewModel.remove(atOffsets: indexSet)
                })
            }
            .onAppear {
                Task {
                    if hasAppeared {
                        await viewModel.load()
                    }
                    hasAppeared = true
                }
            }
            .navigationTitle(viewModel.title)
            .listStyle(InsetListStyle())
            .toolbar {
                if !viewModel.contentUnavailable {
                    ToolbarItem {
                        SortButton(sortAscending: $viewModel.sortAscending, accessibilityLabel: viewModel.sortButtonAccessibilityLabel)
                    }
                    ToolbarItem {
                        Menu {
                            Picker(viewModel.filterOptionsAccessibilityLabel, selection: $viewModel.selectedFilter.title) {
                                ForEach(viewModel.filters, id: \.value) { item in
                                    Text(item.title)
                                }
                            }
                        } label: {
                            Label(viewModel.filterMenuAccessibilityLabel, systemImage: "slider.horizontal.3")
                        }
                    }
                    ToolbarItem {
                        Button {
                            showRemoveAlert = true
                        } label: {
                            Label(viewModel.removeButtonAccessibilityLabel, systemImage: "trash")
                                .labelStyle(.iconOnly)
                        }
                    }
                }
            }
            .alert(isPresented: $showRemoveAlert) {
                Alert(
                    title: Text(viewModel.removeAlertTitle),
                    message: Text(viewModel.removeAlertMessage),
                    primaryButton: .destructive(Text(viewModel.removeAlertDeleteButtonText)) {
                        viewModel.removeAll()
                    },
                    secondaryButton: .cancel()
                )
            }
            .overlay {
                if viewModel.contentUnavailable {
                    ContentUnavailableView(viewModel.contentUnavailableTitle,
                                           systemImage: "heart",
                                           description: Text(viewModel.contentUnavailableMessage))
                    .symbolVariant(.slash.fill)
                }
            }
        }
    }
}

#Preview {
    LikedImageListView(viewModel: LikedImageListView.ViewModel.preview)
}
