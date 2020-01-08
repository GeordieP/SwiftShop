//
//  FilterManager.swift
//  SwiftShop
//
//  Created by Geordie Powers on 2019-11-18.
//  Copyright © 2019 Geordie Powers. All rights reserved.
//

import Foundation

class FilterManager<T> : ObservableObject {
  typealias Filter = (T) -> Bool
  @Published var filters: [String: Filter]
  
  init(defaultFilters: [String: Filter] = [String: Filter]()) {
    filters = defaultFilters
  }
  
  /// Update a filter by name, or insert it if it does not exist.
  ///
  /// - Parameters:
  ///     - name: Name of filter
  ///     - filterFn: Closure for filtering a T
  func upsert(_ name: String, _ filterFn: @escaping Filter) {
    filters.updateValue(filterFn, forKey: name)
  }
  
  /// Remove a filter by name.
  ///
  /// - Parameters:
  ///     - name: Name of filter to remove
  func remove(_ name: String) {
    filters.removeValue(forKey: name)
  }
  
  /// Apply the current list of filters to a collection of T.
  ///
  /// - Parameters:
  ///     - to: Collection to filter
  /// - Returns: A filtered collection of T
  func apply(to collection: [T]) -> [T] {
    filters.values.reduce(collection, { $0.filter($1) })
  }
}
