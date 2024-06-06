//
//  SortButton.swift
//  DogBreeds
//
//  Created by Anders Lindskog on 2024-05-30.
//

import SwiftUI

struct SortButton: View {
    @Binding var sortAscending: Bool
    
    var accessibilityLabel: String
    
    var body: some View {
        Button {
            sortAscending.toggle()
        } label: {
            Label(accessibilityLabel, systemImage: "arrow.up.arrow.down")
                .foregroundStyle(
                    sortAscending ? Color("AccentColor") : Color("UnselectedColor"), 
                    sortAscending ? Color("UnselectedColor") : Color("AccentColor"))
                .labelStyle(.iconOnly)
        }
    }
}

#Preview("Ascending") {
    SortButton(sortAscending: .constant(true), accessibilityLabel: "Sort")
}

#Preview("Descending") {
    SortButton(sortAscending: .constant(false), accessibilityLabel: "Sort")
}
