//
//  SceneDelegate.swift
//  VIPER-Swift
//
//  Created by 강희선 on 2022/09/02.
//

import UIKit
import SwiftUI
import Swinject
import Combine

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?
    var cancellables = Set<AnyCancellable>()
    private var coordinator: Coordinator?
    
    func scene(
        _ scene: UIScene,
        willConnectTo session: UISceneSession,
        options connectionOptions: UIScene.ConnectionOptions
    ) {
        guard let windowScene = scene as? UIWindowScene else { return }
        
        let window = UIWindow(windowScene: windowScene)
        self.window = window
        self.coordinator = AppCoordinator(window: window)
        self.coordinator?.start()
            .sink(receiveValue: { _ in })
            .store(in: &cancellables)
    }
}
