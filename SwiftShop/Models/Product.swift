//
//  Product.swift
//  SwiftShop
//
//  Created by Geordie Powers on 2019-12-05.
//  Copyright © 2019 Geordie Powers. All rights reserved.
//

protocol Product : Identifiable {
  var id: Int64? { get set }
  var name: String { get set }
  var price: Double { get set }
  var tags: [Tag] { get set }
}

struct SimpleProduct : Product { // rename to baseproduct?
  var id: Int64?
  var name: String
  var price: Double
  var tags: [Tag] = []
}

struct ListedProduct : Product {
  var id: Int64?
  var name: String
  var price: Double
  var tags: [Tag]
  
  var complete: Bool
  var listId: Int64
}

