//
//  LikedLable.swift
//  DogBreeds
//
//  Created by Anders Lindskog on 2024-06-02.
//

import SwiftUI

struct LikedLabel: View {
    @Binding var isLiked: Bool
    
    var accessibilityLabel: String
    
    var body: some View {
        Label(accessibilityLabel, systemImage: "heart.fill")
            .labelStyle(.iconOnly)
            .foregroundStyle(isLiked ? Color("LikedColor") : Color("UnselectedColor"))
    }
}

#Preview("Liked") {
    LikedLabel(isLiked: .constant(true), accessibilityLabel: "Liked")
}

#Preview("Not liked") {
    LikedLabel(isLiked: .constant(false), accessibilityLabel: "Not liked")
}
