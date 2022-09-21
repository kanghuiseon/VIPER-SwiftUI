//
//  HomePresenter.swift
//  VIPER-Swift
//
//  Created by 강희선 on 2022/09/02.
//

import Foundation
import Combine

protocol HomePresenterDelegate: PresenterDelegate {
    func renderLoading()
    func render(_ error: Error)
    func render(_ bookList: [BookModel])
}
    
protocol HomePresenter: HomeInteractorDelegate {
    func setDelegate(_ delegate: HomePresenterDelegate)
    func getBookList()
    func goDetail()
}

class RealHomePresenter: HomePresenter {
    private let interactor: HomeInteractor
    private let router: HomeRouter
    private weak var delegate: HomePresenterDelegate?
    private var cancellables = Set<AnyCancellable>()
    
    init(
        homeInteractor: HomeInteractor,
        homeRouter: HomeRouter
    ) {
        self.interactor = homeInteractor
        self.router = homeRouter
    }
    
    func setDelegate(_ delegate: HomePresenterDelegate) {
        self.delegate = delegate
    }
    
    func getBookList() {
        interactor.getBookList()
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { _ in
                
            }, receiveValue: { _ in
                
            })
            .store(in: &cancellables)
            
    }
    
    func goDetail() {
        router.goDetail()
    }
}

class MockHomePresenter: HomePresenter {
    func setDelegate(_ delegate: HomePresenterDelegate) {
        
    }
    
    func getBookList() {
        
    }
    
    func goDetail() {
        
    }
}
