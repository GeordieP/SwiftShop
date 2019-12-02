//
//  ProductListView.swift
//  SwiftShop
//
//  Created by Geordie Powers on 2019-11-24.
//  Copyright © 2019 Geordie Powers. All rights reserved.
//

import SwiftUI

struct ProductListView: View {
  var products: [Product]
  var addProductToList: (String) -> Void
  var deleteProduct: (String) -> Void
  
  func onDelete(indices: IndexSet) {
    guard let index = indices.first else { return }
    if index > products.count { return }
    deleteProduct(products[index].id)
  }
  
  func onTap(_ productId: String) {
    addProductToList(productId)
  }

  var body: some View {
    List {
      ForEach(products) { p in
        Button(action: { self.onTap(p.id) }) {
          HStack {
            Text(p.name)
            Spacer()
            Text(String(p.price))
          }
        }
      }
      .onDelete(perform: onDelete)
    }
  }
}
