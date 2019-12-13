//
//  String.swift
//  SwiftShop
//
//  Created by Geordie Powers on 2019-12-13.
//  Copyright © 2019 Geordie Powers. All rights reserved.
//

extension String {
  func truncate(at: Int, append: String = "…") -> String {
    self.count > at - 1
      ? self.prefix(at - 1) + append
      : self
  }
}
