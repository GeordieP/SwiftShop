//
//  ProductFilterBar.swift
//  SwiftShop
//
//  Created by Geordie Powers on 2019-11-18.
//  Copyright © 2019 Geordie Powers. All rights reserved.
//

import SwiftUI

struct ProductFilterBar: View {
  var filterManager: FilterManager<Product>
  @State private var searchValue: String = "";
  
  private func setSearch(_ fieldValue: String) {
    defer { self.searchValue = fieldValue }
    
    if fieldValue.count == 0 {
      self.filterManager.remove("SEARCH")
      return
    }
    
    self.filterManager.upsert("SEARCH", { product in
      product.name
        .lowercased()
        .contains(fieldValue.lowercased())
    })
  }

  var body: some View {
    let boundSearchValue = Binding<String>(get: { self.searchValue }, set: self.setSearch)
    
    return HStack {
      TextField("Search for a product name", text: boundSearchValue)
    }.padding()
  }
}
