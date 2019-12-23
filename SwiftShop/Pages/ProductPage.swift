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
  @Published var tags: [Tag] = []
  private var cancellables: [AnyCancellable] = []
  
  init() {
    App
      .products()
      .productPublisher()
      .fetchOnSubscription()
      .catch { _ in Empty() }
      .sink { self.products = $0 }
      .store(in: &cancellables)
    
    App
      .tags()
      .tagPublisher()
//    .fetchOnSubscription()
      .catch { _ in Empty() }
      .sink { self.tags = $0 }
      .store(in: &cancellables)
  }
  
  // TODO: can we remove isNew here?
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
  private var editFormModel = ProductEditFormModel()
  
  private func addProductClicked() {
    editSheetOpen = true
    editFormModel.newProduct()
  }
  
  private func productRowClicked(product: SimpleProduct) {
    editSheetOpen = true
    editFormModel.editProduct(product)
  }
  
  private func onSaveProduct(_ product: SimpleProduct, isNew: Bool) {
    model.onSaveProduct(product, isNew)
    editSheetOpen = false
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
      VStack {
        Text("Edit Product") // TODO: change text to 'new product' when it's new
        
        ProductEditForm(
          formModel: self.editFormModel,
          onSave: self.onSaveProduct,
          tags: self.model.tags
        )
      }
    }
  }
}


struct ProductPage_Previews: PreviewProvider {
  static var previews: some View {
    ProductPage()
  }
}
