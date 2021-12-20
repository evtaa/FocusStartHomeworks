//
//  Employee.swift
//  СompanyEmployees
//
//  Created by Alexandr Evtodiy on 15.12.2021.
//

import Foundation

final class EmployeeModel {
    let uid: UUID
    let companyUid: UUID
    private(set) var name: String
    private(set) var age: Int
    private(set) var experience: Int?
    
    init(companyUid: UUID, name: String, age: Int, experience: Int?) {
        self.uid = UUID()
        self.companyUid = companyUid
        self.name = name
        self.age = age
        self.experience = experience
    }
    
    init?(employee: Employee) {
        self.uid = employee.uid
        self.companyUid = employee.company.uid
        self.name = employee.name
        self.age = Int(employee.age)
        if let experience = employee.experience {
            self.experience = Int(truncating: experience)
        } else {
            self.experience = nil
        }
    }
    
    func update(name: String, age: Int, experience: Int?) {
        self.name = name
        self.age = age
        self.experience = experience
    }
}
