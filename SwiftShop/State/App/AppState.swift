//
//  AppState.swift
//  SwiftShop
//
//  Created by Geordie Powers on 2019-11-16.
//  Copyright © 2019 Geordie Powers. All rights reserved.
//

import Foundation
import SwiftDux

struct AppState : StateType {
    var products: OrderedState<Product> = OrderedState()
}
