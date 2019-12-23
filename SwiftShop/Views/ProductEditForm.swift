//
//  ProductEditForm.swift
//  SwiftShop
//
//  Created by Geordie Powers on 2019-12-13.
//  Copyright © 2019 Geordie Powers. All rights reserved.
//

import SwiftUI

class ProductEditFormModel: ObservableObject {
  @Published var nameField: String = ""
  @Published var priceField: String = ""
  @Published var selectedTagIds: [Int64] = []
  var isNew = false
  
  fileprivate var editedProduct: SimpleProduct?
  
  func newProduct() {
    let product = SimpleProduct(id: -1, name: "", price: 0.0)
    isNew = true
    
    editedProduct = product
    nameField = product.name
    priceField = String(product.price)
  }
  
  func editProduct(_ product: SimpleProduct) {
    isNew = false
    
    editedProduct = product
    nameField = product.name
    priceField = String(product.price)
    selectedTagIds = product.tags.map({ $0.id })
  }
  
  fileprivate func toggleTag(tagId: Int64) {
    if let tagIndex = selectedTagIds.firstIndex(of: tagId) {
      selectedTagIds.remove(at: tagIndex)
    } else {
      selectedTagIds.append(tagId)
    }
  }
  
  fileprivate func getProduct(allTags: [Tag]) -> SimpleProduct {
    SimpleProduct(
      id: editedProduct!.id,
      name: nameField,
      price: Double(priceField)!,
      tags: allTags.filter({selectedTagIds.contains($0.id)}) // TODO: could be a perf concern when there are lots of tags
    )
  }
}

struct ProductEditForm: View {
  @ObservedObject var model: ProductEditFormModel
  typealias onSaveFn = (SimpleProduct, Bool) -> Void
  
  var tags: [Tag]
  var onSave: onSaveFn
  
  init(formModel: ProductEditFormModel, onSave: @escaping onSaveFn, tags: [Tag]) {
    self.tags = tags
    self.model = formModel
    self.onSave = onSave
  }
  
  private func save() {
    self.onSave(model.getProduct(allTags: tags), model.isNew)
  }
  
  var body: some View {
    // TODO: can this be improved or removed?
    if model.editedProduct == nil { return AnyView(Text("No Product")) }
    
    return AnyView(VStack {
      Form {
        TextField("Name", text: $model.nameField)
        TextField("Price", text: $model.priceField)
      }

      ForEach(tags, id: \.id) { (tag: Tag) in
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
    })
    
    //    return AnyView(VStack {
    //      Form {
    //        TextField("Name", text: $model.nameField)
    //        TextField("Price", text: $model.priceField)
    //
    //        Button(action: { self.save() }) {
    //          HStack {
    //            Text("Save")
    //          }
    //        }
    //      }
    //
    //      ForEach(tags, id: \.id) { tag in
    //        ToggleableTag(tag: tag, selected: self.model.selectedTagIds.contains(tag.id))
    ////          .onTapGesture(perform: { self.model.toggleTag(tagId: tag.id) })
    //      }
    //      .padding(3)
    //    })
  }
}

struct ProductEditForm_Previews: PreviewProvider {
  static var previews: some View {
    let onSave = { (p: SimpleProduct, b: Bool) in return }
    
    let tags = [
      Tag(id: 1, name: "FirstTag", color: "blue"),
      Tag(id: 2, name: "SecondTag", color: "blue"),
      Tag(id: 3, name: "ThirdTag", color: "green")
    ]
    
    let model = ProductEditFormModel()
    
    return ProductEditForm(formModel: model, onSave: onSave, tags: tags)
  }
}
