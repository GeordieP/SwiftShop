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
  
  func reduceNext(state: AppState, action: Action) -> AppState {
    return AppState(products: productsReducer.reduceAny(state: state.products, action: action))
  }
}
