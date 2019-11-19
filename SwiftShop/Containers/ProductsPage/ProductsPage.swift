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
    @ObservedObject private var filterer = Filterer<Product>()

    init() {
        filterer.addFilter(name: "SEARCH", filterFn: { product in product.name.contains("ir") } )
    }

    func createProduct(name: String, price: Float) {
        self.dispatch(ProductsAction.AddProduct(name: name, price: price))
    }
    
//    func moveProduct(from: IndexSet, to: Int) {
//        self.dispatch(ProductsAction.MoveProduct(from: from, to: to))
//    }

    func deleteProduct(in offset: IndexSet) {
        self.dispatch(ProductsAction.RemoveProduct(at: offset))
    }

    var body: some View {
        let filteredProducts = filterer.applyFilters(props.products.values)
        return VStack(alignment: .leading) {
            AddProductForm(onSubmit: createProduct)
                .frame(height: 220.0)

            List {
                ForEach(filteredProducts) { product in
                    HStack {
                        Text(product.name)
                        Spacer()
                        Text(String(product.price))
                    }
                }
                .onDelete(perform: deleteProduct)
                // .onMove(perform: moveProduct)
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
