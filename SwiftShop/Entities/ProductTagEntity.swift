//
//  ProductTagEntity.swift
//  SwiftShop
//
//  Created by Geordie Powers on 2019-12-08.
//  Copyright © 2019 Geordie Powers. All rights reserved.
//

import GRDB

struct ProductTagEntity: Codable {
  var productId: Int64
  var tagId: Int64
}

// MARK: - GRDB

extension ProductTagEntity: TableRecord {
  static let product = belongsTo(ProductEntity.self)
  static let tag = belongsTo(TagEntity.self)
  
  enum Columns {
    static let productId = Column(CodingKeys.productId)
    static let tagId = Column(CodingKeys.tagId)
  }
}

extension ProductTagEntity: FetchableRecord, MutablePersistableRecord {}
