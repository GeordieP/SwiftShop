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
  @Published var products: [SimpleProduct] = []
  private var cancellables: [AnyCancellable] = [] // TODO: what is this, what does it do?
  
  init() {
    App.products()
      .publisher()
      .fetchOnSubscription()
      .catch { _ in Empty() } // TODO: handle db errors
      .sink { self.products = $0 }
      .store(in: &cancellables)
  }
  
  func addProduct(name: String, price: Double) {
    do {
      try App.products()
        .add(newProduct: SimpleProduct(name: name, price: price))
    } catch {
      print(error)
    }
  }
  
  func deleteProduct(id: Int64) {
    do {
      try App.products()
      .remove(id)
    } catch {
      print(error)
    }
  }
  
  func deleteAllProducts() {
    do {
      try App.products().removeAll()
    } catch {
      print(error)
    }
  }
}

struct TESTVIEW: View {
  @ObservedObject private var state: TESTVIEWModel = TESTVIEWModel()

  var body: some View {
    VStack {
      AddProductForm(onSubmit: state.addProduct)
      
      Button(action: state.deleteAllProducts) {
        Text("Delete All")
      }
      
      Spacer()
      
      ProductListView(products: state.products, deleteProduct: state.deleteProduct)
    }
  }
}

