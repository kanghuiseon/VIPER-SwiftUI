//
//  ModuleFactory.swift
//  VIPER-Swift
//
//  Created by 강희선 on 2022/09/21.
//

import Foundation
import UIKit

protocol Module {
    /// interactor, presenter, router, view를 모듈로 합칩니다.
    func combine() -> UIViewController
}

protocol ModuleFactory {
    /// authentication module 을 만듭니다.
    func makeAuthentication() -> Module
    /// home tab module 을 만듭니다.
    func makeHome() -> Module
    /// library tab module 을 만듭니다.
    func makeLibrary() -> Module
    /// charactor module을 만듭니다.
    func makeCharactor() -> Module
    /// history module 을 만듭니다.
    func makeHistory() -> Module
    /// profile module 을 만듭니다.
    func makeProfile() -> Module
}

//class RealModuleFactory: ModuleFactory {
//    let container: DIContainer
//
//    init(container: DIContainer) {
//        self.container = container
//    }
//
//    func makeAuthentication() -> Module {
//
//    }
//
//    func makeHome() -> Module {
//
//    }
//
//    func makeLibrary() -> Module {
//
//    }
//
//    func makeCharactor() -> Module {
//
//    }
//
//    func makeHistory() -> Module {
//
//    }
//
//    func makeProfile() -> Module {
//
//    }
//}
