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

    var body: some View {
        HStack {
            Button(action: addSearchFilter) {
                Text("Add ir filter")
            }
            
            Spacer()
            
            Button(action: removeSearchFilter) {
                Text("Remove ir filter")
            }
        }.padding()
    }
    
    func addSearchFilter() {
        filterManager.upsert("SEARCH", { $0.name.contains("ir") })
    }
    
    func removeSearchFilter() {
        filterManager.remove("SEARCH")
    }
}

//struct ProductFilterBar_Previews: PreviewProvider {
//    static var previews: some View {
//        ProductFilterBar()
//    }
//}
