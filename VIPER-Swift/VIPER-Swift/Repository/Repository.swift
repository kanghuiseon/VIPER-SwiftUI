//
//  Repository.swift
//  VIPER-Swift
//
//  Created by 강희선 on 2022/11/21.
//

import Foundation
import UIKit
import Combine

protocol BookRepository {
    func getBookList() -> [Book]
    func addNewBook(title: String, writer: String) -> AnyPublisher<Void, Never>
}

class RealBookRepository: BookRepository {
    let coreDataStack = CoreDataStack(modelName: "BookJeok")
    
    func getBookList() -> [Book] {
        let fetchRequest = Book.fetchRequest()
        let bookResult = coreDataStack.fetchData(fetchRequest)
        return bookResult
    }
    
    func addNewBook(title: String, writer: String) -> AnyPublisher<Void, Never> {
        let book = Book(context: coreDataStack.managedContext)
        book.book_id = UUID()
        book.title = title
        book.writer = writer
        book.height = Int32(Int.random(in: 5...15))
        book.image_name = ""
        book.x = Float.random(in: -10...10)
        book.color = UIColor.red
        coreDataStack.saveContext()
        
        return Just(())
            .eraseToAnyPublisher()
    }
}
