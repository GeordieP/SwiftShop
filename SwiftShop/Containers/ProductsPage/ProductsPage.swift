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
        self.dispatch(ProductsAction.AddProduct(name: name, price: price))
    }
    
    func deleteProduct(in offset: IndexSet) {
        self.dispatch(ProductsAction.RemoveProduct(at: offset))
    }
    
    var body: some View {
        VStack() {
            AddProductForm(onSubmit: createProduct)
                .frame(height: 220.0)
            
            ProductFilterBar(filterManager: filters)

            List {
                ForEach(filters.apply(to: props.products.values)) { product in
                    HStack {
                        Text(product.name)
                        Spacer()
                        Text(String(product.price))
                    }
                }
                .onDelete(perform: deleteProduct)
            }
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

struct ProductsPage_Previews: PreviewProvider {
    static var previews: some View {
        ConnectedProductsPage().provideStore(Store(state: AppState(), reducer: AppReducer()))
    }
}
