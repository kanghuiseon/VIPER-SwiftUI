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
        if let windowScene = scene as? UIWindowScene {
            let appLoader = AppLoader(windowScene: windowScene)
            let window = appLoader.load()
            self.window = window
        }
    }
}
