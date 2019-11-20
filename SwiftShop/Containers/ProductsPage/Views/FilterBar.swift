//
//  FilterBar.swift
//  SwiftShop
//
//  Created by Geordie Powers on 2019-11-18.
//  Copyright © 2019 Geordie Powers. All rights reserved.
//

import SwiftUI

struct ProductFilterBar: View {
    var filterer: Filterer<Product>
    
    var body: some View {
        VStack {
            Button(action: addSearchFilter) {
                Text("Add ir filter")
            }
            Button(action: removeSearchFilter) {
                Text("Remove ir filter")
            }
        }
    }
    
    func addSearchFilter() {
        filterer.addFilter("SEARCH", { $0.name.contains("ir") })
    }
    
    func removeSearchFilter() {
        filterer.removeFilter("SEARCH")
    }
}

//struct FilterBar_Previews: PreviewProvider {
//    static var previews: some View {
//        FilterBar()
//    }
//}
