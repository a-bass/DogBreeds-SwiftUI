//
//  LoadableViewModel.swift
//  DogBreeds
//
//  Created by Anders Lindskog on 2024-05-27.
//

import Foundation

@MainActor
protocol LoadableViewModel: ObservableObject {
    associatedtype Output
    
    var state: LoadingState<Output> { get }

    func load() async
}
