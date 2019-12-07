//
//  TagEntity.swift
//  SwiftShop
//
//  Created by Geordie Powers on 2019-12-05.
//  Copyright © 2019 Geordie Powers. All rights reserved.
//

import GRDB
import SwiftUI

extension TableNames {
  static let TagEntity = "Tag"
}

struct TagEntity: Identifiable {
  var id: Int64?
  var name: String
  var color: String
}

extension TagEntity: Codable, FetchableRecord, MutablePersistableRecord {
  static let databaseTableName = TableNames.TagEntity
  
  fileprivate enum Columns {
    static let id = Column(CodingKeys.id)
    static let name = Column(CodingKeys.name)
    static let color = Column(CodingKeys.color)
  }
  
//  mutating func didInsert(with rowID: Int64, for column: String?) {
//    id = rowID
//  }
}
