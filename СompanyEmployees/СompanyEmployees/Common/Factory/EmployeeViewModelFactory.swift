//
//  EmployeeViewModelFactory.swift
//  СompanyEmployees
//
//  Created by Alexandr Evtodiy on 15.12.2021.
//

import Foundation

final class EmployeeViewModelFactory {
    static func create(from employee: EmployeeModel) -> IEmployeeViewModel? {
        let name = employee.name
        let experienceModel: String
        if let experience = employee.experience {
            experienceModel = String(experience)
        } else {
            experienceModel = "0"
        }
        let age = String(employee.age)
        return EmployeeViewModel(name: name,
                                 age: age,
                                 experience: experienceModel)
    }
}
