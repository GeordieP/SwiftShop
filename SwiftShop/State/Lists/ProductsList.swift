//
//  ProductsList.swift
//  SwiftShop
//
//  Created by Geordie Powers on 2019-11-26.
//  Copyright © 2019 Geordie Powers. All rights reserved.
//

import Foundation
import SwiftDux

struct ProductsList: IdentifiableState {
  var id: String
  var name: String
  var products: OrderedState<ProductStatus> = OrderedState<ProductStatus>()
}

struct ProductStatus: IdentifiableState {
  typealias ProductId = String
  var id: ProductId
  var complete: Bool = false
}
