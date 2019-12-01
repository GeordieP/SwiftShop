//
//  AppState.swift
//  SwiftShop
//
//  Created by Geordie Powers on 2019-11-16.
//  Copyright © 2019 Geordie Powers. All rights reserved.
//

import Foundation
import SwiftDux

let DEFAULT_PRODUCTS = OrderedState(
  Product(id: "1", name: "First", price: 3.00),
  Product(id: "2", name: "Second", price: 2.00),
  Product(id: "3", name: "Third", price: 1.00),
  Product(id: "4", name: "Fourth", price: 0.00)
)

let DEFAULT_LISTS = OrderedState(ProductsList(id: "MAIN", name: "Main List"))

struct AppState : StateType {
  var products: OrderedState<Product> = DEFAULT_PRODUCTS
  var lists: OrderedState<ProductsList> = DEFAULT_LISTS
}
