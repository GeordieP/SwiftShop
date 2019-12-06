//
//  ProductStateEntity.swift
//  SwiftShop
//
//  Created by Geordie Powers on 2019-12-05.
//  Copyright © 2019 Geordie Powers. All rights reserved.
//

import GRDB

struct ProductStateEntity {
  var productId: Int64?
  var listId: Int64?
  var complete: Bool
}
