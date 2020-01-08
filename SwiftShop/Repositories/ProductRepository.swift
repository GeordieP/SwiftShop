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
  func productPublisher() -> DatabasePublishers.Value<[SimpleProduct]> {
    ValueObservation.tracking(value: { db in
      let request = ProductEntity
        .including(all: ProductEntity.tags)
      
      return try TaggedProductFetcher
        .fetchAll(db, request)
        .map { $0.toSimpleProduct() }
    }).publisher(in: database)
  }
  
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
  func setProductCompleteInList(productId: Int64, listId: Int64, complete: Bool) throws {
    try database.write { db in
      var productStatus = try ProductStatusEntity
        .filter(Column("listId") == listId && Column("productId") == productId)
        .fetchOne(db)
      
      productStatus!.complete = complete
      try productStatus!.update(db)
    }
  }
  
  func createProduct(_ product: SimpleProduct) throws {
    try database.write { db in
      var newProduct = ProductEntity(
        id: nil,
        name: product.name,
        price: product.price
      )
      
      try newProduct.insert(db)
      
      try product.tags.forEach({ tag in
        var newTag = ProductTagEntity(productId: newProduct.id!, tagId: tag.id)
        try newTag.insert(db)
      })
    }
  }
  
  // TODO: REFACTOR ME
  func updateProduct(_ updatedProduct: SimpleProduct) throws {
    try database.write { db in
      let request = ProductEntity
        .filter(key: updatedProduct.id)
        .including(all: ProductEntity.tags)
      
      if let taggedProduct = try TaggedProductFetcher.fetchOne(db, request) {
        var product = taggedProduct.productEntity
        let existingTags = taggedProduct.tagEntities
        
        let existingTagIds = existingTags.map({ $0.id! })
        let updatedTagIds = updatedProduct.tags.map({ $0.id })
        
        let difference = updatedTagIds.difference(from: existingTagIds)
        let newTagIds: [Int64] = difference.insertions.map({
          switch $0 {
          case .insert(_, let element, _):
            return element
          case .remove(_, let element, _):
            return element
          }
        })
        
        let removedTagIds: [Int64] = difference.removals.map({
          switch $0 {
          case .insert(_, let element, _):
            return element
          case .remove(_, let element, _):
            return element
          }
        })
        
        try removedTagIds.forEach({ id in
          try ProductTagEntity
            .filter(Column("productId") == product.id! && Column("tagId") == id)
            .deleteAll(db)
        })
        
        
        try newTagIds.forEach({ id in
          var newTagEntity = ProductTagEntity(productId: product.id!, tagId: id)
          try newTagEntity.insert(db)
        })
        
        product.name = updatedProduct.name
        product.price = updatedProduct.price
        
        try product.update(db)
      }
    }
  }
}
