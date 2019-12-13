//
//  ProductPage.swift
//  SwiftShop
//
//  Created by Geordie Powers on 2019-12-13.
//  Copyright © 2019 Geordie Powers. All rights reserved.
//

import SwiftUI
import Combine

class ProductPageViewModel : ObservableObject {
  @Published var products: [SimpleProduct] = []
  private var cancellables: [AnyCancellable] = []
  
  init() {
    App
      .products()
      .productPublisher()
      .fetchOnSubscription()
      .catch { _ in Empty() }
      .sink { self.products = $0 }
      .store(in: &cancellables)
  }
}

struct ProductPage: View {
  @ObservedObject private var model: ProductPageViewModel = ProductPageViewModel()
  
  var body: some View {
    VStack {
      Text("Products").font(.title)
      
      List(model.products) { p in
        ProductRow(product: p)
      }
    }
  }
}

struct ProductPage_Previews: PreviewProvider {
  static var previews: some View {
    ProductPage()
  }
}
