//
//  ProductRow.swift
//  SwiftShop
//
//  Created by Geordie Powers on 2019-12-13.
//  Copyright © 2019 Geordie Powers. All rights reserved.
//

import SwiftUI

struct ProductRow<P: Product>: View {
  var product: P
  var onRowClick: (P) -> Void
  
  var body: some View {
    Button(action: { self.onRowClick(self.product) }) {
      
      VStack(alignment: .leading) {
        Text(product.name.truncate(at: 45))
          .font(.headline)

        Text(AppUtil.toPriceString(product.price))
          .font(.subheadline)
          .foregroundColor(.gray)
        
        if product.tags.count > 0 {
          ScrollView(.horizontal, showsIndicators: false) {
            HStack {
              ForEach(0..<product.tags.count) { i in
                SmallTag(tag: self.product.tags[i])
              }
            }
          }
        } else {
          Text("No tags")
            .font(.caption)
            .foregroundColor(Color.gray)
        }
        
      }
    }
  }
}

struct ProductRow_Previews: PreviewProvider {
  static var previews: some View {
    let testTags = [
      Tag(id: 1, name: "BlueTag", color: "blue"),
      Tag(id: 2, name: "GreenTag", color: "green"),
      Tag(id: 3, name: "RedTag", color: "red")
    ]

    let testProducts = [
      SimpleProduct(
        id: 1,
        name: "First Product with a name that's too long for one line",
        price: 3.20,
        tags: [testTags[0], testTags[2]]
      ),
      
      SimpleProduct(
        id: 2,
        name: "Second Product",
        price: 100.00, tags: [testTags[0]]
      ),
      
      SimpleProduct(
        id: 3,
        name: "Third Product",
        price: 10.00,
        tags: [testTags, testTags, testTags].flatMap({ $0 })
      ),
      
      SimpleProduct(
        id: 4,
        name: "Product Without Tags",
        price: 10000.00, tags: []
      ),
    ]
    
    let onRowClick = { (p: SimpleProduct) in return }
    
    return List(testProducts) { p in
      ProductRow(product: p, onRowClick: onRowClick)
    }
  }
}
