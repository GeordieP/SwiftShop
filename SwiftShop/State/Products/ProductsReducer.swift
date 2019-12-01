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
  typealias State = OrderedState<Product>
  
  func reduce(state: State, action: AppAction) -> State {
    var state = state
    
    switch action {
    case .CreateProduct(let name, let price):
      let id = UUID().uuidString
      state.append(Product(id: id, name: name, price: price))
      
    case .UpdateProduct(let updatedProduct):
      // TODO: check if state doesn't contain matching product id
      state[updatedProduct.id] = updatedProduct
      
    case .DeleteProduct(let id):
      state.remove(forId: id)
      
    case .MoveProduct(let from, let to):
      state.move(from: from, to: to)
      
// TODO
//    case .TagProduct(let productId, let tagId):
//      break
//    case .UntagProduct(let productId, let tagId):
//      break
      
    default:
      break
    }
    
    return state
  }
}
