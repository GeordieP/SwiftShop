//
//  ProductRepository.swift
//  SwiftShop
//
//  Created by Geordie Powers on 2019-12-06.
//  Copyright © 2019 Geordie Powers. All rights reserved.
//

import Combine
import GRDB
import GRDBCombine
import Dispatch

struct ProductRepository {
  private var database: DatabaseWriter
}
  
extension ProductRepository {
  init(_ db: DatabaseWriter) {
    database = db
  }
  
  func publisher() -> DatabasePublishers.Value<[SimpleProduct]> {
    ValueObservation
      .tracking(value: { db in
        let products = try ProductEntity.fetchAll(db)
        // let tags = try TagEntity.fetchAll(db) ...
        
        return products.map({
          SimpleProduct(
            id: $0.id!,
            name: $0.name,
            price: $0.price,
            tags: []
          )
        })
      })
      .publisher(in: database)
  }
}

extension ProductRepository {
  func add<P: Product>(newProduct product: P) throws {
    try database.write { db in
      var entity = ProductEntity(name: product.name, price: product.price)
      try entity.insert(db)
    }
  }
  
  func remove(_ id: Int64) throws {
    try database.write { db in
      _ = try ProductEntity.deleteOne(db, key: id)
    }
  }
  
  func removeAll() throws {
    try database.write { db in
      _ =  try ProductEntity.deleteAll(db)
    }
  }
}
