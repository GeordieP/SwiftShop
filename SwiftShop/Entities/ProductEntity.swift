//
//  ProductEntity.swift
//  SwiftShop
//
//  Created by Geordie Powers on 2019-12-05.
//  Copyright © 2019 Geordie Powers. All rights reserved.
//

import GRDB

extension TableNames {
  static let ProductEntity = "Product"
}

struct ProductEntity: Identifiable {
  var id: Int64?
  var name: String
  var price: Double
}

extension ProductEntity : Codable, FetchableRecord, MutablePersistableRecord {
  static let databaseTableName = TableNames.ProductEntity
  
  fileprivate enum Columns {
    static let id = Column(CodingKeys.id)
    static let name = Column(CodingKeys.name)
    static let price = Column(CodingKeys.price)
  }
  
  mutating func didInsert(with rowID: Int64, for column: String?) {
    id = rowID
  }
}
