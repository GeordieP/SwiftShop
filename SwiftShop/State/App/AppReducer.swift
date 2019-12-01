//
//  AppReducer.swift
//  SwiftShop
//
//  Created by Geordie Powers on 2019-11-16.
//  Copyright © 2019 Geordie Powers. All rights reserved.
//

import Foundation
import SwiftDux

final class AppReducer : Reducer {
  let productsReducer = ProductsReducer()
  let listsReducer = ListsReducer()
  
  func reduce(state: AppState, action: AppAction) -> AppState {
    return AppState(
      products: productsReducer.reduce(state: state.products, action: action),
      lists: listsReducer.reduce(state: state.lists, action: action)
    )
  }
}
