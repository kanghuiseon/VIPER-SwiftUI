//
//  SceneDelegate.swift
//  VIPER-Swift
//
//  Created by 강희선 on 2022/09/02.
//

import UIKit
import SwiftUI

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?
    
    func scene(
        _ scene: UIScene,
        willConnectTo session: UISceneSession,
        options connectionOptions: UIScene.ConnectionOptions
    ) {
        let login = LoginView()
        
        if let windowScene = scene as? UIWindowScene {
            let window = UIWindow(windowScene: windowScene)
            window.rootViewController = UIHostingController(rootView: login)
            self.window = window
            window.makeKeyAndVisible()
        }
    }
}
