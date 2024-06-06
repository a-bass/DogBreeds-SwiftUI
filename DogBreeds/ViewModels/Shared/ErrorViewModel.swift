//
//  ErrorViewModel.swift
//  DogBreeds
//
//  Created by Anders Lindskog on 2024-05-27.
//

import Foundation

extension ErrorView {
    
    struct ViewModel {
        private let error: Error
        
        var title: String {
            return String(localized: "An error has occurred!", comment: "Error view - title")
        }
        var errorDescription: String {
            return error.localizedDescription
        }
        var guidance: String {
            return String(localized: "Try again later.", comment: "Error view - guidance")
        }

        init(error: Error) {
            self.error = error
        }
    }
}

