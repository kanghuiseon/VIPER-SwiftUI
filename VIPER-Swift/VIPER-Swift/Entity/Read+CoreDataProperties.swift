//
//  Read+CoreDataProperties.swift
//  
//
//  Created by 강희선 on 2022/11/21.
//
//

import Foundation
import CoreData


extension Read {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Read> {
        return NSFetchRequest<Read>(entityName: "Read")
    }

    @NSManaged public var rating: Float
    @NSManaged public var start_date: Date?
    @NSManaged public var end_date: Date?
    @NSManaged public var user_id: User?
    @NSManaged public var book_id: Book?

}
