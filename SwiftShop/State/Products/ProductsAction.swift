//
//  ProductsAction.swift
//  SwiftShop
//
//  Created by Geordie Powers on 2019-11-16.
//  Copyright © 2019 Geordie Powers. All rights reserved.
//

import Foundation
import SwiftDux

enum ProductsAction: Action {
  case AddProduct(name: String, price: Float /* tagIds */)
  case RemoveProduct(at: IndexSet)
  case SetProduct(at: Int, product: Product)
  case MoveProduct(from: IndexSet, to: Int)
}

//extension ProductsAction {
//    TODO
//
//    static func safeRemoveProduct(at: Int) -> ActionPlan<AppState> {
//        ActionPlan { store in
//            store.send(/*remove product from all lists*/)
//            store.send(/*remove product */)
//        }
//    }
//}
