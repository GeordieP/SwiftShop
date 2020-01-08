//
//  ToggleableTag.swift
//  SwiftShop
//
//  Created by Geordie Powers on 2019-12-15.
//  Copyright © 2019 Geordie Powers. All rights reserved.
//

import SwiftUI

struct ToggleableTag: View {
  var tag: Tag
  var selected = false
  
  var body: some View {
    VStack(alignment: .leading) {
        Text(tag.name.truncate(at: MAX_TAG_NAME_LENGTH))
          .bold()
      
      Text("\(tag.productCount ?? 0) products")
        .font(.subheadline)
        .foregroundColor(.gray)
    }
    .frame(width: 120, alignment: .leading)
    .padding(6)
    .overlay(Self.tagShape)
    .background(self.selected ? Self.background : nil)
  }

  private static var tagShape: some View {
    RoundedRectangle(cornerRadius: 7)
      .stroke(Color.blue, lineWidth: 2) // TODO: use tag color
  }
  
  private static var background: some View {
    Rectangle()
      .foregroundColor(Color.blue) // TODO: use tag color
      .opacity(0.1)
  }
}

struct ToggleableTag_Previews: PreviewProvider {
  static var previews: some View {
    VStack(alignment: .leading) {
      Group {
        Text("Normal").foregroundColor(.gray)
        ToggleableTag(
          tag: Tag(id: 0, name: "Normal Tag", color: "blue", productCount: 3)
        )

        Text("Normal Selected").foregroundColor(.gray)
        ToggleableTag(
          tag: Tag(id: 0, name: "Selected Tag", color: "blue", productCount: 3),
          selected: true
        )
        
        Text("Name truncation").foregroundColor(.gray)
        ToggleableTag(
          tag: Tag(id: 0, name: "Tag with a long name", color: "red", productCount: 5)
        )
        
        Text("Default product count").foregroundColor(.gray)
        ToggleableTag(
          tag: Tag(id: 0, name: "Unused Tag", color: "green")
        )
      }.padding(5)
    }
  }
}
