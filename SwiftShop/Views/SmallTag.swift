//
//  SmallTag.swift
//  SwiftShop
//
//  Created by Geordie Powers on 2019-12-13.
//  Copyright © 2019 Geordie Powers. All rights reserved.
//

import SwiftUI

let MAX_TAG_NAME_LENGTH = 14

struct SmallTag: View {
  var tag: Tag
  
  var body: some View {
    Text(tag.name.truncate(at: MAX_TAG_NAME_LENGTH))
      .font(.caption)
      .padding(.horizontal, 5)
      .padding(.vertical, 1)
      .overlay(Self.tagShape)
  }
  
  private static var tagShape: some View {
    RoundedRectangle(cornerRadius: 7).stroke(Color.blue, lineWidth: 1)
  }
}

struct SmallTag_Previews: PreviewProvider {
  static var previews: some View {
     VStack {
      Group {
        SmallTag(tag: Tag(id: 1, name: "", color: "red"))
        SmallTag(tag: Tag(id: 1, name: "Test Tag", color: "blue"))
        SmallTag(tag: Tag(id: 1, name: "Tag with long name", color: "green"))
      }.padding(5)
    }
  }
}
