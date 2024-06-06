//
//  FeaturedImageListRowViewModel.swift
//  DogBreeds
//
//  Created by Anders Lindskog on 2024-06-01.
//

import Foundation

extension FeaturedImageListRowView {
    
    class ViewModel: Identifiable, ObservableObject {
        let imageUrl: String
        let isLiked: Bool
        
        var accessibilityLabel:String {
            String(localized: "Featured breed", comment: "Featured image view accessibility label - image")
        }
        
        init(imageUrl: String, isLiked: Bool) {
            self.imageUrl = imageUrl
            self.isLiked = isLiked
        }
    }
}
