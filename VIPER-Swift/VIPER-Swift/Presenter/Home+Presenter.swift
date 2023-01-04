//
//  Home+Presenter.swift
//  VIPER-Swift
//
//  Created by 강희선 on 2022/11/21.
//

import Foundation
import Swinject
import SwiftUI
import Combine

protocol HomeViewDelegate: AnyObject {
    func displayBookList(_ bookList: [HomeView.BookModel])
}
    
protocol HomePresenter {
    func fetchBookList()
    func pushToAddNewBook()
    func addNewBook(title: String, writer: String)
}

class RealHomePresenter: HomePresenter {
    private let container: Container
    private let coordinator: HomeCoordinator
    private var cancellables = Set<AnyCancellable>()
    
    let repo: BookRepository
    weak var delegate: HomeViewDelegate?
    
    init(_ container: Container) {
        self.container = container
        self.repo = container.resolve(BookRepository.self)!
        self.coordinator = container.resolve(HomeCoordinator.self)!
    }
    
    func setDelegate(_ delegate: HomeViewDelegate?) {
        self.delegate = delegate
    }
    
    func fetchBookList() {
        let bookList = repo.getBookList()
        let books = bookList
            .map { HomeView.BookModel(
                id: $0.book_id ?? UUID(),
                name: $0.title ?? "",
                imageName: $0.image_name ?? "",
                writer: $0.writer ?? "",
                rating: 0,
                x: CGFloat($0.x),
                height: CGFloat($0.height),
                color: Color($0.color as! UIColor)
            )}
        delegate?.displayBookList(books)
    }
    
    func pushToAddNewBook() {
        coordinator.pushToAddBook()
    }
    
    func addNewBook(title: String, writer: String) {
        repo.addNewBook(title: title, writer: writer)
            .sink(receiveValue: { [weak self] _ in
                self?.coordinator.popAddBook()
            })
            .store(in: &cancellables)
    }
}

