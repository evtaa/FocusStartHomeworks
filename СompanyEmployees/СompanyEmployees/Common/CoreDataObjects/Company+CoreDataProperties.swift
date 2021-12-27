//
//  Company+CoreDataProperties.swift
//  СompanyEmployees
//
//  Created by Alexandr Evtodiy on 19.12.2021.
//
//

import Foundation
import CoreData


extension Company {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Company> {
        return NSFetchRequest<Company>(entityName: "Company")
    }

    @NSManaged public var name: String
    @NSManaged public var uid: UUID
    @NSManaged public var employee: NSSet?

}

// MARK: Generated accessors for employee
extension Company {

    @objc(addEmployeeObject:)
    @NSManaged public func addToEmployee(_ value: Employee)

    @objc(removeEmployeeObject:)
    @NSManaged public func removeFromEmployee(_ value: Employee)

    @objc(addEmployee:)
    @NSManaged public func addToEmployee(_ values: NSSet)

    @objc(removeEmployee:)
    @NSManaged public func removeFromEmployee(_ values: NSSet)

}

extension Company : Identifiable {

}
