//
//  AppModel.swift
//  SwiftShop
//
//  Created by Geordie Powers on 2019-12-07.
//  Copyright © 2019 Geordie Powers. All rights reserved.
//

import UIKit
import Combine
import GRDB
import GRDBCombine

struct AppModel {
  private let database: () -> DatabaseWriter
  init(database: @escaping () -> DatabaseWriter) {
    self.database = database
  }
  
  func products() -> ProductRepository { ProductRepository(database()) }
}
