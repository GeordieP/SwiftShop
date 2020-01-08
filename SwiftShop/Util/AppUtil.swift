//
//  AppUtil.swift
//  SwiftShop
//
//  Created by Geordie Powers on 2019-12-13.
//  Copyright © 2019 Geordie Powers. All rights reserved.
//

import Foundation

struct AppUtil {
  static func toPriceString(_ price: Double) -> String {
    let priceFormatter = NumberFormatter()
    priceFormatter.numberStyle = .currency
    
    return priceFormatter.string(from: price as NSNumber) ?? String("$\(price)")
  }
}
