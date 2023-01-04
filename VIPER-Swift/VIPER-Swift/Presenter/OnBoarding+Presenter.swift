//
//  OnBoarding+Presenter.swift
//  VIPER-Swift
//
//  Created by 강희선 on 2022/12/04.
//

import Foundation
import Swinject
import SwiftUI
import UIKit
import Combine

protocol OnBoardingDelegate: AnyObject {
    
}

protocol OnBoardingPresenter {
    func pushToMain()
}

class RealOnBoardingPresenter: OnBoardingPresenter {
    private let container: Container
    private var cancellables = Set<AnyCancellable>()
    
    weak var delegate: OnBoardingDelegate?
    
    init(container: Container) {
        self.container = container
    }
    
    func setDelegate(_ delegate: OnBoardingDelegate) {
        self.delegate = delegate
    }
    
    func pushToMain() {
        let mainCoordinator = container.resolve(
            MainTabCoordinator.self
        )!
        
        mainCoordinator.start()
            .sink(receiveValue: { _ in })
            .store(in: &cancellables)
    }
}
