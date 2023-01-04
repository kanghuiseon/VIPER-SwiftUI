//
//  User+CoreDataProperties.swift
//  
//
//  Created by 강희선 on 2022/11/21.
//
//

import Foundation
import CoreData


extension User {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<User> {
        return NSFetchRequest<User>(entityName: "User")
    }

    @NSManaged public var user_id: UUID?
    @NSManaged public var name: String?
    @NSManaged public var email: String?
    @NSManaged public var read: Read?

}
