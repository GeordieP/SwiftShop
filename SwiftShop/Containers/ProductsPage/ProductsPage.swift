//
//  ProductsPage.swift
//  SwiftShop
//
//  Created by Geordie Powers on 2019-11-16.
//  Copyright © 2019 Geordie Powers. All rights reserved.
//

import SwiftUI
import SwiftDux

struct ProductsPage: View {
  @MappedState private var props: Props
  @MappedDispatch() private var dispatch
  @ObservedObject private var filters = FilterManager<Product>()

  func createProduct(name: String, price: Float) {
    self.dispatch(AppAction.CreateProduct(name: name, price: price))
  }
  
  func deleteProduct(id: String) {
    self.dispatch(AppAction.DeleteProduct(id: id))
  }
  
  func addProductToList(id: String) {
    self.dispatch(AppAction.AddProductToList(productId: id, listId: AppConstants.DEFAULT_LIST_ID))
  }
  
  var body: some View {
    VStack() {
      AddProductForm(onSubmit: createProduct).frame(height: 220.0)
      ProductFilterBar(filterManager: filters)
      ProductListView(
        products: filters.apply(to: props.products.values),
        addProductToList: addProductToList,
        deleteProduct: deleteProduct
      )
    }
  }
}

extension ProductsPage: Connectable {
  struct Props {
    var products: OrderedState<Product>
  }
  
  func map(state: AppState) -> Props? {
    Props(products: state.products)
  }
}

struct ConnectedProductsPage: View {
  var body: some View {
    ProductsPage().connect()
  }
}
