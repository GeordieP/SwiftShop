//
//  TaggedProductFetcher.swift
//  SwiftShop
//
//  Created by Geordie Powers on 2019-12-13.
//  Copyright © 2019 Geordie Powers. All rights reserved.
//

import GRDB

struct TaggedProductFetcher: FetchableRecord, Decodable {
  var productEntity: ProductEntity
  var tagEntities: [TagEntity]
}

// MARK: - Mapping

extension TaggedProductFetcher {
  func toSimpleProduct() -> SimpleProduct {
    SimpleProduct(
      id: self.productEntity.id!,
      name: self.productEntity.name,
      price: self.productEntity.price,
      tags: self.tagEntities.map { $0.toTag() }
    )
  }
}
