//
//  LoadingState.swift
//  DogBreeds
//
//  Created by Anders Lindskog on 2024-05-26.
//

import Foundation

enum LoadingState<Value> {
    case loading
    case failed(Error)
    case loaded(Value)
}
