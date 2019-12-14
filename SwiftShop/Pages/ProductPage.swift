//
//  ProductPage.swift
//  SwiftShop
//
//  Created by Geordie Powers on 2019-12-13.
//  Copyright © 2019 Geordie Powers. All rights reserved.
//

import SwiftUI
import Combine
import PartialSheet

class ProductPageViewModel : ObservableObject {
  @Published var products: [SimpleProduct] = []
  private var cancellables: [AnyCancellable] = []
  
  init() {
    App
      .products()
      .productPublisher()
      .fetchOnSubscription()
      .catch { _ in Empty() }
      .sink { self.products = $0 }
      .store(in: &cancellables)
  }
  
  func onSaveProduct(_ product: SimpleProduct, _ isNew: Bool) {
    if isNew {
      do {
        try App.products().createProduct(product)
      } catch {
        print(error)
      }
    } else {
      do {
        try App.products().updateProduct(product)
      } catch {
        print(error)
      }
    }
  }
}

struct ProductPage: View {
  @ObservedObject private var model: ProductPageViewModel = ProductPageViewModel()
  @State var editSheetOpen = false
  @State var editedProduct: SimpleProduct?
  @State var isNewProduct = false // TODO: this sucks, do something better
  
  private func addProductClicked() {
    editSheetOpen = true
    isNewProduct = true
    editedProduct = SimpleProduct(id: 0, name: "", price: 0)
  }
  
  private func productRowClicked(product: SimpleProduct) {
    editSheetOpen = true
    isNewProduct = false
    editedProduct = product
  }
  
  private func onSaveProduct(_ product: SimpleProduct, isNew: Bool) {
    model.onSaveProduct(product, isNew)
    editSheetOpen = false
    isNewProduct = false
    editedProduct = nil
  }
  
  var body: some View {
    VStack {
      HStack {
        Text("Products").font(.title)
        Spacer()
        Button(action: addProductClicked) {
          Image(systemName: "plus")
        }
      }.padding()
      
      List(model.products) { p in
        ProductRow(product: p, onRowClick: self.productRowClicked)
      }
    }.partialSheet(presented: $editSheetOpen) {
      ProductEditForm(
        product: self.editedProduct,
        isNew: self.isNewProduct,
        onSave: self.onSaveProduct
      )
    }
  }
}


struct ProductPage_Previews: PreviewProvider {
  static var previews: some View {
    ProductPage()
  }
}
