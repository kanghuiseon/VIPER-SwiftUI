//
//  HomePresenter.swift
//  VIPER-Swift
//
//  Created by 강희선 on 2022/09/02.
//

import Foundation

protocol HomePresenterDelegate: PresenterDelegate {
    func getBookList()
}
    
protocol HomePresenter {
    func setDelegate(_ delegate: HomePresenterDelegate)
}

class RealHomePresenter: HomePresenter {
    let homeInteractor: HomeInteractor
    let homeRouter: HomeRouter
    private weak var delegate: HomePresenterDelegate?
    
    init(
        homeInteractor: HomeInteractor,
        homeRouter: HomeRouter
    ) {
        self.homeInteractor = homeInteractor
        self.homeRouter = homeRouter
    }
    
    func setDelegate(_ delegate: HomePresenterDelegate) {
        self.delegate = delegate
    }
}

struct MockHomePresenter: HomePresenter {
    func setDelegate(_ delegate: HomePresenterDelegate) {
        
    }
}
