//
//  AppCoordinator.swift
//  VIPER-Swift
//
//  Created by 강희선 on 2022/12/03.
//

import Foundation
import SwiftUI
import UIKit
import Combine

class AppCoordinator: Coordinator {
    let window: UIWindow
    var appLoader: AppLoader?
    
    init(window: UIWindow) {
        self.window = window
    }
    
    func start() -> AnyPublisher<Void, Never> {
        self.appLoader = AppLoader.Loader().load()
        let container = appLoader!.container
        
        let navigationController = container.resolve(
            UINavigationController.self,
            name: "rootNavigationController"
        )!
        
        window.rootViewController = navigationController
        window.makeKeyAndVisible()
        
        let onBoardingCoordinator = container.resolve(OnBoardingCoordinator.self)!
        
        return coordinate(to: onBoardingCoordinator)
    }
}
