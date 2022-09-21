//
//  HomeRouter.swift
//  VIPER-Swift
//
//  Created by 강희선 on 2022/09/16.
//

import Foundation

protocol HomeRouter {
    /// 책 상세보기 이동
    func goDetail()
}

class RealHomeRouter: HomeRouter {
    func goDetail() {
        
    }
}

class MockHomeRouter: HomeRouter {
    func goDetail() {
        
    }
}
