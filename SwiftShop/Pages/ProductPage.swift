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

enum SheetStatus {
  case closed
  case open(_ product: SimpleProduct, isNew: Bool = false)
  
  func isOpen() -> Bool {
    switch(self) {
    case .closed:
      return false
    default:
      return true
    }
  }
}

class EditSheetStatus: ObservableObject {
  @Published var status: SheetStatus

  init() {
    status = .closed
  }

  func open(_ product: SimpleProduct, isNew: Bool = false) {
    status = .open(product, isNew: isNew)
  }

  func close() {
    status = .closed
  }
  
  func isOpen() -> Bool {
    let val = status.isOpen()
    
    return val
  }
}

struct ProductPage: View {
  @ObservedObject private var model: ProductPageViewModel = ProductPageViewModel()
  @ObservedObject private var editSheetStatus = EditSheetStatus()
  @State var editSheetOpen = false
  // @State var editSheetStatus: EditSheetStatus = .closed
  private var editFormModel = ProductEditFormModel()
  private var imfalse = false
  
  var otherstatus = SheetStatus.closed
  
  private func addProductClicked() {
    editSheetOpen = true
    editFormModel.newProduct()
    //
    editSheetStatus.open(SimpleProduct(id: -1, name: "", price: 0.0, tags: []), isNew: true)
  }
  
  private func productRowClicked(product: SimpleProduct) {
    editSheetOpen = true
    editFormModel.editProduct(product)
    //
    editSheetStatus.open(product, isNew: false)
  }
  
  private func onSaveProduct(_ product: SimpleProduct, isNew: Bool) {
    model.onSaveProduct(product, isNew)
    editSheetOpen = false
    //
    editSheetStatus.close()
  }
  
  
  private func testSet(_ fieldValue: Bool) {
    self.editSheetStatus.close()
  }
  
  var body: some View {
//    let isDisplayed = Binding<Bool>(get: { self.editSheetOpen }, set: { self.editSheetOpen = true } )

    let boundSearchValue = Binding<Bool>(get: self.editSheetStatus.isOpen, set: self.testSet)
    
    return VStack {
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
    }.partialSheet(presented: boundSearchValue) {
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
