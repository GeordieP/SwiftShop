//
//  ListsReducer.swift
//  SwiftShop
//
//  Created by Geordie Powers on 2019-11-26.
//  Copyright © 2019 Geordie Powers. All rights reserved.
//

import Foundation
import SwiftDux

final class ListsReducer: Reducer {
  typealias State = OrderedState<ProductsList>
  
  func reduce(state: State, action: AppAction) -> State {
    var state = state
    
    switch action {
    case .CreateList(let name):
      let id = UUID().uuidString
      state.append(ProductsList(id: id, name: name))
      
    // TODO: should this action be "RenameList" instead, and only deal with the name?
    case .UpdateList(let updatedList):
      // TODO: check if list ID exists
      // TODO: don't overwrite products
      state[updatedList.id] = updatedList
      
    case .DeleteList(let id):
      state.remove(forId: id)
      
    case .AddProductToList(let productId, let listId):
      guard var list = state[listId] else { break }
      list.products.append(ProductStatus(id: productId))
      state[listId] = list

    case .RemoveProductFromList(let productId, let listId):
      guard var list = state[listId] else { break }
      list.products.remove(forId: productId)
      state[listId] = list
      
    case .CompleteProduct(let listId, let productId):
      guard let list = state[listId] else { break }
      guard var product = list.products[productId] else { break }
      product.complete = true
      state[listId]!.products[productId] = product

    case .UncompleteProduct(let listId, let productId):
      guard let list = state[listId] else { break }
      guard var product = list.products[productId] else { break }
      product.complete = false
      state[listId]!.products[productId] = product

    default:
      break
    }

    return state
  }
}
