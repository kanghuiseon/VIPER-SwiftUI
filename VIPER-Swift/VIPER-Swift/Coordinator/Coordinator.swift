//
//  Coordinator.swift
//  VIPER-Swift
//
//  Created by 강희선 on 2022/12/03.
//

import Foundation
import Combine

protocol Coordinator {
    func start() -> AnyPublisher<Void, Never>
}

extension Coordinator {
    @discardableResult
    func coordinate(
        to coordinator: some Coordinator
    ) -> AnyPublisher<Void, Never> {
        return coordinator.start()
    }
}
