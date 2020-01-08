//
//  TagFetcher.swift
//  SwiftShop
//
//  Created by Geordie Powers on 2019-12-15.
//  Copyright © 2019 Geordie Powers. All rights reserved.
//

import GRDB

struct TagFetcher: FetchableRecord, Decodable {
  var tagEntity: TagEntity
  var productEntityCount: Int
}

// MARK: - Mapping

extension TagFetcher {
  func toTag() -> Tag {
    Tag(
      id: self.tagEntity.id!,
      name: self.tagEntity.name,
      color: self.tagEntity.color,
      productCount: self.productEntityCount
    )
  }
}
