//
//  DIContainer.swift
//  
//
//  Created by 강희선 on 2022/09/03.
//

import Foundation

public class Container {
    init() {
        
    }
    
    func register<T>(type: T.Type, name: String? = nil, factory: Factory<T>) {
        
    }
    
//    func resolve<T>(type: T.Type) -> Factory<T>? {
//
//    }
}

// 한 팩토리당 하나의 변수 혹은 인스턴스
struct Factory<T> {
    private let goods: T
    
    init(_ factory: @escaping () -> T) {
        goods = factory()
    }
}

extension Container {

}
