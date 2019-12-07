//
//  ListsPage.swift
//  SwiftShop
//
//  Created by Geordie Powers on 2019-11-16.
//  Copyright © 2019 Geordie Powers. All rights reserved.
//

//import SwiftUI
//import SwiftDux

//struct ListsPage: View {
//  @MappedState private var props: Props
//  @MappedDispatch() private var dispatch
//
//  func onToggleComplete(_ productId: String, _ complete: Bool) {
//    if complete {
//      self.dispatch(AppAction.UncompleteProduct(listId: AppConstants.DEFAULT_LIST_ID, productId: productId))
//    } else {
//      self.dispatch(AppAction.CompleteProduct(listId: AppConstants.DEFAULT_LIST_ID, productId: productId))
//    }
//  }
//
//  var productList: some View {
//    let statuses = props.productStates
//      .sorted(by: { (a, b) in b.complete })
//
//    return List {
//      ForEach(statuses) { pStatus in
//        Button(action: { self.onToggleComplete(pStatus.id, pStatus.complete) }) {
//          Text(self.props.products[pStatus.id]!.name)
//            .foregroundColor(pStatus.complete ? Color.secondary : Color.primary)
//        }
//      }
//    }
//  }
//
//  var body: some View {
//    return VStack {
//      HStack{
//        Text("List")
//          .font(.largeTitle).bold()
//        Spacer()
//
//        VStack(alignment: .trailing) {
//          Text("\(props.counts.0)/\(props.counts.1)")
//          Text("$\(props.cost.0) / $\(props.cost.1)")
//        }.font(.subheadline)
//      }.padding(.horizontal)
//
//      productList
//    }
//  }
//}
//
//extension ListsPage: Connectable {
//  struct Props {
//    var productStates: OrderedState<ProductStatus>
//    var products: OrderedState<Product>
//
//    var cost: (Float, Float)
//    var counts: (Int, Int)
////
////    var totalCost: Float
////    var completedCost: Float
////    var totalCount: Int
////    var completedCount: Int
//  }
//
//  func map(state: AppState) -> Props? {
//    let productStates = state.lists[AppConstants.DEFAULT_LIST_ID]!.products
//    let products = state.products
//
//    var totalCost: Float = 0.0
//    var completedCost: Float = 0.0
//    var completedCount: Int = 0
//
//    for state in productStates {
//      let p = products[state.id]!
//      totalCost += p.price
//
//      if state.complete {
//        completedCost += p.price
//        completedCount += 1
//      }
//    }
//
//    return Props(
//      productStates: productStates,
//      products: products,
//      cost: (completedCost, totalCost),
//      counts: (completedCount, productStates.count)
//    )
//  }
//}
//
//struct ConnectedListsPage: View {
//  var body: some View {
//    ListsPage().connect()
//  }
//}
