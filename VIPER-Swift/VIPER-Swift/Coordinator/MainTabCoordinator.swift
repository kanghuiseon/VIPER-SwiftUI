//
//  MainTabCoordinator.swift
//  VIPER-Swift
//
//  Created by 강희선 on 2022/12/04.
//

import Foundation
import Swinject
import SwiftUI
import Combine

protocol MainTabCoordinator: Coordinator {
    
}

class RealMainTabCoordinator: MainTabCoordinator {
    private let container: Container
    private let navigationController: UINavigationController
    
    init(container: Container) {
        self.container = container
        self.navigationController = container.resolve(
            UINavigationController.self,
            name: "rootNavigationController"
        )!
    }
    
    func start() -> AnyPublisher<Void, Never> {
        let main = MainTab(container)
        let vc = UIHostingController(rootView: main)
        vc.navigationItem.hidesBackButton = true
        navigationController.pushViewController(vc, animated: true)
        
        return Empty(completeImmediately: false)
            .eraseToAnyPublisher()
    }
}
