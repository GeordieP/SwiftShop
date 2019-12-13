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
      ProductListPage()
        .tabItem {
          VStack {
            Image(systemName: "bag")
            Text("List")
          }
      }
      .tag(0)
      
      ProductPage()
        .tabItem {
          VStack {
            Image(systemName: "list.bullet")
            Text("Products")
          }
      }
      .tag(1)
      
      TagPage()
        .tabItem {
          VStack {
            Image(systemName: "tag")
            Text("Tags")
          }
      }
      .tag(2)
      
      SettingsPage()
        .tabItem {
          VStack {
            Image(systemName: "gear")
            Text("Settings")
          }
      }
      .tag(3)
      
      TESTVIEW()
        .tabItem {
          VStack {
            Image(systemName: "exclamationmark.triangle")
            Text("Debug")
          }
      }
      .tag(4)
    }
  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView()
  }
}
