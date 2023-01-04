//
//  Book+CoreDataProperties.swift
//  
//
//  Created by 강희선 on 2022/11/21.
//
//

import Foundation
import CoreData


extension Book {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Book> {
        return NSFetchRequest<Book>(entityName: "Book")
    }

    @NSManaged public var title: String?
    @NSManaged public var writer: String?
    @NSManaged public var book_id: UUID?
    @NSManaged public var image_name: String?
    @NSManaged public var x: Float
    @NSManaged public var height: Int32
    @NSManaged public var color: NSObject?
    @NSManaged public var read: Read?
}
