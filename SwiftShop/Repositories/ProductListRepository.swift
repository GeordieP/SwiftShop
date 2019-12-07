//
//  ProductListRepository.swift
//  SwiftShop
//
//  Created by Geordie Powers on 2019-12-06.
//  Copyright © 2019 Geordie Powers. All rights reserved.
//

import Combine
import GRDB
import GRDBCombine
import Dispatch

struct ProductListRepository {
  internal var database: DatabaseWriter
}

extension ProductListRepository {
  init(_ db: DatabaseWriter) {
    database = db
  }
  
//  func publisher() -> DatabasePublishers.Value<[ProductList]> {
//    ValueObservation
//      .tracking(value: { db in
//        // build a productlist model for each list entity
//        let lists = try ListEntity.
//      })
//      .publisher(in: database)
//  }
}
