//
//  AppLoader.swift
//  VIPER-Swift
//
//  Created by 강희선 on 2022/09/21.
//

import UIKit
import SwiftUI
  
class AppLoader {
    private let window: UIWindow
    private let navigation: UINavigationController
    
    init(windowScene: UIWindowScene) {
        self.window = UIWindow(windowScene: windowScene)
        self.navigation = UINavigationController()
    }
    
    func load() -> UIWindow {
        let vc = UIHostingController(rootView: MainTab())
        window.rootViewController = vc
        window.makeKeyAndVisible()
        return window
    }
}
