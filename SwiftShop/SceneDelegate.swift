//
//  SceneDelegate.swift
//  SwiftShop
//
//  Created by Geordie Powers on 2019-11-16.
//  Copyright © 2019 Geordie Powers. All rights reserved.
//

import UIKit
import SwiftUI

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
  var window: UIWindow?

  func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
    let rootView = ContentView()
    
    if let windowScene = scene as? UIWindowScene {
      let window = UIWindow(windowScene: windowScene)
      window.rootViewController = UIHostingController(rootView: rootView)
      self.window = window
      window.makeKeyAndVisible()
    }
  }
  
  func sceneDidDisconnect(_ scene: UIScene) { }
  func sceneDidBecomeActive(_ scene: UIScene) { }
  func sceneWillResignActive(_ scene: UIScene) { }
  func sceneWillEnterForeground(_ scene: UIScene) { }
  func sceneDidEnterBackground(_ scene: UIScene) { }
}

