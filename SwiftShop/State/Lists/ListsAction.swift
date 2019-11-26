//
//  ListsAction.swift
//  SwiftShop
//
//  Created by Geordie Powers on 2019-11-26.
//  Copyright © 2019 Geordie Powers. All rights reserved.
//

import Foundation
import SwiftDux

enum ListsAction: Action {
  case AddList(name: String)
  case RemoveList(id: String)
  case SetList(id: String, list: List)
  case MoveList(from: IndexSet, to: Int)
}
