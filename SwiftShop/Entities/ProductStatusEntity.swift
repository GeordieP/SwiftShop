//
//  ProductStatusEntity.swift
//  SwiftShop
//
//  Created by Geordie Powers on 2019-12-08.
//  Copyright © 2019 Geordie Powers. All rights reserved.
//

import GRDB

struct ProductStatusEntity: Codable {
  var listId: Int64
  var productId: Int64
  var complete: Bool
}

// MARK: - GRDB

extension ProductStatusEntity: TableRecord {
  static let list = belongsTo(ListEntity.self)
  static let product = belongsTo(ProductEntity.self)
  
  enum Columns {
    static let listId = Column(CodingKeys.listId)
    static let productId = Column(CodingKeys.productId)
    static let complete = Column(CodingKeys.complete)
  }
}

extension ProductStatusEntity: FetchableRecord, MutablePersistableRecord {}
