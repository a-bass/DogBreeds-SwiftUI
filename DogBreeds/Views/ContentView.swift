//
//  ContentView.swift
//  DogBreeds
//
//  Created by Anders Lindskog on 2024-05-24.
//

import SwiftUI

struct ContentView: View {
    @StateObject var viewModel: ViewModel
    @State private var selection: ViewModel.Tab = .featured
    
    var body: some View {
        TabView(selection: $selection) {
            FeaturedImageListView(viewModel: viewModel.featuredViewModel())
                .tabItem {
                    Label(ViewModel.Tab.featured.title, systemImage: ViewModel.Tab.featured.image)
                }
                .tag(ViewModel.Tab.featured)
            BreedListView(viewModel: viewModel.breedsViewModel())
                .tabItem {
                    Label(ViewModel.Tab.list.title, systemImage: ViewModel.Tab.list.image)
                }
                .tag(ViewModel.Tab.list)
            LikedImageListView(viewModel: viewModel.likedImagesViewModel())
                .tabItem {
                    Label(ViewModel.Tab.liked.title, systemImage: ViewModel.Tab.liked.image)
                }
                .tag(ViewModel.Tab.liked)
        }
    }
}

#Preview {
    return ContentView(viewModel: ContentView.ViewModel.preview)
}
