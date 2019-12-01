//
//  ProductStateTests.swift
//  SwiftShopTests
//
//  Created by Geordie Powers on 2019-11-17.
//  Copyright © 2019 Geordie Powers. All rights reserved.
//

import Foundation

import XCTest
import SwiftDux
@testable import SwiftShop

class ProductStateTests: XCTestCase {
  let reducer: ProductsReducer = ProductsReducer()
  
  func testAddProduct() {
    let result = reducer.reduce(
      state: emptyState(),
      action: .CreateProduct(name: "First Product", price: 4.00)
    )
    
    XCTAssertEqual(result.count, 1)
    XCTAssertEqual(result.first!.name, "First Product")
    XCTAssertEqual(result.first!.price, 4.00)
  }
  
  func testRemoveProduct() {
    let result = reducer.reduce(
      state: fourState(),
      action: .DeleteProduct(id: "0")
    )
    
    XCTAssertEqual(result.count, 3)
    XCTAssertEqual(result.first!.name, "Second")
  }
  
  func testSetProduct() {
    let result = reducer.reduce(
      state: fourState(),
      action: .UpdateProduct(updatedProduct: Product(id: "2", name: "Inserted", price: 10))
    )
    
    XCTAssertEqual(result.count, 4)
    XCTAssertEqual(result[2].name, "Inserted")
  }
  
  func testMoveProduct() {
    let result = reducer.reduce(
      state: fourState(),
      action: .MoveProduct(from: [1] , to: 3)
    )
    
    XCTAssertEqual(result[2].name, "Second")
  }
}

func emptyState() -> OrderedState<Product> {
  OrderedState()
}

func fourState() -> OrderedState<Product> {
  OrderedState(
    Product(id: "0", name: "First", price: 4.00),
    Product(id: "1", name: "Second", price: 3.00),
    Product(id: "2", name: "Third", price: 2.00),
    Product(id: "3", name: "Fourth", price: 1.00)
  )
}

