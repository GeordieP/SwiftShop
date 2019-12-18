//
//  TagEntity.swift
//  SwiftShop
//
//  Created by Geordie Powers on 2019-12-08.
//  Copyright © 2019 Geordie Powers. All rights reserved.
//

import GRDB

struct TagEntity: Codable {
  var id: Int64?
  var name: String
  var color: String
}

// MARK: - GRDB

extension TagEntity: TableRecord {
  static let productTags = hasMany(ProductTagEntity.self)
  static let products = hasMany(ProductEntity.self, through: productTags, using: ProductTagEntity.product)
  
  var products: QueryInterfaceRequest<ProductEntity> {
    return request(for: TagEntity.products)
  }
  
  enum Columns {
    static let id = Column(CodingKeys.id)
    static let name = Column(CodingKeys.name)
    static let color = Column(CodingKeys.color)
  }
}

extension TagEntity: FetchableRecord, MutablePersistableRecord {
  mutating func didInsert(with rowID: Int64, for column: String?) {
    id = rowID
  }
}

// MARK: - Mapping 

extension TagEntity {
  func toTag() -> Tag {
    Tag(id: self.id!, name: self.name, color: self.color)
  }
}
