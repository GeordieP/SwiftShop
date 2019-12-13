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
  private var cancellables: [AnyCancellable] = []
  
  init() {
    App
      .lists()
      .productListPublisher()
      .fetchOnSubscription()
      .catch { _ in Empty() } // TODO: handle db errors
      .sink { self.lists = $0 }
      .store(in: &cancellables)
    
    let firstListId = lists.first!.id

    App
      .products()
      .listedProductPublisher(listId: firstListId)
      .fetchOnSubscription()
      .catch { _ in Empty() } // TODO: handle db errors
      .sink { self.products = $0 }
      .store(in: &cancellables)
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
  
  func setProductComplete(productId: Int64, complete: Bool) {
    do {
      let firstListId = lists.first!.id

      try App
        .products()
        .setProductCompleteInList(
          productId: productId,
          listId: firstListId,
          complete: complete
        )
    } catch {
      print(error)
    }
  }
}

struct TESTVIEW: View {
  @ObservedObject private var state: TESTVIEWModel = TESTVIEWModel()
  
  var body: some View {
    VStack {
      Text(state.lists.first!.name).font(.title).padding()
      TestBtn(action: state.addAnotherTag, text: "Add another tag to product 1")
      MyListView(products: state.products, setProductComplete: state.setProductComplete)
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
  var setProductComplete: (Int64, Bool) -> Void

  var body: some View {
    List(products) { p in
      Button(action: { self.setProductComplete(p.id, !p.complete) }) {
        HStack {
          if p.complete {
            Image(systemName: "largecircle.fill.circle")
            Text(p.name)
              .foregroundColor(.gray)
              .strikethrough()
          } else {
            Image(systemName: "circle")
            Text(p.name)
          }
          
          Spacer()
          
          Text("[\(p.tags.map({ $0.name }).joined(separator: ","))]")
            .font(.footnote)
        }
      }
    }
  }
}
