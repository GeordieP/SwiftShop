//
//  ProductEntity.swift
//  SwiftShop
//
//  Created by Geordie Powers on 2019-12-08.
//  Copyright © 2019 Geordie Powers. All rights reserved.
//

import GRDB

struct ProductEntity: Codable {
  var id: Int64?
  var name: String
  var price: Double
}

// MARK: - GRDB

extension ProductEntity: TableRecord {
  static let productTags = hasMany(ProductTagEntity.self)
  static let tags = hasMany(TagEntity.self, through: productTags, using: ProductTagEntity.tag)
  
  static let productStatuses = hasMany(ProductStatusEntity.self)
  static let lists = hasMany(ListEntity.self, through: productStatuses, using: ProductStatusEntity.list)

  enum Columns {
    static let id = Column(CodingKeys.id)
    static let name = Column(CodingKeys.name)
    static let price = Column(CodingKeys.price)
  }
}

extension ProductEntity: FetchableRecord, MutablePersistableRecord {
  mutating func didInsert(with rowID: Int64, for column: String?) {
    id = rowID
  }
}
