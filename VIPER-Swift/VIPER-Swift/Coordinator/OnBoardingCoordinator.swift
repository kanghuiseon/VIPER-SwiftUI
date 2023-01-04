//
//  OnboardingCoordinator.swift
//  VIPER-Swift
//
//  Created by 강희선 on 2022/12/03.
//

import Foundation
import Swinject
import SwiftUI
import UIKit
import Combine

protocol OnBoardingCoordinator: Coordinator {
    func pushToHome()
}

class RealOnBoardingCoordinator: OnBoardingCoordinator {
    private let container: Container
    let navigationController: UINavigationController
    
    init(_ container: Container) {
        self.container = container
        self.navigationController = container.resolve(
            UINavigationController.self,
            name: "rootNavigationController"
        )!
    }
    
    
    func start() -> AnyPublisher<Void, Never> {
        let onBoarding = OnBoarding(vm: .init(container))
        let vc = UIHostingController(rootView: onBoarding)
        navigationController.pushViewController(vc, animated: true)
        return Empty(completeImmediately: false)
            .eraseToAnyPublisher()
    }
    
    func pushToHome() {
        let coordinator = container.resolve(MainTabCoordinator.self)!
        coordinate(to: coordinator)
    }
}
