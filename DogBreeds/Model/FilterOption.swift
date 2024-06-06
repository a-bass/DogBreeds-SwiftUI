//
//  FilterOption.swift
//  DogBreeds
//
//  Created by Anders Lindskog on 2024-05-29.
//

import Foundation

struct FilterOption {
    let value: String
    var title: String
}

extension FilterOption {
    static var none = FilterOption(value: "- - -", title: "- - -")
    
    init(value: String) {
        self.value = value
        self.title = value.capitalized
    }
    
    static func options(from values:[String] ) -> [FilterOption] {
        let sortedValues = Array(Set(values)).sorted()
        var filterOptions = sortedValues.map(FilterOption.init)
        filterOptions.insert(none, at: 0)
        
        return filterOptions
    }
}

extension FilterOption: Equatable {

    static func == (lhs: FilterOption, rhs: FilterOption) -> Bool {
        lhs.title == rhs.title
    }
}
