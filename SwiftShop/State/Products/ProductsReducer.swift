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
      
    case .RemoveProduct(let at):
      state.remove(at: at)
      
    case .SetProduct(let at, let product):
      state.remove(at: at)
      state.insert(product, at: at)
      
    case .MoveProduct(let from, let to):
      state.move(from: from, to: to)
    }
    
    return state
  }
}
