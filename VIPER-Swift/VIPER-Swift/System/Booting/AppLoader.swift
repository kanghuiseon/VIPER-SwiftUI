//
//  AppLoader.swift
//  VIPER-Swift
//
//  Created by 강희선 on 2022/09/21.
//

import UIKit
import SwiftUI
import Swinject

class AppLoader {
    let container: Container
    
    init(container: Container) {
        self.container = container
    }
    
    func load() {
        
    }
}

extension AppLoader {
    class Loader {
        func load() -> AppLoader {
            let container = Container()
            setAll(container: container)
            return .init(container: container)
        }
    }
}

extension AppLoader.Loader {
    func setAll(container: Container) {
        setRepository(container: container)
        setCoordinator(container: container)
        setPresenter(container: container)
    }
    
    func setRepository(container: Container) {
        container.register(BookRepository.self) { _ in
            return RealBookRepository()
        }
    }
    
    func setCoordinator(container: Container) {
        container.register(
            UINavigationController.self,
            name: "rootNavigationController",
            factory: { _ in
                let navigationController = UINavigationController()
                return navigationController
            }
        )
        .inObjectScope(.container)
        
        container.register(OnBoardingCoordinator.self) { _ in
            return RealOnBoardingCoordinator(container)
        }
        
        container.register(MainTabCoordinator.self) { _ in
            return RealMainTabCoordinator(container: container)
        }
        container.register(HomeCoordinator.self) { _ in 
            return RealHomeCoordinator(
                container: container
            )
        }
    }
    
    func setPresenter(container: Container) {
        container.register(OnBoardingPresenter.self) { _ in
            return RealOnBoardingPresenter(container: container)
        }
        
        container.register(HomePresenter.self) { _ in 
            return RealHomePresenter(container)
        }
    }
}
