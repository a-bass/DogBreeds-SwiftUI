//
//  ErrorView.swift
//  DogBreeds
//
//  Created by Anders Lindskog on 2024-05-27.
//

import SwiftUI

struct ErrorView: View {
    let viewModel: ViewModel
    
    var body: some View {
        VStack {
            Spacer()
            
            Image(systemName: "exclamationmark.octagon.fill")
                .imageScale(.large)
                .foregroundStyle(.red)
                .accessibilityHidden(true)
            Text(viewModel.title)
                .font(.title)
                .padding()
            Text(viewModel.errorDescription)
                .font(.headline)
            Text(viewModel.guidance)
                .font(.caption)
                .padding(.top)
                
            Spacer()
            Spacer()
        }
        .padding()
        .cornerRadius(16)
    }
}

#Preview {
    ErrorView(viewModel: ErrorView.ViewModel.preview)
}
