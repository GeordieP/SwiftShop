//
//  TagRepository.swift
//  SwiftShop
//
//  Created by Geordie Powers on 2019-12-15.
//  Copyright © 2019 Geordie Powers. All rights reserved.
//

import GRDB
import GRDBCombine

struct TagRepository {
  private var database: DatabaseWriter
  
  init(_ db: DatabaseWriter) {
    database = db
  }
}

// MARK: - Publishers
extension TagRepository {
  func tagPublisher() -> DatabasePublishers.Value<[Tag]> {
    ValueObservation.tracking(value: { db in
      let request = TagEntity.annotated(with: TagEntity.products.count)
      
      return try TagFetcher
        .fetchAll(db, request)
        .map({ $0.toTag() })
    }).publisher(in: database)
  }
}
