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

let DEFAULT_TEST_LIST_ID = "MAIN"

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
      action: .DeleteList(id: DEFAULT_TEST_LIST_ID)
    )
    
    XCTAssertEqual(result.count, 0)
  }
  
  func testUpdateList() {
    let newList = ProductsList(id: DEFAULT_TEST_LIST_ID, name: "Updated List Name")
    
    
    let result = reducer.reduce(
      state: defaultListState(),
      action: .UpdateList(updatedList: newList)
    )
    
    XCTAssertEqual(result.count, 1)
    XCTAssertEqual(result.first!.id, DEFAULT_TEST_LIST_ID)
    XCTAssertEqual(result.first!.name, "Updated List Name")
  }
  
  
  func testAddRemoveProduct() {
    let initialState = defaultListState()
    XCTAssertEqual(initialState[DEFAULT_TEST_LIST_ID]!.products.count, 0)

    let result1 = reducer.reduce(
      state: initialState,
      action: .AddProductToList(productId: "TestProduct", listId: DEFAULT_TEST_LIST_ID)
    )
    
    XCTAssertEqual(result1[DEFAULT_TEST_LIST_ID]!.products.count, 1)
    
    let result2 = reducer.reduce(
      state: result1,
      action: .RemoveProductFromList(productId: "TestProduct", listId: DEFAULT_TEST_LIST_ID)
    )
    
    XCTAssertEqual(result2[DEFAULT_TEST_LIST_ID]!.products.count, 0)
  }
  
  func testProductStatus() {
    let initialState = defaultStateWithProduct()
    let productId = initialState[DEFAULT_TEST_LIST_ID]!.products.first!.id
    
    XCTAssertEqual(initialState[DEFAULT_TEST_LIST_ID]!.products.first!.complete, false)
    
    let result1 = reducer.reduce(
      state: initialState,
      action: .CompleteProduct(listId: DEFAULT_TEST_LIST_ID, productId: productId)
    )
    
    XCTAssertEqual(result1[DEFAULT_TEST_LIST_ID]!.products.first!.complete, true)
    
    let result2 = reducer.reduce(
      state: initialState,
      action: .UncompleteProduct(listId: DEFAULT_TEST_LIST_ID, productId: productId)
    )
    
    XCTAssertEqual(result2[DEFAULT_TEST_LIST_ID]!.products.first!.complete, false)
  }
}

func emptyListState() -> OrderedState<ProductsList> {
  OrderedState()
}

func defaultListState() -> OrderedState<ProductsList> {
  OrderedState(ProductsList(id: DEFAULT_TEST_LIST_ID, name: "Main List"))
}

func defaultStateWithProduct() -> OrderedState<ProductsList> {
  let products = OrderedState(ProductStatus(id: "FirstItem", complete: false))
  return OrderedState(ProductsList(id: DEFAULT_TEST_LIST_ID, name: "Main List", products: products))
}
