//
//  ProductStateEntity.swift
//  SwiftShop
//
//  Created by Geordie Powers on 2019-12-05.
//  Copyright © 2019 Geordie Powers. All rights reserved.
//

import GRDB

extension TableNames {
  static let ProductStateEntity = "ProductState"
}

struct ProductStateEntity {
  var productId: Int64?
  var listId: Int64?
  var complete: Bool
}

extension ProductStateEntity : Codable, FetchableRecord, MutablePersistableRecord {
  static let databaseTableName = TableNames.ProductStateEntity

  fileprivate enum Columns {
    static let productId = Column(CodingKeys.productId)
    static let listId = Column(CodingKeys.listId)
    static let complete = Column(CodingKeys.complete)
  }

//  mutating func didInsert(with rowID: Int64, for column: String?) {
//    id = rowID
//  }
}
