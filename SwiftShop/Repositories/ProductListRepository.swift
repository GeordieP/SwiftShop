//
//  ProductListRepository.swift
//  SwiftShop
//
//  Created by Geordie Powers on 2019-12-09.
//  Copyright © 2019 Geordie Powers. All rights reserved.
//

import GRDB
import GRDBCombine

struct ProductListRepository {
  private var database: DatabaseWriter
  
  init(_ db: DatabaseWriter) {
    database = db
  }
}

// MARK: - Publishers

extension ProductListRepository {
  func productListPublisher() -> DatabasePublishers.Value<[ProductList]> {
    ValueObservation.tracking(value: { db in
      try ListEntity
        .fetchAll(db)
        .map { $0.toProductList() }
    }).publisher(in: database)
  }
}
