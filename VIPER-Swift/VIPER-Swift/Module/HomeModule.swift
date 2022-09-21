//
//  HomeModule.swift
//  VIPER-Swift
//
//  Created by 강희선 on 2022/09/21.
//

import Foundation
import UIKit
import SwiftUI

class HomeModule: Module {
    private let container: DIContainer
    private let interactor: HomeInteractor
    private let presenter: HomePresenter
    private let router: HomeRouter
    
    private let navigation: UINavigationController
    
    init(container: DIContainer) {
        self.container = container
        self.interactor = container.resolve(HomeInteractor.self)!
        self.presenter = container.resolve(HomePresenter.self)!
        self.router = container.resolve(HomeRouter.self)!
        
        self.navigation = container.resolve(UINavigationController.self)!
    }
    
    func combine() -> UIViewController {
        interactor.setDelegate(presenter)
        let vm = HomeView.ViewModel(container: container)
        presenter.setDelegate(vm)
        
        let vc = UIHostingController(rootView: HomeView(vm))
        
        return vc
    }
}
