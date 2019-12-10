//
//  TESTVIEW.swift
//  SwiftShop
//
//  Created by Geordie Powers on 2019-12-06.
//  Copyright © 2019 Geordie Powers. All rights reserved.
//

import SwiftUI
import Combine

class TESTVIEWModel : ObservableObject {
  @Published var lists: [ProductList] = []
  @Published var products: [ListedProduct] = []
  @Published var doneSetup = false
  private var cancellables: [AnyCancellable] = []
  
  init() {
    App
      .lists()
      .productListPublisher()
      .fetchOnSubscription()
      .catch { _ in Empty() } // TODO: handle db errors
      .sink { self.lists = $0 }
      .store(in: &cancellables)
  }
  
  func doSetup() {
    do {
      try App.TEMP_testSetup()
    } catch {
      print(error)
    }
  }
  
  func afterSetup() {
    let firstListId = lists.first!.id
    
    App
      .products()
      .listedProductPublisher(listId: firstListId)
      .fetchOnSubscription()
      .catch { _ in Empty() } // TODO: handle db errors
      .sink { self.products = $0 }
      .store(in: &cancellables)
    
    doneSetup.toggle()
  }
  
  func addAnotherTag() {
    do {
      let firstProductId = products.first!.id
      
      try App
        .products()
        .testTagProduct(productId: firstProductId)
    } catch {
      print(error)
    }
  }
  
  func completeProduct(productId: Int64) {
    do {
      let firstListId = lists.first!.id
      let firstProductId = products.first!.id
      
      try App
        .products()
        .completeProductInList(productId: firstProductId, listId: firstListId)
    } catch {
      print(error)
    }
  }
}

struct TESTVIEW: View {
  @ObservedObject private var state: TESTVIEWModel = TESTVIEWModel()
  
  var body: some View {
    VStack {
      List {
        TestBtn(action: state.doSetup,
                text: "Set up test DB")
        TestBtn(action: state.afterSetup,
                text: "Subscribe to products publisher")
        TestBtn(action: state.addAnotherTag,
                text: "Add another tag to product 1")
        
        Spacer()
        
        List {
          ForEach(state.lists, id: \.id) { list in
            Text("list: \(list.name)")
          }
        }
        
        Spacer()
        
        if state.doneSetup {
          MyListView(products: state.products, completeProduct: state.completeProduct)
        }
      }
    }
  }
}

struct TestBtn: View {
  var action: () -> Void
  var text: String
  
  var body: some View {
    Button(action: action) {
      HStack {
        Image("first")
        Text(text)
      }
    }
  }
}

struct MyListView: View {
  var products: [ListedProduct] = []
  var completeProduct: (Int64) -> Void
  
  var body: some View {
    List(products) { p in
      Button(action: { self.completeProduct(p.id) }) {
        HStack {
          Text(p.name)
          Spacer()
          Text("Complete: \(String(p.complete))")
          Spacer()
          Text("[\(p.tags.map({ $0.name }).joined(separator: ","))]")
            .font(.footnote)
        }
      }
    }
  }
}
