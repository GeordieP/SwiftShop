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
  func reduce(state: OrderedState<List>, action: ListsAction) -> OrderedState<List> {
    var state = state
    
    switch action {
    case .AddList(let name):
      let id = UUID().uuidString
      state.append(List(id: id, name: name))

    case .RemoveList(let id):
      state.remove(forId: id)
      
    case .SetList(let id, let list):
      state[id] = list
      
    case .MoveList(let from, let to):
      state.move(from: from, to: to)
    }
    
    return state
  }
}
