//
//  Router.swift
//  VIPER-Swift
//
//  Created by 강희선 on 2022/11/21.
//

import Foundation
import Swinject
import UIKit
import SwiftUI
import Combine

protocol HomeCoordinator: AnyObject, Coordinator {
    func pushToBookDetail(bookID: Int)
    func pushToAddBook()
    func popAddBook()
}

class RealHomeCoordinator: HomeCoordinator {
    private let container: Container
    let navigationController: UINavigationController
    
    init(container: Container) {
        self.container = container
        self.navigationController = container.resolve(
            UINavigationController.self,
            name: "rootNavigationController"
        )!
    }
    
    func start() -> AnyPublisher<Void, Never> {
        let home = HomeView(.init(container: container))
        let vc = UIHostingController(rootView: home)
        navigationController.pushViewController(vc, animated: true)
        
        return Empty(completeImmediately: false)
            .eraseToAnyPublisher()
    }
    
    func pushToBookDetail(bookID: Int) {
        let detailView = UIHostingController(rootView: BookDetailView(.init(bookId: bookID)))
        navigationController.pushViewController(detailView, animated: true)
    }
    
    func pushToAddBook() {
        let addView = UIHostingController(rootView: AddBookView(.init(container)))
        navigationController.pushViewController(addView, animated: true)
    }
    
    func popAddBook() {
        navigationController.popViewController(animated: true)
    }
}
