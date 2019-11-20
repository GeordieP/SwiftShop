//
//  Filterer.swift
//  SwiftShop
//
//  Created by Geordie Powers on 2019-11-18.
//  Copyright © 2019 Geordie Powers. All rights reserved.
//

import Foundation

class Filterer<T> : ObservableObject {
    typealias FilterFn = (T) -> Bool
    @Published var filters: [String: FilterFn]
    
    init() {
        filters = [String: FilterFn]()
    }
    
    func addFilter(_ name: String, _ filterFn: @escaping FilterFn) {
        filters.updateValue(filterFn, forKey: name)
    }
    
    func removeFilter(_ name: String) {
        filters.removeValue(forKey: name)
    }
    
    func applyFilters(_ collection: [T]) -> [T] {
        let filterReducer = { (a: [T], filterFn: FilterFn) in a.filter(filterFn) as [T] }
        return filters.values.reduce(collection, filterReducer)
    }
}
