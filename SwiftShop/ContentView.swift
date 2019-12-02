//
//  ContentView.swift
//  SwiftShop
//
//  Created by Geordie Powers on 2019-11-16.
//  Copyright © 2019 Geordie Powers. All rights reserved.
//

import SwiftUI

struct ContentView: View {
  @State private var selection = 0
  
  var body: some View {
    TabView(selection: $selection){
      ConnectedListsPage()
        .tabItem {
          VStack {
            Image("first")
            Text("List")
          }
      }
      .tag(0)
      
      ConnectedProductsPage()
        .tabItem {
          VStack {
            Image("second")
            Text("Products")
          }
      }
      .tag(1)
      
      TagsPage()
        .tabItem {
          VStack {
            Image("first")
            Text("Tags")
          }
      }
      .tag(2)
      
      SettingsPage()
        .tabItem {
          VStack {
            Image("second")
            Text("Settings")
          }
      }
      .tag(3)
    }
  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView()
  }
}
