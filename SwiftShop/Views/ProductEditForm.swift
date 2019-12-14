//
//  ProductEditForm.swift
//  SwiftShop
//
//  Created by Geordie Powers on 2019-12-13.
//  Copyright © 2019 Geordie Powers. All rights reserved.
//

import SwiftUI

class ProductEditFormModel: ObservableObject {
  @Published var nameField: String
  @Published var priceField: String
  
  init(name: String, price: String) {
    nameField = name
    priceField = price
  }
}

struct ProductEditForm: View {
  typealias onSaveFn = (SimpleProduct, Bool) -> Void
  @ObservedObject var formModel: ProductEditFormModel
  var product: SimpleProduct?
  var isNew: Bool
  var onSave: onSaveFn

  init(product p: SimpleProduct?, isNew: Bool = false, onSave: @escaping onSaveFn) {
    self.isNew = isNew
    self.onSave = onSave
    
    if let product = p {
      self.product = p
      self.formModel = ProductEditFormModel(name: product.name, price: String(product.price))
    } else {
      self.product = nil
      self.formModel = ProductEditFormModel(name: "", price: "")
    }
  }
  
  private func save() {
    let newName = formModel.nameField
    let newPrice = Double(formModel.priceField)! // TODO: Handle error
    
    onSave(
      SimpleProduct(
        id: product!.id,
        name: newName,
        price: newPrice
      ),
      isNew
    )
  }
  
  var body: some View {
    // TODO: this aint good
    if product == nil { return AnyView(Text("No Product")) }
    
    return AnyView(VStack {
      Text(isNew ? "New Product" : "Edit Product")
      
      Form {
        TextField("Name", text: $formModel.nameField)
        TextField("Price", text: $formModel.priceField)
        
        Button(action: self.save) {
          HStack {
            Text("Save")
          }
        }
      }
    })
  }
}

struct ProductEditForm_Previews: PreviewProvider {
  static var previews: some View {
    let product = SimpleProduct(id: 0, name: "ProductName", price: 3.0)
    let onSave = { (p: SimpleProduct, isNew: Bool) in return }
    
    return ProductEditForm(product: product, isNew: false, onSave: onSave)
  }
}
