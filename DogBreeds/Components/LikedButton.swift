//
//  LikedButton.swift
//  DogBreeds
//
//  Created by Anders Lindskog on 2024-05-23.
//

import SwiftUI

struct LikedButton: View {
    @Binding var isLiked: Bool
    
    var accessibilityLabel: String
    
    var body: some View {
        Button {
            isLiked.toggle()
        } label: {
            LikedLabel(isLiked: $isLiked, accessibilityLabel: accessibilityLabel)
                .padding(5)
                .overlay {
                    RoundedRectangle(cornerRadius: 5)
                        .stroke(isLiked ? Color("LikedColor") : Color("UnselectedColor"), lineWidth: 1)
                }
        }
    }
}

#Preview("Liked") {
    LikedButton(isLiked: .constant(true), accessibilityLabel: "Remove like")
}

#Preview("Not liked") {
    LikedButton(isLiked: .constant(false), accessibilityLabel: "Add like")
}
