//
//  AppModel.swift
//  SwiftShop
//
//  Created by Geordie Powers on 2019-12-07.
//  Copyright © 2019 Geordie Powers. All rights reserved.
//

import UIKit
import Combine
import GRDB
import GRDBCombine

struct AppModel {
  private let database: () -> DatabaseWriter
  
  init(database: @escaping () -> DatabaseWriter) {
    self.database = database
  }

  func products() -> ProductRepository { ProductRepository(database()) }
  func lists() -> ProductListRepository { ProductListRepository(database()) }

  func TEMP_testSetup() throws {
    try database().write { db in
      var list = ListEntity(id: nil, name: AppConstants.DEFAULT_LIST_NAME)
      var product = ProductEntity(id: nil, name: "first product", price: 0.0)
      var tag = TagEntity(id: nil, name: "MyTag", color: "blue")
      
      try list.insert(db)
      try product.insert(db)
      try tag.insert(db)
      
      var productStatus = ProductStatusEntity(listId: list.id!, productId: product.id!, complete: false)
      var productTag = ProductTagEntity(productId: product.id!, tagId: tag.id!)
      
      try productStatus.insert(db)
      try productTag.insert(db)
    }
  }
}
