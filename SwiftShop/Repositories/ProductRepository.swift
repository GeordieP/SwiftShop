//
//  ProductRepository.swift
//  SwiftShop
//
//  Created by Geordie Powers on 2019-12-08.
//  Copyright © 2019 Geordie Powers. All rights reserved.
//

import GRDB
import GRDBCombine

struct ProductRepository {
  private var database: DatabaseWriter
  
  init(_ db: DatabaseWriter) {
    database = db
  }
}

// MARK: - Publishers

extension ProductRepository {
  func listedProductPublisher(listId: Int64) -> DatabasePublishers.Value<[ListedProduct]> {
    ValueObservation.tracking(value: { db in
      let request = ProductStatusEntity
        .all()
        .filter(Column("listId") == listId)
        .including(required: ProductStatusEntity.product
          .including(all: ProductEntity.tags))
      
      return try ListedProductFetcher
        .fetchAll(db, request)
        .map { $0.toListedProduct() }
    }).publisher(in: database)
  }
}

// MARK: - Actions

extension ProductRepository {
  func testTagProduct(productId: Int64) throws {
    try database.write { db in
      // make a tag to use for now
      var newTag = TagEntity(id: nil, name: "2nd", color: "red")
      try newTag.insert(db)
      
      // make an association with given product
      var newProductTag = ProductTagEntity(productId: productId, tagId: newTag.id!)
      try newProductTag.insert(db)
    }
  }
  
  func setProductCompleteInList(productId: Int64, listId: Int64, complete: Bool) throws {
    try database.write { db in
      var productStatus = try ProductStatusEntity
        .filter(Column("listId") == listId && Column("productId") == productId)
        .fetchOne(db)

      productStatus!.complete = complete
      try productStatus!.update(db)
    }
  }
}