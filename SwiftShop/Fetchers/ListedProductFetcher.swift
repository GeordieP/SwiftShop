//
//  ListedProductFetcher.swift
//  SwiftShop
//
//  Created by Geordie Powers on 2019-12-09.
//  Copyright © 2019 Geordie Powers. All rights reserved.
//

import GRDB

struct ListedProductFetcher: FetchableRecord, Decodable {
  var productStatusEntity: ProductStatusEntity
  var productEntity: ProductEntity
  var tagEntities: [TagEntity]
}

extension ListedProductFetcher {
  func toSimpleProduct() -> SimpleProduct {
    SimpleProduct(
      id: self.productEntity.id!,
      name: self.productEntity.name,
      price: self.productEntity.price,
      tags: self.tagEntities.map { $0.toTag() }
    )
  }
  
  func toListedProduct() -> ListedProduct {
    ListedProduct(
      id: self.productEntity.id!,
      name: self.productEntity.name,
      price: self.productEntity.price,
      complete: self.productStatusEntity.complete,
      tags: self.tagEntities.map { $0.toTag() }
    )
  }
}
