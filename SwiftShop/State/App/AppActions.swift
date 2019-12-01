//
//  AppActions.swift
//  SwiftShop
//
//  Created by Geordie Powers on 2019-11-27.
//  Copyright © 2019 Geordie Powers. All rights reserved.
//

import Foundation
import SwiftDux

enum AppAction: Action {
  case CreateProduct(name: String, price: Float)
    // products.addproduct
  case UpdateProduct(updatedProduct: Product)
    // products.updateProduct
  case DeleteProduct(id: String)
    // products.removeProduct
    // productStatus.deleteProduct
  case MoveProduct(from: IndexSet, to: Int)
  // TODO TODO
  // TODO TODO "move" in what context? am I moving it in a list? in the products tab?
  // TODO TODO should this action be a ProductsAction, since it only applies to the products tab?
  // TODO TODO
  
  case CreateList(name: String)
    // lists.addlist
    // productStatus.addList? is it worth adding this before any products are added?
  case UpdateList(updatedList: ProductsList)
    // lists.updatelist
  case DeleteList(id: String)
    // lists.deletelist
    // productStatus.deleteList
  
//  case CreateTag(name: String, color: String)
    // tags.addtag
//  case UpdateTag(updatedTag: nil)
    // tags.updateTag
  //  case DeleteTag(id: String)
  // tags.removeTag

  case TagProduct(productId: String, tagId: String)
    // products.addtag
  case UntagProduct(productId: String, tagId: String)
    // products.removetag
  
  case AddProductToList(productId: String, listId: String)
  // lists.addtolist
  case RemoveProductFromList(productId: String, listId: String)
  // lists.removefromlist

  case CompleteProduct(listId: String, productId: String)
    // lists.completeproduct
  case UncompleteProduct(listId: String, productId: String)
    // lists.uncompleteproduct
}
