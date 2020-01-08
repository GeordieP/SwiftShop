//
//  ProductEditForm.swift
//  SwiftShop
//
//  Created by Geordie Powers on 2019-12-13.
//  Copyright © 2019 Geordie Powers. All rights reserved.
//

import SwiftUI

enum SheetStatus {
  case closed
  case open(_ product: SimpleProduct, isNew: Bool = false)
  
  func isOpen() -> Bool {
    if case .closed = self { return false }
    return true
  }
  
  func isNew() -> Bool {
    if case let .open(_, isNew) = self { return isNew }
    return false
  }
}

class ProductEditFormModel: ObservableObject {
  var productId: Int64
  @Published var nameField: String = ""
  @Published var priceField: String = ""
  @Published var selectedTagIds: [Int64] = []

  init(productId: Int64, nameField: String, priceField: String, selectedTagIds: [Int64]) {
    self.productId = productId
    self.nameField = nameField
    self.priceField = priceField
    self.selectedTagIds = selectedTagIds
  }
  
  fileprivate func toggleTag(tagId: Int64) {
    if let tagIndex = selectedTagIds.firstIndex(of: tagId) {
      selectedTagIds.remove(at: tagIndex)
    } else {
      selectedTagIds.append(tagId)
    }
  }
}

struct ProductEditForm: View {
  typealias onSaveFn = (SimpleProduct) -> Void

  var allTags: [Tag]
  var onSave: onSaveFn
  @ObservedObject private var model: ProductEditFormModel
  
  init(editedProduct: SimpleProduct, tags: [Tag], saveProduct: @escaping onSaveFn) {
    self.allTags = tags
    self.onSave = saveProduct

    model = ProductEditFormModel(
      productId: editedProduct.id,
      nameField: editedProduct.name,
      priceField: String(editedProduct.price),
      selectedTagIds: editedProduct.tags.map({ $0.id })
    )
  }
  
  func save() {
    let newProduct = SimpleProduct(
      id: self.model.productId,
      name: self.model.nameField,
      price: Double(self.model.priceField)!,
      tags: self.allTags.filter({ self.model.selectedTagIds.contains($0.id) }) // TODO: PERF: this could be rough if there are a lot of tags
    )
    
    onSave(newProduct)
  }
  
  var body: some View {
    return VStack {
      Form {
        TextField("Name", text: $model.nameField)
        TextField("Price", text: $model.priceField)
      }

      ForEach(allTags, id: \.id) { (tag: Tag) in
        ToggleableTag(tag: tag, selected: self.model.selectedTagIds.contains(tag.id))
          .onTapGesture(perform: { self.model.toggleTag(tagId: tag.id)})
      }

      Form {
        Button(action: { self.save() }) {
          HStack {
            Text("Save")
          }
        }
      }
    }
  }
}

struct ProductEditForm_Previews: PreviewProvider {
  static var previews: some View {
    let onSave = { (p: SimpleProduct) in return }
    
    let tags = [
      Tag(id: 1, name: "FirstTag", color: "blue"),
      Tag(id: 2, name: "SecondTag", color: "blue"),
      Tag(id: 3, name: "ThirdTag", color: "green")
    ]

    let product = SimpleProduct(
      id: 1,
      name: "Example Product",
      price: 4.00,
      tags: Array(tags[0..<2])
    )
    
    return ProductEditForm(editedProduct: product, tags: tags, saveProduct: onSave)
  }
}
