//
//  Products.swift
//  SwiftShop
//
//  Created by Geordie Powers on 2019-11-16.
//  Copyright © 2019 Geordie Powers. All rights reserved.
//

import Foundation
import SwiftDux

struct Product: IdentifiableState {
    var id: String
    var name: String
    var price: Float
    // var tagIds
}
