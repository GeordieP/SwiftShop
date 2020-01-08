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

class ProductPageViewModel: ObservableObject {
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
      .catch { _ in Empty() }
      .sink { self.tags = $0 }
      .store(in: &cancellables)
  }

  func updateProduct(_ product: SimpleProduct) {
    do {
      try App.products().updateProduct(product)
    } catch {
      print(error)
    }
  }

  func createProduct(_ product: SimpleProduct) {
    do {
      try App.products().createProduct(product)
    } catch {
      print(error)
    }
  }
}
  
struct ProductPage: View {
  @ObservedObject private var model: ProductPageViewModel = ProductPageViewModel()
  @ObservedObject private var filters = FilterManager<SimpleProduct>()
  @State var editSheetStatus: SheetStatus = .closed
  
  private func addProductClicked() {
    editSheetStatus = .open(SimpleProduct.newEmpty(), isNew: true)
  }
  
  private func productRowClicked(product: SimpleProduct) {
    editSheetStatus = .open(product, isNew: false)
  }
  
  private func closeForm(_ _: Bool = false) {
    editSheetStatus = .closed
  }
  
  private func onSaveProduct(_ editedProduct: SimpleProduct) {
    if editSheetStatus.isNew() {
      model.createProduct(editedProduct)
    } else {
      model.updateProduct(editedProduct)
    }

    closeForm()
  }

  private func renderEditSheet() -> AnyView {
    if case let .open(product, _) = editSheetStatus {
      return AnyView(ProductEditForm(
        editedProduct: product,
        tags: self.model.tags,
        saveProduct: self.onSaveProduct
      ))
    }

    return AnyView(Text("Error: Product edit form should not be open"))
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
      
      ProductFilterBar(filterManager: filters) // TODO: FIXME: the input in here seems to be resetting its cursor pos every time the ProductPage re-renders.
      
      List(filters.apply(to: model.products)) { p in
        ProductRow(product: p, onRowClick: self.productRowClicked)
      }
    }.partialSheet(presented: Binding<Bool>(get: self.editSheetStatus.isOpen, set: self.closeForm)) {
      VStack {
        Text(self.editSheetStatus.isNew() ? "New Product" : "Edit Product")
        self.renderEditSheet()
      }
    }
  }
}


struct ProductPage_Previews: PreviewProvider {
  static var previews: some View {
    ProductPage()
  }
}
