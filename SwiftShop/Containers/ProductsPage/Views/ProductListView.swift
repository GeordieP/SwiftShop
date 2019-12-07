//
//  ProductListView.swift
//  SwiftShop
//
//  Created by Geordie Powers on 2019-11-24.
//  Copyright © 2019 Geordie Powers. All rights reserved.
//

import SwiftUI

struct ProductListView<P: Product>: View {
  var products: [P]
  //  var addProductToList: (Int64) -> Void
  var deleteProduct: (Int64) -> Void
  
  func onDelete(indices: IndexSet) {
    guard let index = indices.first else { return }
    if index > products.count { return }
    deleteProduct(products[index].id!) // TODO: don't ! here
  }
  
    func onTap(_ productId: Int64) {
//      addProductToList(productId)
      print("product tapped")
    }
  
  var body: some View {
    List {
      ForEach(products) { p in
        Button(action: { self.onTap(p.id!) }) {
          HStack {
            Text("\(p.id!):")
            Text(p.name)
            Spacer()
            Text(String(p.price))
          }
        }
      }.onDelete(perform: onDelete)
    }
  }
  
  //  var body: some View {
  //    return List {
  //      ForEach(products, id: \.id!) { p in
  //        Button(action: { self.onTap(p.id) }) {
  //          HStack {
  //            Text("\(p.id!):")
  //            Text(p.name)
  //            Spacer()
  //            Text(String(p.price))
  //          }
  //        }
  //      }
  //      .onDelete(perform: onDelete)
  //    }
  //  }
}
