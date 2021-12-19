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
    
    init(uid: UUID, companyUid: UUID, name: String, age: Int, experience: Int?) {
        self.uid = uid
        self.companyUid = companyUid
        self.name = name
        self.age = age
        self.experience = experience
    }
    
    init?(employee: Employee) {
        guard let companyUid = employee.company?.uid
        else { return nil }
        self.uid = employee.uid
        self.companyUid = companyUid
        self.name = employee.name
        self.age = Int(employee.age)
        self.experience = Int(employee.experience)
    }
    
    func update(name: String, age: Int, experience: Int?) {
        self.name = name
        self.age = age
        self.experience = experience
    }
}
