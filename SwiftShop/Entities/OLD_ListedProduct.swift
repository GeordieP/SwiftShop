//
//  ListedProduct.swift
//  SwiftShop
//
//  Created by Geordie Powers on 2019-12-08.
//  Copyright © 2019 Geordie Powers. All rights reserved.
//

//import GRDB
//
//struct ListedProduct: Product {
//  var id: Int64?
//  var name: String
//  var price: Double
//  var completed: Bool = false
//}
//
//// DB Query API
//extension ListedProduct : TableRecord {
//  enum Columns {
//    static let id = Column(CodingKeys.id)
//    static let name = Column(CodingKeys.name)
//    static let price = Column(CodingKeys.price)
//    static let completed = Column(CodingKeys.completed)
//  }
//}
//
//// DB Fetching
//extension ListedProduct: FetchableRecord {}
//
//// DB Saving
//extension ListedProduct: MutablePersistableRecord {
//  mutating func didInsert(with rowID: Int64, for column: String?) {
//    id = rowID
//  }
//}
//
