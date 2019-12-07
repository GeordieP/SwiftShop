//
//  ProductListEntity.swift
//  SwiftShop
//
//  Created by Geordie Powers on 2019-12-05.
//  Copyright © 2019 Geordie Powers. All rights reserved.
//

import GRDB

extension TableNames {
  static let ProductListEntity = "ProductList"
}

struct ProductListEntity: Identifiable {
  var id: Int64?
  var name: String
}

extension ProductListEntity : Codable, FetchableRecord, MutablePersistableRecord {
  static let databaseTableName = TableNames.ProductListEntity
  
  fileprivate enum Columns {
    static let id = Column(CodingKeys.id)
    static let name = Column(CodingKeys.name)
  }
  
//  mutating func didInsert(with rowID: Int64, for column: String?) {
//    id = rowID
//  }
}
