//
//  ListStateTests.swift
//  SwiftShopTests
//
//  Created by Geordie Powers on 2019-11-30.
//  Copyright © 2019 Geordie Powers. All rights reserved.
//

import Foundation

import XCTest
import SwiftDux
@testable import SwiftShop

class ListStateTests: XCTestCase {
  let reducer: ListsReducer = ListsReducer()
  
  func testCreateList() {
    let result = reducer.reduce(
      state: emptyListState(),
      action: .CreateList(name: "TestList")
    )
    
    XCTAssertEqual(result.count, 1)
    XCTAssertEqual(result.first!.name, "TestList")
  }
  
  func testDeleteList() {
    let result = reducer.reduce(
      state: defaultListState(),
      action: .DeleteList(id: "MAIN")
    )
    
    XCTAssertEqual(result.count, 0)
  }
  
  func testUpdateList() {
    let newList = ProductsList(id: "MAIN", name: "Updated List Name")
    
    
    let result = reducer.reduce(
      state: defaultListState(),
      action: .UpdateList(updatedList: newList)
    )
    
    XCTAssertEqual(result.count, 1)
    XCTAssertEqual(result.first!.id, "MAIN")
    XCTAssertEqual(result.first!.name, "Updated List Name")
  }
  
  
  func testAddRemoveProduct() {
    let initialState = defaultListState()
    XCTAssertEqual(initialState["MAIN"]!.products.count, 0)

    let result1 = reducer.reduce(
      state: initialState,
      action: .AddProductToList(productId: "TestProduct", listId: "MAIN")
    )
    
    XCTAssertEqual(result1["MAIN"]!.products.count, 1)
    
    let result2 = reducer.reduce(
      state: result1,
      action: .RemoveProductFromList(productId: "TestProduct", listId: "MAIN")
    )
    
    XCTAssertEqual(result2["MAIN"]!.products.count, 0)
  }
  
  func testProductStatus() {
    let initialState = defaultStateWithProduct()
    let productId = initialState["MAIN"]!.products.first!.id
    
    XCTAssertEqual(initialState["MAIN"]!.products.first!.complete, false)
    
    let result1 = reducer.reduce(
      state: initialState,
      action: .CompleteProduct(listId: "MAIN", productId: productId)
    )
    
    XCTAssertEqual(result1["MAIN"]!.products.first!.complete, true)
    
    let result2 = reducer.reduce(
      state: initialState,
      action: .UncompleteProduct(listId: "MAIN", productId: productId)
    )
    
    XCTAssertEqual(result2["MAIN"]!.products.first!.complete, false)
  }
}

func emptyListState() -> OrderedState<ProductsList> {
  OrderedState()
}

func defaultListState() -> OrderedState<ProductsList> {
  OrderedState(ProductsList(id: "MAIN", name: "Main List"))
}

func defaultStateWithProduct() -> OrderedState<ProductsList> {
  let products = OrderedState(ProductStatus(id: "FirstItem", complete: false))
  return OrderedState(ProductsList(id: "MAIN", name: "Main List", products: products))
}
