//
//  HomeInteractor.swift
//  VIPER-Swift
//
//  Created by 강희선 on 2022/09/20.
//

import Foundation
import Combine

struct BookResponse {
    
}

protocol HomeInteractorDelegate: AnyObject {
    
}

protocol HomeInteractor {
    /// delegate setting
    func setDelegate(_ delegate: HomeInteractorDelegate)
    /// 읽은 책리스트 가져오기
    func getBookList() -> AnyPublisher<BookResponse, Error>
}

class RealHomeInteractor: HomeInteractor {
    
    private weak var delegate: HomeInteractorDelegate?
    
    func setDelegate(_ delegate: HomeInteractorDelegate) {
        self.delegate = delegate
    }
    
    func getBookList() -> AnyPublisher<BookResponse, Error> {
        Future<BookResponse, Error> { promise in
            
        }
        .eraseToAnyPublisher()
    }
}

class MockHomeInteractor: HomeInteractor {
    func setDelegate(_ delegate: HomeInteractorDelegate) {
        
    }
    
    func getBookList() -> AnyPublisher<BookResponse, Error> {
        Future<BookResponse, Error> { promise in
            
        }
        .eraseToAnyPublisher()
    }
}
