//
//  ProductsReducer.swift
//  SwiftShop
//
//  Created by Geordie Powers on 2019-11-16.
//  Copyright © 2019 Geordie Powers. All rights reserved.
//

import Foundation
import SwiftDux

final class ProductsReducer: Reducer {
  func reduce(state: OrderedState<Product>, action: ProductsAction) -> OrderedState<Product> {
    var state = state
    
    switch action {
    case .AddProduct(let name, let price):
      let id = UUID().uuidString
      state.append(Product(id: id, name: name, price: price))
      
    case .RemoveProduct(let id):
      state.remove(forId: id)

    case .SetProduct(let id, let product):
      state[id] = product

    case .MoveProduct(let from, let to):
      state.move(from: from, to: to)
    }
    
    return state
  }
}
