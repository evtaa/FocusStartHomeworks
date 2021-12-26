//
//  User+CoreDataProperties.swift
//  CurrencyConverter
//
//  Created by Alexandr Evtodiy on 23.12.2021.
//
//

import Foundation
import CoreData


extension User {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<User> {
        return NSFetchRequest<User>(entityName: "User")
    }

    @NSManaged public var username: String
    @NSManaged public var password: String
    @NSManaged public var uid: UUID

}

extension User : Identifiable {

}
