//
//  ListEntity.swift
//  SwiftShop
//
//  Created by Geordie Powers on 2019-12-08.
//  Copyright © 2019 Geordie Powers. All rights reserved.
//

import GRDB

struct ListEntity: Codable {
  var id: Int64?
  var name: String
}

// MARK: - GRDB

extension ListEntity: TableRecord {
  static let productStatuses = hasMany(ProductStatusEntity.self)
  static let products = hasMany(ProductEntity.self, through: productStatuses, using: ProductStatusEntity.product)

  enum Columns {
    static let id = Column(CodingKeys.id)
    static let name = Column(CodingKeys.name)
  }
}

extension ListEntity: FetchableRecord, MutablePersistableRecord {
  mutating func didInsert(with rowID: Int64, for column: String?) {
    id = rowID
  }
}

// MARK: - Mapping

extension ListEntity {
  func toProductList() -> ProductList {
    ProductList(id: self.id!, name: self.name)
  }
}
